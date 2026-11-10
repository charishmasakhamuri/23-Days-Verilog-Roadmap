//
`timescale 1ns/1ps

module tb_up_counter;

    reg clk;
    reg rst;
    reg enable;

    wire [3:0] count;

    integer errors;
    integer i;

    reg [3:0] expected;

    // DUT instantiation
    up_counter dut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .count(count)
    );

    // Clock generation: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    // Monitor signal changes
    initial begin
        $monitor("Time=%0t | CLK=%b | RST=%b | EN=%b | COUNT=%d",
                 $time, clk, rst, enable, count);
    end

    initial begin

        rst = 1;
        enable = 0;
        errors = 0;
        expected = 0;

        // Apply reset
        repeat(2) @(negedge clk);
        rst = 0;

        // Enable counting
        @(negedge clk);
        enable = 1;

        // Check 10 counting cycles
        for (i = 0; i < 10; i = i + 1) begin

            @(posedge clk);
            expected = expected + 1'b1;

            #1;

            if (count !== expected) begin
                $display("FAIL: Expected=%d Actual=%d",
                         expected, count);
                errors = errors + 1;
            end
            else begin
                $display("PASS: Count=%d", count);
            end

        end

        // Disable counting
        @(negedge clk);
        enable = 0;

        repeat(2) begin
            @(posedge clk);
            #1;

            if (count !== expected) begin
                $display("HOLD TEST FAIL");
                errors = errors + 1;
            end
            else begin
                $display("HOLD TEST PASS: Count=%d", count);
            end
        end

        // Apply reset again
        @(negedge clk);
        rst = 1;

        @(posedge clk);
        #1;

        if (count !== 4'd0) begin
            $display("RESET TEST FAIL");
            errors = errors + 1;
        end
        else begin
            $display("RESET TEST PASS");
        end

        if (errors == 0)
            $display("\n========== ALL TESTS PASSED ==========");
        else
            $display("\n========== TESTS FAILED: %0d ==========", errors);

        $finish;

    end

endmodule

`timescale 1ns/1ps

module tb_adder_4bit;

    reg [3:0] A, B;
    wire [4:0] SUM;

    reg [4:0] expected;
    integer errors;
    integer i;

    // DUT instantiation
    adder_4bit dut (
        .A(A),
        .B(B),
        .SUM(SUM)
    );

    initial begin
        errors = 0;
        A = 0;
        B = 0;

        $display("---- 4-BIT ADDER TEST ----");

        // Directed stimulus
        for (i = 0; i < 5; i = i + 1) begin

            case (i)
                0: begin A = 0;  B = 0;  end
                1: begin A = 5;  B = 3;  end
                2: begin A = 7;  B = 8;  end
                3: begin A = 15; B = 1;  end
                4: begin A = 15; B = 15; end
            endcase

            // Calculate expected result
            expected = A + B;

            // Allow combinational output to settle
            #10;

            // Compare actual and expected results
            if (SUM !== expected) begin
                $display("FAIL: A=%d B=%d SUM=%d EXPECTED=%d",
                         A, B, SUM, expected);
                errors = errors + 1;
            end
            else begin
                $display("PASS: A=%d B=%d SUM=%d",
                         A, B, SUM);
            end

        end

        // Final test summary
        $display("--------------------------");

        if (errors == 0)
            $display("ALL TEST CASES PASSED!");
        else
            $display("TEST FAILED! Errors = %0d", errors);

        $finish;
    end

endmodule
