`timescale 1ns/1ps

module tb_pipeline_3stage;

reg clk;
reg rst;
reg din;

wire q1, q2, q3;

pipeline_3stage DUT (
    .clk(clk),
    .rst(rst),
    .din(din),
    .q1(q1),
    .q2(q2),
    .q3(q3)
);

// Clock generation: 10 ns period
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    rst = 1;
    din = 0;

    #12 rst = 0;

    // Apply input before rising edges
    @(negedge clk);
    din = 1;

    @(negedge clk);
    din = 0;

    @(negedge clk);
    din = 1;

    @(negedge clk);
    din = 1;

    @(negedge clk);
    din = 0;

    repeat (4) @(negedge clk);

    $finish;

end

// Monitor outputs
initial begin
    $monitor(
        "Time=%0t clk=%b rst=%b din=%b q1=%b q2=%b q3=%b",
        $time, clk, rst, din, q1, q2, q3
    );
end

endmodule

`timescale 1ns/1ps

module tb_register_swap;

reg clk;
reg rst;
reg en;

wire [3:0] A, B;

register_swap DUT (
    .clk(clk),
    .rst(rst),
    .en(en),
    .A(A),
    .B(B)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin

    rst = 1;
    en  = 0;

    #12 rst = 0;

    // Load initial values using hierarchical test setup
    @(negedge clk);
    force DUT.A = 4'd10;
    force DUT.B = 4'd5;

    @(negedge clk);
    release DUT.A;
    release DUT.B;

    en = 1;

    @(posedge clk);
    #1;

    $display("After first swap: A=%d B=%d", A, B);

    if (A !== 4'd5 || B !== 4'd10)
        $display("FAIL: First swap");
    else
        $display("PASS: First swap");

    @(negedge clk);
    en = 0;

    @(negedge clk);
    $display("Final values: A=%d B=%d", A, B);

    $finish;

end

endmodule
