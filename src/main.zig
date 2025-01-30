const std = @import("std");

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const allocator = std.heap.page_allocator;
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len <= 1) {
        std.debug.print("使用法: {s} <arg>\n", .{args[0]});
        return;
    }

    try stdout.print(".text\n", .{});
    try stdout.print(".global _main\n", .{});
    try stdout.print("_main:\n", .{});
    try stdout.print("mov x0 ,#{s}\n", .{args[1]});
    try stdout.print("ret\n", .{});
}
