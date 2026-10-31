//4:1 mux
`timescale 1ns/1ps

module mux_4to1 (
    input  [3:0] d,
    input  [1:0] sel,
    output reg y
);

always @(*) begin
    case (sel)
        2'b00: y = d[0];
        2'b01: y = d[1];
        2'b10: y = d[2];
        2'b11: y = d[3];
        default: y = 1'b0;
    endcase
end

endmodule

//4 bit upcounter
`timescale 1ns/1ps

module up_counter (
    input clk,
    input rst,
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin
    if (rst)
        count <= 4'b0000;
    else
        count <= count + 1'b1;
end

endmodule
