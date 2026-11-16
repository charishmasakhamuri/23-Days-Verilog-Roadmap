
module synchronous_fifo #(
    parameter WIDTH = 8,
    parameter DEPTH = 4
)(
    input clk,
    input rst,

    input wr_en,
    input rd_en,
    input [WIDTH-1:0] din,

    output reg [WIDTH-1:0] dout,
    output full,
    output empty,
    output reg [$clog2(DEPTH+1)-1:0] count
);

    localparam PTR_WIDTH =
        (DEPTH <= 1) ? 1 : $clog2(DEPTH);

    reg [WIDTH-1:0] mem [0:DEPTH-1];

    reg [PTR_WIDTH-1:0] wr_ptr;
    reg [PTR_WIDTH-1:0] rd_ptr;

    wire do_read;
    wire do_write;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    // Accepted operations
    assign do_read = rd_en && !empty;

    // At full, accept write only if a read also occurs.
    assign do_write =
        wr_en && (!full || do_read);

    always @(posedge clk) begin

        if (rst) begin

            wr_ptr <= 0;
            rd_ptr <= 0;
            count  <= 0;
            dout   <= 0;

        end

        else begin

            // Write operation
            if (do_write) begin

                mem[wr_ptr] <= din;

                if (wr_ptr == DEPTH-1)
                    wr_ptr <= 0;
                else
                    wr_ptr <= wr_ptr + 1'b1;

            end

            // Read operation
            if (do_read) begin

                dout <= mem[rd_ptr];

                if (rd_ptr == DEPTH-1)
                    rd_ptr <= 0;
                else
                    rd_ptr <= rd_ptr + 1'b1;

            end

            // Occupancy update
            case ({do_write, do_read})

                2'b10: count <= count + 1'b1;

                2'b01: count <= count - 1'b1;

                default: count <= count;

            endcase

        end

    end

endmodule
