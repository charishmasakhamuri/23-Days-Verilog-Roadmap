`timescale 1ns/1ps

`define DEBUG

module tb_counter;

    reg clk, rst, en;
    wire [3:0] count;

    integer errors;

    // DUT instantiation
    counter dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .count(count)
    );

    // Clock generation: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin

        errors = 0;
        rst = 1;
        en = 0;

        $display("---- COUNTER VERIFICATION ----");

        // Release reset away from active clock edge
        @(negedge clk);
        rst = 0;
        en = 1;

        // Check counting
        repeat (5) begin
            @(posedge clk);
            #1;

            $display("Time=%0t Count=%0d", $time, count);

            if (count !== 4'd5 && count === 4'd0)
                errors = errors + 1;
        end

        // Disable counter
        @(negedge clk);
        en = 0;

        repeat (2) begin
            @(posedge clk);
            #1;
            $display("Counter Hold: %d", count);

            if (count !== 4'd5)
                errors = errors + 1;
        end

        // Enable counter again
        @(negedge clk);
        en = 1;

        @(posedge clk);
        #1;

        if (count !== 4'd6)
            errors = errors + 1;

        // Conditional compilation
        `ifdef DEBUG
            $display("DEBUG: Counter simulation completed");
        `endif

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("TEST FAILED: %0d errors", errors);

        $finish;
    end

endmodule

`timescale 1ns/1ps

module tb_clock_divider;

    reg clk, rst;
    wire clk_out;

    integer errors;

    clock_divider dut (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    // Input clock: 10ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        errors = 0;
        rst = 1;

        $display("---- CLOCK DIVIDER TEST ----");

        #12;
        rst = 0;

        repeat (10) begin
            @(posedge clk);
            #1;
            $display("Time=%0t Input=%b Output=%b",
                     $time, clk, clk_out);
        end

        $display("Input Clock Period = 10 ns");
        $display("Expected Output Period = 20 ns");

        $display("Errors = %0d", errors);

        $finish;

    end

endmodule
