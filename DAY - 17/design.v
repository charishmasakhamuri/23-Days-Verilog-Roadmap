//4 bit synchronous up counter
`timescale 1ns/1ps

`define WIDTH 4

module counter (
    input clk,
    input rst,
    input en,
    output reg [`WIDTH-1:0] count
);

    always @(posedge clk) begin

        if (rst)
            count <= 0;

        else if (en)
            count <= count + 1'b1;

    end

endmodule
//divide by 2 clock divider
`timescale 1ns/1ps

module clock_divider (
    input clk,
    input rst,
    output reg clk_out
);

    always @(posedge clk or posedge rst) begin

        if (rst)
            clk_out <= 1'b0;

        else
            clk_out <= ~clk_out;

    end

endmodule
