//4 bit alu
module alu_4bit (
    input  [3:0] A, B,
    input  [2:0] OP,
    output reg [3:0] result,
    output reg carry_out
);

    always @(*) begin

        result = 4'b0000;
        carry_out = 1'b0;

        case (OP)

            3'b000: begin
                {carry_out, result} = A + B;
            end

            3'b001: begin
                result = A - B;
                carry_out = (A < B);
            end

            3'b010: begin
                result = A & B;
            end

            3'b011: begin
                result = A | B;
            end

            3'b100: begin
                result = A ^ B;
            end

            default: begin
                result = 4'b0000;
                carry_out = 1'b0;
            end

        endcase
    end

endmodule
