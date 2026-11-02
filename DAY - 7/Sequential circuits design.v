// 2 f/f synchronizer
module two_flop_synchronizer (
    input  wire clk,
    input  wire async_in,
    output reg  sync_out
);

reg sync_stage1;

always @(posedge clk) begin

    sync_stage1 <= async_in;
    sync_out    <= sync_stage1;

end

endmodule
// frequency divider
module frequency_divider_by2 (
    input  wire clk,
    input  wire rst,
    output reg  clk_out
);

always @(posedge clk or posedge rst) begin

    if (rst)
        clk_out <= 1'b0;

    else
        clk_out <= ~clk_out;

end

endmodule
