//4:1 mux
`timescale 1ns/1ps

module tb_mux_4to1;

reg [3:0] d;
reg [1:0] sel;
wire y;

mux_4to1 DUT (
    .d(d),
    .sel(sel),
    .y(y)
);

initial begin
    $monitor("Time=%0t d=%b sel=%b y=%b",
              $time, d, sel, y);

    d = 4'b1010;

    sel = 2'b00; #10;
    sel = 2'b01; #10;
    sel = 2'b10; #10;
    sel = 2'b11; #10;

    $finish;
end

endmodule

//4 bit upcounter
`timescale 1ns/1ps

module tb_up_counter;

reg clk;
reg rst;
wire [3:0] count;

up_counter DUT (
    .clk(clk),
    .rst(rst),
    .count(count)
);

// Clock generation: 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor("Time=%0t rst=%b count=%d (%b)",
              $time, rst, count, count);

    rst = 1;
    #12 rst = 0;

    #100;

    rst = 1;
    #10 rst = 0;

    #30;
    $finish;
end

endmodule

