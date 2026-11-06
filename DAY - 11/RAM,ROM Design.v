
module single_port_ram (
    input  wire       clk,
    input  wire       we,
    input  wire [3:0] addr,
    input  wire [7:0] din,
    output reg  [7:0] dout
);

    reg [7:0] mem [0:15];

    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;

        dout <= mem[addr];
    end

endmodule
//rom

module rom_8x8 (
    input  wire [2:0] addr,
    output reg  [7:0] data
);

    always @(*) begin
        case (addr)
            3'd0: data = 8'd10;
            3'd1: data = 8'd20;
            3'd2: data = 8'd30;
            3'd3: data = 8'd40;
            3'd4: data = 8'd50;
            3'd5: data = 8'd60;
            3'd6: data = 8'd70;
            3'd7: data = 8'd80;
            default: data = 8'd0;
        endcase
    end

endmodule
