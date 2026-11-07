//fifo design

module sync_fifo (
    input  wire       clk,
    input  wire       rst,
    input  wire       wr_en,
    input  wire       rd_en,
    input  wire [7:0] din,

    output reg  [7:0] dout,
    output wire       full,
    output wire       empty
);

    reg [7:0] mem [0:7];

    reg [3:0] wptr;
    reg [3:0] rptr;

    // Empty and full conditions
    assign empty = (wptr == rptr);

    assign full = (wptr[2:0] == rptr[2:0]) &&
                  (wptr[3] != rptr[3]);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wptr <= 0;
            rptr <= 0;
            dout <= 0;
        end
        else begin

            // Write operation
            if (wr_en && !full) begin
                mem[wptr[2:0]] <= din;
                wptr <= wptr + 1'b1;
            end

            // Read operation
            if (rd_en && !empty) begin
                dout <= mem[rptr[2:0]];
                rptr <= rptr + 1'b1;
            end

        end
    end

endmodule

//Parameterized Synchronous FIFO

module parameterized_fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8,
    parameter ADDR_WIDTH = $clog2(DEPTH)
)(
    input wire clk,
    input wire rst,

    input wire wr_en,
    input wire rd_en,

    input wire [DATA_WIDTH-1:0] din,

    output reg [DATA_WIDTH-1:0] dout,
    output wire full,
    output wire empty,
    output reg [ADDR_WIDTH:0] count
);

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    reg [ADDR_WIDTH-1:0] wptr;
    reg [ADDR_WIDTH-1:0] rptr;

    wire write_accept;
    wire read_accept;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    assign write_accept = wr_en && (!full || (rd_en && !empty));
    assign read_accept  = rd_en && !empty;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wptr  <= 0;
            rptr  <= 0;
            count <= 0;
            dout  <= 0;
        end
        else begin

            // Write
            if (write_accept) begin
                mem[wptr] <= din;

                if (wptr == DEPTH-1)
                    wptr <= 0;
                else
                    wptr <= wptr + 1'b1;
            end

            // Read
            if (read_accept) begin
                dout <= mem[rptr];

                if (rptr == DEPTH-1)
                    rptr <= 0;
                else
                    rptr <= rptr + 1'b1;
            end

            // Occupancy update
            case ({write_accept, read_accept})
                2'b10: count <= count + 1'b1;
                2'b01: count <= count - 1'b1;
                default: count <= count;
            endcase

        end
    end

endmodule


//
