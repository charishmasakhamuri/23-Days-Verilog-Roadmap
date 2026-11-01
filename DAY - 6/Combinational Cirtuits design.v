//4:1 mux using case statement
module mux_4to1 (
    input  wire [3:0] data_in,
    input  wire [1:0] sel,
    output reg        data_out
);

always @(*) begin

    case (sel)

        2'b00: data_out = data_in[0];
        2'b01: data_out = data_in[1];
        2'b10: data_out = data_in[2];
        2'b11: data_out = data_in[3];

        default: data_out = 1'b0;

    endcase

end

endmodule

//4 bit alu
module alu_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    input  wire [2:0] sel,

    output reg  [3:0] result,
    output reg        carry
);

always @(*) begin

    result = 4'b0000;
    carry  = 1'b0;

    case (sel)

        // Addition
        3'b000: {carry, result} =
                {1'b0, A} + {1'b0, B};

        // Subtraction
        3'b001: result = A - B;

        // AND
        3'b010: result = A & B;

        // OR
        3'b011: result = A | B;

        // XOR
        3'b100: result = A ^ B;

        // NOT
        3'b101: result = ~A;

        // Left Shift
        3'b110: result = A << 1;

        // Right Shift
        3'b111: result = A >> 1;

        default: begin
            result = 4'b0000;
            carry  = 1'b0;
        end

    endcase

end

endmodule
