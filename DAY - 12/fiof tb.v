
`timescale 1ns/1ps

module tb_sync_fifo;

    reg clk, rst, wr_en, rd_en;
    reg [7:0] din;

    wire [7:0] dout;
    wire full, empty;

    sync_fifo dut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;

        // Reset
        repeat(2) @(negedge clk);
        rst = 0;

        // Write 10, 20, 30, 40
        @(negedge clk);
        wr_en = 1;
        din = 10;

        @(negedge clk);
        din = 20;

        @(negedge clk);
        din = 30;

        @(negedge clk);
        din = 40;

        @(negedge clk);
        wr_en = 0;

        // Read data
        rd_en = 1;

        repeat(4) begin
            @(posedge clk);
            #1;
            $display("READ DATA = %0d", dout);
        end

        @(negedge clk);
        rd_en = 0;

        #2;
        $display("EMPTY = %b", empty);

        if (empty)
            $display("FIFO TEST PASSED");
        else
            $display("FIFO TEST FAILED");

        $finish;
    end

endmodule


`timescale 1ns/1ps

module tb_parameterized_fifo;

    parameter DATA_WIDTH = 8;
    parameter DEPTH = 8;

    reg clk, rst;
    reg wr_en, rd_en;
    reg [DATA_WIDTH-1:0] din;

    wire [DATA_WIDTH-1:0] dout;
    wire full, empty;
    wire [$clog2(DEPTH):0] count;

    integer i;
    integer errors;

    // DUT instantiation
    parameterized_fifo #(
        .DATA_WIDTH(DATA_WIDTH),
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
    always #5 clk = ~clk;

    // Write task
    task write_data(input [DATA_WIDTH-1:0] data);
    begin
        @(negedge clk);
        wr_en = 1;
        rd_en = 0;
        din = data;

        @(posedge clk);
        #1;

        $display("WRITE: Data=%0d Count=%0d", data, count);
    end
    endtask

    // Read task
    task read_data(input [DATA_WIDTH-1:0] expected);
    begin
        @(negedge clk);
        wr_en = 0;
        rd_en = 1;

        @(posedge clk);
        #1;

        if (dout === expected) begin
            $display("READ PASS: Expected=%0d Actual=%0d",
                      expected, dout);
        end
        else begin
            $display("READ FAIL: Expected=%0d Actual=%0d",
                      expected, dout);
            errors = errors + 1;
        end
    end
    endtask

    initial begin

        clk = 0;
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;
        errors = 0;

        // Reset
        repeat(2) @(negedge clk);
        rst = 0;

        $display("\n--- NORMAL WRITE TEST ---");

        // Write 8 values
        for (i = 1; i <= DEPTH; i = i+1)
            write_data(i*10);

        // Check FULL
        @(negedge clk);
        wr_en = 0;

        #1;
        if (full) begin
            $display("FULL FLAG PASS");
        end
        else begin
            $display("FULL FLAG FAIL");
            errors = errors + 1;
        end

        $display("\n--- OVERFLOW TEST ---");

        // Try writing when full
        @(negedge clk);
        wr_en = 1;
        din = 200;

        @(posedge clk);
        #1;

        if (full && count == DEPTH) begin
            $display("OVERFLOW PROTECTION PASS");
        end
        else begin
            $display("OVERFLOW PROTECTION FAIL");
            errors = errors + 1;
        end

        $display("\n--- NORMAL READ TEST ---");

        // Read all stored values
        for (i = 1; i <= DEPTH; i = i+1)
            read_data(i*10);

        // Check EMPTY
        @(negedge clk);
        rd_en = 0;

        #1;
        if (empty) begin
            $display("EMPTY FLAG PASS");
        end
        else begin
            $display("EMPTY FLAG FAIL");
            errors = errors + 1;
        end

        $display("\n--- UNDERFLOW TEST ---");

        // Try reading when empty
        @(negedge clk);
        rd_en = 1;

        @(posedge clk);
        #1;

        if (empty && count == 0) begin
            $display("UNDERFLOW PROTECTION PASS");
        end
        else begin
            $display("UNDERFLOW PROTECTION FAIL");
            errors = errors + 1;
        end

        @(negedge clk);
        rd_en = 0;

        $display("\n--- SIMULTANEOUS READ/WRITE TEST ---");

        // First write two values
        write_data(55);
        write_data(66);

        // Read and write together
        @(negedge clk);
        wr_en = 1;
        rd_en = 1;
        din = 77;

        @(posedge clk);
        #1;

        if (dout === 55 && count == 2) begin
            $display("SIMULTANEOUS READ/WRITE PASS");
        end
        else begin
            $display("SIMULTANEOUS READ/WRITE FAIL");
            errors = errors + 1;
        end

        // Read remaining values
        read_data(66);
        read_data(77);

        @(negedge clk);
        rd_en = 0;

        if (errors == 0)
            $display("\n========== ALL TESTS PASSED ==========");
        else
            $display("\n========== TESTS FAILED: %0d ==========", errors);

        $finish;
    end

endmodule


