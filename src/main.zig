const std = @import("std");
const net = std.net;

pub fn main() !void {
    var pool: std.Thread.Pool = undefined;
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();

    try std.Thread.Pool.init(&pool, .{ .allocator = alloc, .n_jobs = 16 });

    const address = try net.Address.resolveIp("127.0.0.1", 6379);

    var listener = try address.listen(.{
        .reuse_address = true,
    });
    defer listener.deinit();

    while (true) {
        // Create connection
        const connection = try listener.accept();
        // Accept concurrent connections
        try pool.spawn(handler, .{connection});
    }
}

// Handls connection
fn handler(connection: net.Server.Connection) void {
    const reader = connection.stream.reader();

    // Read from connection
    var buffer: [1024]u8 = undefined;
    while (true) {
        const bytesRead = reader.read(&buffer) catch break;
        if (bytesRead <= 0) {
            break;
        }
        connection.stream.writeAll("+PONG\r\n") catch {
            //TODO
        };
    }
    connection.stream.close();
}
