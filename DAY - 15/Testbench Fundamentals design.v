// 4 bit synchronous up counter

module up_counter (
    input  wire       clk,
    input  wire       rst,
    input  wire       enable,
    output reg  [3:0] count
);

    always @(posedge clk) begin
        if (rst)
            count <= 4'd0;
        else if (enable)
            count <= count + 1'b1;
    end

endmodule

//4-bit Adder with Self-Checking Testbench
module adder_4bit (
    input  wire [3:0] A,
    input  wire [3:0] B,
    output wire [4:0] SUM
);

    assign SUM = A + B;

endmodule
