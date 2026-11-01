//4:1 mux with case statement
`timescale 1ns/1ps

module tb_mux_4to1;

reg  [3:0] data_in;
reg  [1:0] sel;
wire data_out;

integer i;

mux_4to1 DUT (
    .data_in(data_in),
    .sel(sel),
    .data_out(data_out)
);

initial begin

    $display("Time\tData_in\tSel\tOutput");

    data_in = 4'b1010;

    for (i = 0; i < 4; i = i + 1) begin

        sel = i;
        #10;

        $display("%0t\t%b\t%b\t%b",
                 $time, data_in, sel, data_out);

        if (data_out !== data_in[sel])
            $display("FAIL: MUX output mismatch");
        else
            $display("PASS");

    end

    $display("MUX TEST COMPLETED");

    $finish;

end

endmodule
//4- bit alu

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
