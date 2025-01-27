const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len <= 1) {
        std.debug.print("使用法: {s} <arg>\n", .{args[0]});
        return;
    }

    std.debug.print("1つ目の引数:{s}\n", .{args[1]});
}
