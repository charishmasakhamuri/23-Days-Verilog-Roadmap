`timescale 1ns/1ps

module tb_synchronous_fifo;

    parameter WIDTH = 8;
    parameter DEPTH = 4;

    reg clk, rst;
    reg wr_en, rd_en;
    reg [WIDTH-1:0] din;

    wire [WIDTH-1:0] dout;
    wire full, empty;
    wire [$clog2(DEPTH+1)-1:0] count;

    integer errors;
    integer model_count;
    integer model_wr_ptr;
    integer model_rd_ptr;
    integer i;

    reg [WIDTH-1:0] model_mem [0:DEPTH-1];

    // DUT instantiation
    synchronous_fifo #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty),
        .count(count)
    );

    // Clock generation: 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Apply one FIFO transaction and check the result
    task fifo_cycle;

        input wr;
        input rd;
        input [WIDTH-1:0] data;

        reg exp_write;
        reg exp_read;
        reg [WIDTH-1:0] exp_data;

        begin

            @(negedge clk);

            wr_en = wr;
            rd_en = rd;
            din = data;

            // Calculate expected accepted operations
            exp_read = rd && (model_count > 0);

            exp_write = wr &&
                        ((model_count < DEPTH) || exp_read);

            // Capture expected read data before updating model
            if (exp_read)
                exp_data = model_mem[model_rd_ptr];

            @(posedge clk);

            // Update reference model
            if (exp_read) begin

                if (model_rd_ptr == DEPTH-1)
                    model_rd_ptr = 0;
                else
                    model_rd_ptr = model_rd_ptr + 1;

            end

            if (exp_write) begin

                model_mem[model_wr_ptr] = data;

                if (model_wr_ptr == DEPTH-1)
                    model_wr_ptr = 0;
                else
                    model_wr_ptr = model_wr_ptr + 1;

            end

            case ({exp_write, exp_read})

                2'b10: model_count = model_count + 1;
                2'b01: model_count = model_count - 1;
                default: model_count = model_count;

            endcase

            #1;

            // Check read data
            if (exp_read && dout !== exp_data) begin

                $display("FAIL: Read data Expected=%h Actual=%h",
                         exp_data, dout);

                errors = errors + 1;

            end

            // Check occupancy
            if (count !== model_count) begin

                $display("FAIL: Count Expected=%0d Actual=%0d",
                         model_count, count);

                errors = errors + 1;

            end

            // Check full flag
            if (full !== (model_count == DEPTH)) begin

                $display("FAIL: Full flag mismatch");

                errors = errors + 1;

            end

            // Check empty flag
            if (empty !== (model_count == 0)) begin

                $display("FAIL: Empty flag mismatch");

                errors = errors + 1;

            end

            if (!(exp_read && dout !== exp_data) &&
                count === model_count &&
                full === (model_count == DEPTH) &&
                empty === (model_count == 0)) begin

                $display("PASS: WR=%b RD=%b DIN=%h DOUT=%h COUNT=%0d FULL=%b EMPTY=%b",
                         wr, rd, data, dout, count, full, empty);

            end

        end

    endtask

    initial begin

        errors = 0;

        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        model_count = 0;
        model_wr_ptr = 0;
        model_rd_ptr = 0;

        $display("================================");
        $display(" SYNCHRONOUS FIFO VERIFICATION ");
        $display(" WIDTH = %0d DEPTH = %0d", WIDTH, DEPTH);
        $display("================================");

        // Reset
        @(posedge clk);
        #1;

        if (count !== 0 || full !== 0 || empty !== 1) begin
            $display("FAIL: Reset");
            errors = errors + 1;
        end
        else
            $display("PASS: Reset");

        @(negedge clk);
        rst = 0;

        // 1. Normal write operations
        $display("\n--- NORMAL WRITE ---");

        fifo_cycle(1,0,8'h11);
        fifo_cycle(1,0,8'h22);
        fifo_cycle(1,0,8'h33);
        fifo_cycle(1,0,8'h44);

        // 2. Full condition and overflow attempt
        $display("\n--- FULL AND OVERFLOW ---");

        fifo_cycle(1,0,8'h55);

        // 3. Read one item
        $display("\n--- NORMAL READ ---");

        fifo_cycle(0,1,8'h00);

        // 4. Write after reading
        $display("\n--- WRITE AFTER READ ---");

        fifo_cycle(1,0,8'h55);

        // 5. Read remaining items
        $display("\n--- FIFO ORDER CHECK ---");

        fifo_cycle(0,1,8'h00);
        fifo_cycle(0,1,8'h00);
        fifo_cycle(0,1,8'h00);
        fifo_cycle(0,1,8'h00);

        // 6. Empty and underflow attempt
        $display("\n--- EMPTY AND UNDERFLOW ---");

        fifo_cycle(0,1,8'h00);

        // 7. Simultaneous read and write
        $display("\n--- SIMULTANEOUS READ/WRITE ---");

        fifo_cycle(1,0,8'h66);
        fifo_cycle(1,1,8'h77);
        fifo_cycle(0,1,8'h00);

        // 8. Full FIFO simultaneous read/write
        $display("\n--- FULL SIMULTANEOUS READ/WRITE ---");

        fifo_cycle(1,0,8'hA1);
        fifo_cycle(1,0,8'hA2);
        fifo_cycle(1,0,8'hA3);
        fifo_cycle(1,0,8'hA4);

        fifo_cycle(1,1,8'hA5);

        fifo_cycle(0,1,8'h00);
        fifo_cycle(0,1,8'h00);
        fifo_cycle(0,1,8'h00);
        fifo_cycle(0,1,8'h00);

        // Final report
        @(negedge clk);
        wr_en = 0;
        rd_en = 0;

        $display("\n================================");

        if (errors == 0)
            $display("ALL FIFO TESTS PASSED!");
        else
            $display("FIFO TEST FAILED: %0d ERRORS", errors);

        $display("Total Errors = %0d", errors);
        $display("================================");

        $finish;

    end

endmodule
