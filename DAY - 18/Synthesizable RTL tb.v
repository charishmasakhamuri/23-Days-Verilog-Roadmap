`timescale 1ns/1ps

module tb_mux_4to1;

    reg A, B, C, D;
    reg [1:0] sel;

    wire Y;

    reg expected;
    integer errors;
    integer i;

    // DUT instantiation
    mux_4to1 dut (
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .sel(sel),
        .Y(Y)
    );

    initial begin

        errors = 0;

        A = 0;
        B = 0;
        C = 0;
        D = 0;
        sel = 0;

        $display("---- 4:1 MUX VERIFICATION ----");

        // Test all select combinations
        for (i = 0; i < 4; i = i + 1) begin

            // Change inputs away from sampling edge
            A = 1'b1;
            B = 1'b0;
            C = 1'b1;
            D = 1'b0;

            sel = i;

            case (i)
                0: expected = A;
                1: expected = B;
                2: expected = C;
                3: expected = D;
            endcase

            #10;

            if (Y !== expected) begin

                $display("FAIL: SEL=%b Y=%b EXPECTED=%b",
                         sel, Y, expected);

                errors = errors + 1;

            end
            else begin

                $display("PASS: SEL=%b Y=%b",
                         sel, Y);

            end

        end

        if (errors == 0)
            $display("ALL MUX TESTS PASSED");
        else
            $display("MUX TEST FAILED: %0d errors", errors);

        $finish;

    end

endmodule

//
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

        $display("---- 4-BIT COUNTER VERIFICATION ----");

        // Apply synchronous reset
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

        // Test counting from 1 to 15
        for (i = 0; i < 15; i = i + 1) begin

            @(posedge clk);
            #1;

            expected = expected + 1'b1;

            if (count !== expected) begin
                $display("FAIL: Expected=%d Actual=%d",
                         expected, count);
                errors = errors + 1;
            end
            else begin
                $display("PASS: Count=%d", count);
            end

        end

        // Test rollover: 15 to 0
        @(posedge clk);
        #1;

        expected = 0;

        if (count !== expected) begin
            $display("FAIL: Rollover Expected=0 Actual=%d", count);
            errors = errors + 1;
        end
        else
            $display("PASS: Rollover 15 to 0");

        // Test enable LOW: counter must hold
        @(negedge clk);
        en = 0;

        repeat (3) begin

            @(posedge clk);
            #1;

            if (count !== expected) begin
                $display("FAIL: Counter Hold");
                errors = errors + 1;
            end
            else
                $display("PASS: Counter Hold");

        end

        // Final report
        $display("-------------------------------");

        if (errors == 0)
            $display("ALL COUNTER TESTS PASSED");
        else
            $display("TEST FAILED: %0d errors", errors);

        $finish;

    end

endmodule

