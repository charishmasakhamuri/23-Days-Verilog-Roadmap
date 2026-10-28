module datatype_demo (
    input wire clk,
    input wire rst,
    input wire wire_in,
    input wire [3:0] data_in,

    output wire wire_out,
    output reg reg_out,
    output reg [7:0] vector_out,
    output reg signed [3:0] signed_out,
    output reg [3:0] unsigned_out
);

    // Net type
    assign wire_out = wire_in;

    // Procedural variable and vector types
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            reg_out      <= 1'b0;
            vector_out   <= 8'b0;
            signed_out   <= 4'sd0;
            unsigned_out <= 4'd0;
        end
        else begin
            reg_out      <= wire_in;
            vector_out   <= {4'b0000, data_in};
            signed_out   <= data_in;
            unsigned_out <= data_in;
        end
    end

endmodule
