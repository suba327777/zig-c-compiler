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

    const expr = args[1];
    var i: usize = 0;
    var sign: usize = 0;
    var is_first_num: bool = true;

    while (i < expr.len) {
        if (expr[i] == '+') {
            sign = 0;
            i += 1;
        }
        if (expr[i] == '-') {
            sign = 1;
            i += 1;
        }

        if (!std.ascii.isDigit(expr[i])) {
            std.debug.print("予期しない文字: '{c}'", .{expr[i]});
            return;
        }

        const start_num = i;
        while (std.ascii.isDigit(expr[i])) {
            i += 1;
        }

        if (is_first_num) {
            try stdout.print("mov x0 , #{s}\n", .{expr[start_num..i]});
            is_first_num = false;
        } else {
            if (sign == 0) {
                try stdout.print("add x0, x0, #{s}\n", .{expr[start_num..i]});
            }
            if (sign == 1) {
                try stdout.print("sub x0, x0, #{s}\n", .{expr[start_num..i]});
            }
        }
    }
    try stdout.print("ret\n", .{});
}
