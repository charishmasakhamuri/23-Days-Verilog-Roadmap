
module alu_function (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire [1:0] sel,
    output reg  [3:0] result
);

    function [3:0] alu_operation;
        input [3:0] a;
        input [3:0] b;
        input [1:0] op;

        begin
            case (op)
                2'b00: alu_operation = a + b;
                2'b01: alu_operation = a - b;
                2'b10: alu_operation = a & b;
                2'b11: alu_operation = a ^ b;
                default: alu_operation = 4'b0000;
            endcase
        end
    endfunction

    always @(*) begin
        result = alu_operation(A, B, sel);
    end

endmodule


module full_adder_task (
    input  wire A,
    input  wire B,
    input  wire Cin,
    output reg  Sum,
    output reg  Carry
);

    task calculate_full_adder;
        input a;
        input b;
        input cin;

        output s;
        output c;

        begin
            s = a ^ b ^ cin;
            c = (a & b) | (b & cin) | (a & cin);
        end
    endtask

    always @(*) begin
        calculate_full_adder(A, B, Cin, Sum, Carry);
    end

endmodule
