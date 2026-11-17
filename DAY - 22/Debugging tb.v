
`timescale 1ns/1ps

module tb_counter_4bit;

    reg clk, rst, en;
    wire [3:0] count;

    reg [3:0] expected;
    integer errors;
    integer i;

    // DUT instantiation
    counter_4bit dut (
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

    initial begin

        errors = 0;
        expected = 0;

        rst = 1;
        en = 0;

        $display("---- COUNTER DEBUGGING TEST ----");

        // Reset test
        @(posedge clk);
        #1;

        if (count !== 4'd0) begin
            $display("FAIL: Reset");
            errors = errors + 1;
        end
        else
            $display("PASS: Reset");

        // Release reset and enable counting
        @(negedge clk);
        rst = 0;
        en = 1;

        // Count from 1 to 15
        for (i = 0; i < 15; i = i + 1) begin

            @(posedge clk);
            #1;

            expected = expected + 1'b1;

            if (count !== expected) begin
                $display("FAIL: Expected=%0d Actual=%0d",
                         expected, count);
                errors = errors + 1;
            end
            else
                $display("PASS: Count=%0d", count);

        end

        // Rollover test: 15 to 0
        @(posedge clk);
        #1;

        expected = 0;

        if (count !== expected) begin
            $display("FAIL: Rollover");
            errors = errors + 1;
        end
        else
            $display("PASS: Rollover 15 to 0");

        // Disable counter and check hold
        @(negedge clk);
        en = 0;

        repeat (3) begin

            @(posedge clk);
            #1;

            if (count !== expected) begin
                $display("FAIL: Hold condition");
                errors = errors + 1;
            end
            else
                $display("PASS: Counter holds at %0d", count);

        end

        // Final report
        $display("------------------------------");

        if (errors == 0)
            $display("ALL COUNTER TESTS PASSED");
        else
            $display("TOTAL ERRORS = %0d", errors);

        $finish;

    end

endmodule

