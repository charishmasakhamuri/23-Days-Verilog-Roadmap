
`timescale 1ns/1ps

module tb_comparator_4bit;

    reg  [3:0] A, B;
    wire A_gt_B, A_lt_B, A_eq_B;

    // DUT instantiation
    comparator_4bit DUT (
        .A(A),
        .B(B),
        .A_gt_B(A_gt_B),
        .A_lt_B(A_lt_B),
        .A_eq_B(A_eq_B)
    );

    initial begin
        $monitor("Time=%0t | A=%b B=%b | A>B=%b A<B=%b A==B=%b",
                  $time, A, B, A_gt_B, A_lt_B, A_eq_B);

        A=4'd9;  B=4'd5;  #10;
        A=4'd3;  B=4'd8;  #10;
        A=4'd7;  B=4'd7;  #10;
        A=4'd15; B=4'd1;  #10;
        A=4'd0;  B=4'd15; #10;

        $finish;
    end

endmodule


//22
module tb_arithmetic_unit_4bit;

reg  [3:0] A, B;
    reg  [1:0] sel;
    wire [4:0] result;

// DUT instantiation
    arithmetic_unit_4bit DUT (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result)
    );

    initial begin

$monitor("Time=%0t | sel=%b | A=%d B=%d | Result=%d (%b)",
                  $time, sel, A, B, result, result);

        A=4'd9; B=4'd5;

sel=2'b00; #10;  // Addition
        sel=2'b01; #10;  // Subtraction
        sel=2'b10; #10;  // Increment
        sel=2'b11; #10;  // Decrement

A=4'd15; B=4'd1;
        sel=2'b00; #10;

A=4'd3; B=4'd8;
        sel=2'b01; #10;

$finish;
    end

endmodule
