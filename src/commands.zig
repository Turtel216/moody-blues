const std = @import("std");
const resp = @import("./resp.zig");

pub const Ping = struct {
    // execute executes the Ping command and writes it to the given writer.
    pub fn execute(_: *Ping, writer: std.io.AnyWriter) !void {
        try writer.writeAll("+PONG\r\n");
    }
};

pub const Echo = struct {
    value: resp.Value,

    // execute executes the Echo Echo command and writes it to the given writer.
    pub fn execute(self: *Echo, writer: std.io.AnyWriter) !void {
        if (self.values.len != 1) {
            return error.InvalidCommand;
        }

        try self.value.write(writer);
    }
}
