//MOD-13

module mod13_counter (
    input clk,
    input rst,
    output reg [3:0] count
);

always @(posedge clk or posedge rst) begin

    if (rst)
        count <= 4'd0;

    else if (count == 4'd12)
        count <= 4'd0;

    else
        count <= count + 1'b1;

end

endmodule

//johnson
module johnson_counter (
    input clk,
    input rst,
    output reg [3:0] q
);


always @(posedge clk or posedge rst) begin

if (rst)
q <= 4'b0000;

else
q <= {q[2:0], ~q[3]};

end

endmodule
