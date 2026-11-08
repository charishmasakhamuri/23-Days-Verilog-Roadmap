
`timescale 1ns/1ps

module tb_alu_function;

    reg [3:0] A, B;
    reg [1:0] sel;
    wire [3:0] result;

    alu_function dut (
        .A(A),
        .B(B),
        .sel(sel),
        .result(result)
    );

    initial begin

        A = 4'd10;
        B = 4'd5;

        // Addition
        sel = 2'b00;
        #10;
        $display("ADD: %0d + %0d = %0d",
                  A, B, result);

        // Subtraction
        sel = 2'b01;
        #10;
        $display("SUB: %0d - %0d = %0d",
                  A, B, result);

        // AND
        sel = 2'b10;
        #10;
        $display("AND: %b", result);

        // XOR
        sel = 2'b11;
        #10;
        $display("XOR: %b", result);

        $finish;
    end

endmodule



`timescale 1ns/1ps

module tb_full_adder_task;

    reg A, B, Cin;
    wire Sum, Carry;

    integer i;

    full_adder_task dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Carry(Carry)
    );

    initial begin

        $display("A B Cin | Sum Carry");
        $display("-------------------");

        for (i = 0; i < 8; i = i + 1) begin

            {A, B, Cin} = i;
            #10;

            $display("%b %b  %b  |  %b    %b",
                      A, B, Cin, Sum, Carry);

        end

        $finish;
    end

endmodule
