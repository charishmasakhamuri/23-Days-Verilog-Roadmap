
module parameterized_alu #(
    parameter WIDTH = 8
)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    input  [2:0] OP,

    output reg [WIDTH-1:0] RESULT,
    output reg CARRY,
    output ZERO
);

    always @(*) begin

        RESULT = {WIDTH{1'b0}};
        CARRY  = 1'b0;

        case (OP)

            // Addition
            3'b000: begin
                {CARRY, RESULT} =
                    {1'b0, A} + {1'b0, B};
            end

            // Subtraction
            3'b001: begin
                RESULT = A - B;
                CARRY = (A < B);
            end

            // AND
            3'b010:
                RESULT = A & B;

            // OR
            3'b011:
                RESULT = A | B;

            // XOR
            3'b100:
                RESULT = A ^ B;

            // NOT
            3'b101:
                RESULT = ~A;

            // Shift left
            3'b110:
                RESULT = A << 1;

            // Shift right
            3'b111:
                RESULT = A >> 1;

            default: begin
                RESULT = 0;
                CARRY = 0;
            end

        endcase

    end

    assign ZERO = (RESULT == 0);

endmodule
