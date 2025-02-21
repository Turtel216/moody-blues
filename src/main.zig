const std = @import("std");
const net = std.net;
const command = @import("./commands.zig");

pub fn main() !void {
    var pool: std.Thread.Pool = undefined;
    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    defer {
        _ = gpa.deinit();
    }
    const alloc = gpa.allocator();

    try std.Thread.Pool.init(&pool, .{ .allocator = alloc, .n_jobs = 16 });
    defer std.Thread.Pool.deinit(&pool);

    const address = try net.Address.resolveIp("127.0.0.1", 6379);

    var listener = try address.listen(.{
        .reuse_address = true,
    });
    defer listener.deinit();

    while (true) {
        // Create connection
        const connection = try listener.accept();
        // Accept concurrent connections
        try pool.spawn(handler, .{ alloc, connection });
    }
}

// Handls connection
fn handler(allocator: std.mem.Allocator, connection: net.Server.Connection) void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const arenaAlloc = arena.allocator();

    const reader = connection.stream.reader().any();
    defer connection.stream.close();

    const writer = connection.stream.writer().any();

    while (true) {
        processRequest(arenaAlloc, reader, writer) catch {
            //TODO handle error
            return;
        };
    }
}

// processRequest processes any incoming requests. The function does no handle errors, its just returns them.
fn processRequest(allocator: std.mem.Allocator, reader: std.io.AnyReader, writer: std.io.AnyWriter) !void {
    const request = ;// Take in a request

    if (request.is("ping")) {
        var ping = command.Ping{};
        return ping.execute(writer);
    }
}
