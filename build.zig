const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("zigtest", "src/main.zig");
    exe.setBuildMode(mode);
    exe.install();

    const bruh_sources = [_][]const u8{
        "src/main.c",
    };

    exe.addCSourceFiles(&bruh_sources, &.{});
    exe.linkLibC();


    const trigger = b.option(i32, "trigger", "Set number of loops to trigger mega cursed bug") orelse 100;

    var i: i32 = 0;
    while (i < trigger) {
        exe.defineCMacro("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA");
        i = i+1;
    }

    // Note this is escaped
    exe.defineCMacro("FOO", "\"BAR\"");
    
    const main_tests = b.addTest("src/main.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);
}
