//Three-Stage Pipeline using Non-Blocking Assignments
module pipeline_3stage (
    input  wire clk,
    input  wire rst,
    input  wire din,

    output reg q1,
    output reg q2,
    output reg q3
);

always @(posedge clk or posedge rst) begin

    if (rst) begin
        q1 <= 1'b0;
        q2 <= 1'b0;
        q3 <= 1'b0;
    end

    else begin
        q1 <= din;
        q2 <= q1;
        q3 <= q2;
    end

end

endmodule
//2. Two-Register Swap using Non-Blocking Assignment
module register_swap (
    input  wire       clk,
    input  wire       rst,
    input  wire       en,

    output reg  [3:0] A,
    output reg  [3:0] B
);

always @(posedge clk or posedge rst) begin

    if (rst) begin
        A <= 4'd0;
        B <= 4'd0;
    end

    else if (en) begin
        A <= B;
        B <= A;
    end

end

endmodule
