
`timescale 1ns/1ps

module tb_mod13_counter;

reg clk;
reg rst;

wire [3:0] count;

// DUT Instantiation
mod13_counter dut (
    .clk(clk),
    .rst(rst),
    .count(count)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

// Test stimulus
initial begin

    $monitor("Time=%0t rst=%b count=%d",
              $time, rst, count);

    rst = 1;
    #12;

    rst = 0;

    // Observe multiple counting cycles
    repeat(30) begin
        @(posedge clk);
        #1;
    end

    $finish;

end

endmodule

`timescale 1ns/1ps


module tb_johnson_counter;

reg clk;
reg rst;

wire [3:0] q;

// DUT Instantiation
johnson_counter dut (
.clk(clk),
.rst(rst),
.q(q)
);

// Clock generation
initial begin
clk = 0;
forever #5 clk = ~clk;
end

// Test stimulus
initial begin

$monitor("Time=%0t rst=%b q=%b",
$time, rst, q);

rst = 1;
#12;

rst = 0;

// Observe 12 clock cycles
repeat(12) begin
@(posedge clk);
#1;
end

$finish;

end

endmodule
