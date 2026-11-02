`timescale 1ns/1ps

module tb_two_flop_synchronizer;

reg clk;
reg async_in;

wire sync_out;

two_flop_synchronizer DUT (
    .clk(clk),
    .async_in(async_in),
    .sync_out(sync_out)
);

// Generate 10 ns clock period
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin

    async_in = 1'b0;

    #12 async_in = 1'b1;

    #20 async_in = 1'b0;

    #17 async_in = 1'b1;

    #30 async_in = 1'b0;

    #20 $finish;

end

initial begin
    $monitor(
        "Time=%0t clk=%b async_in=%b sync_out=%b",
        $time, clk, async_in, sync_out
    );
end

endmodule

`timescale 1ns/1ps

module tb_frequency_divider_by2;

reg clk;
reg rst;

wire clk_out;

frequency_divider_by2 DUT (
    .clk(clk),
    .rst(rst),
    .clk_out(clk_out)
);

// Input clock: 10 ns period
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

initial begin

    rst = 1'b1;

    #12 rst = 1'b0;

    #100;

    $finish;

end

initial begin

    $monitor(
        "Time=%0t clk=%b rst=%b clk_out=%b",
        $time, clk, rst, clk_out
    );

end

endmodule
