module parameter_adder #(
    parameter WIDTH = 4
)(
    input  [WIDTH-1:0] A,
    input  [WIDTH-1:0] B,
    output [WIDTH:0] SUM
);

    assign SUM = {1'b0, A} + {1'b0, B};

endmodule


module pipeline_3stage #(
    parameter WIDTH = 8
)(
    input clk,
    input rst,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout
);

    reg [WIDTH-1:0] stage1;
    reg [WIDTH-1:0] stage2;

    always @(posedge clk) begin

        if (rst) begin
            stage1 <= 0;
            stage2 <= 0;
            dout   <= 0;
        end

        else begin
            stage1 <= din;
            stage2 <= stage1 + 1'b1;
            dout   <= stage2 + 1'b1;
        end

    end

endmodule
