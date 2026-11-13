//4:1 mux code
module mux_4to1 (
    input A, B, C, D,
    input [1:0] sel,
    output reg Y
);

    always @(*) begin

        // Default assignment
        Y = 1'b0;

        case (sel)

            2'b00: Y = A;
            2'b01: Y = B;
            2'b10: Y = C;
            2'b11: Y = D;

            default: Y = 1'b0;

        endcase

    end

endmodule
// 4 bit counter
module counter_4bit (
    input clk,
    input rst,
    input en,
    output reg [3:0] count
);

    always @(posedge clk) begin

        if (rst)
            count <= 4'b0000;

        else if (en)
            count <= count + 1'b1;

    end

endmodule
