`timescale 1ns/1ps

module tb_basic_gates;
    reg a, b;
    wire y_and, y_or, y_not;
    wire y_nand, y_nor, y_xor, y_xnor, y_buf;

    basic_gates dut (
        a, b, y_and, y_or, y_not,
        y_nand, y_nor, y_xor, y_xnor, y_buf
    );

    initial begin
        $monitor("A=%b B=%b | AND=%b OR=%b NOT_A=%b NAND=%b NOR=%b XOR=%b XNOR=%b BUF=%b",
                 a, b, y_and, y_or, y_not,
                 y_nand, y_nor, y_xor, y_xnor, y_buf);

        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;

        $finish;
    end
endmodule

///222
module tb_full_adder;
    reg a, b, cin;
    wire sum, carry;
    integer i;

    full_adder dut(a, b, cin, sum, carry);

    initial begin
        $monitor("A=%b B=%b Cin=%b Sum=%b Carry=%b",
                 a, b, cin, sum, carry);

        for (i=0; i<8; i=i+1) begin
            {a, b, cin} = i;
            #10;
        end

        $finish;
    end
endmodule
