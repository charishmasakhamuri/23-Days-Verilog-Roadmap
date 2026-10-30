//1

`timescale 1ns/1ps

module comparator_4bit (
    input  [3:0] A,
    input  [3:0] B,
    output       A_gt_B,
    output       A_lt_B,
    output       A_eq_B
);

    // Compare A and B
    assign A_gt_B = (A > B);
    assign A_lt_B = (A < B);
    assign A_eq_B = (A == B);

endmodule



//22
`timescale 1ns/1ps

module arithmetic_unit_4bit (
    input  [3:0] A,
    input  [3:0] B,
    input  [1:0] sel,
    output reg [4:0] result
);

    always @(*) begin
        case (sel)

            2'b00: result = {1'b0, A} + {1'b0, B};

            2'b01: result = {1'b0, A} - {1'b0, B};

            2'b10: result = {1'b0, A} + 5'd1;

            2'b11: result = {1'b0, A} - 5'd1;

            default: result = 5'b00000;

        endcase
    end

endmodule
