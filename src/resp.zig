const std = @import("std");

// caseInnsensitiveEqual compares two strings and returns true if they are equal.
// The function ignores diffrence in casing
fn caseInsensitiveEqual(a: []const u8, b: []const u8) bool {
    if (a.len != b.len) {
        return false;
    }

    for (a, b) |a_char, b_char| {
        if (std.ascii.toLower(a_char) != std.ascii.toLower(b_char)) {
            return false;
        }
    }

    return true;
}

pub const Value = struct {};

pub const Request = struct {
    allocator: std.mem.Allocator,
    raw: Value,
    command: []const u8,
    args: []Value,

    pub fn deinit(self: Request) void {
        self.raw.deinit(self.allocator);
    }

    pub fn read(allocator: std.mem.Allocator, reader: std.io.AnyReader) !Request {}

    pub fn write(self: Request, writer: std.io.AnyWriter) !void {}

    // is checks if the given command(string) is of correct request type
    pub fn is(self: Request, command: []const u8) bool {
        return caseInsensitiveEqual(self.command, command);
    }
};
