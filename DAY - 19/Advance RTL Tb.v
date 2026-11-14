`timescale 1ns/1ps

module tb_parameter_adder;

    reg [3:0] A4, B4;
    wire [4:0] SUM4;

    reg [7:0] A8, B8;
    wire [8:0] SUM8;

    integer errors;

    // 4-bit DUT
    parameter_adder #(.WIDTH(4)) dut4 (
        .A(A4), .B(B4), .SUM(SUM4)
    );

    // 8-bit DUT
    parameter_adder #(.WIDTH(8)) dut8 (
        .A(A8), .B(B8), .SUM(SUM8)
    );

    initial begin

        errors = 0;

        $display("---- PARAMETERIZED ADDER TEST ----");

        // Test 4-bit adder
        A4 = 4'd5;
        B4 = 4'd3;

        // Test 8-bit adder
        A8 = 8'd200;
        B8 = 8'd100;

        #10;

        if (SUM4 !== 5'd8) begin
            $display("FAIL: 4-bit adder");
            errors = errors + 1;
        end
        else
            $display("PASS: 4-bit SUM = %d", SUM4);

        if (SUM8 !== 9'd300) begin
            $display("FAIL: 8-bit adder");
            errors = errors + 1;
        end
        else
            $display("PASS: 8-bit SUM = %d", SUM8);

        if (errors == 0)
            $display("ALL TESTS PASSED");
        else
            $display("ERRORS = %d", errors);

        $finish;

    end

endmodule


`timescale 1ns/1ps

module tb_pipeline_3stage;

    reg clk, rst;
    reg [7:0] din;
    wire [7:0] dout;

    integer errors;
    integer expected [0:2];
    integer i;

    pipeline_3stage #(.WIDTH(8)) dut (
        .clk(clk),
        .rst(rst),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin

        errors = 0;
        rst = 1;
        din = 0;

        $display("---- PIPELINE TEST ----");

        // Reset
        @(posedge clk);
        #1;

        if (dout !== 8'd0)
            errors = errors + 1;

        @(negedge clk);
        rst = 0;

        // Drive input data
        for (i = 0; i < 5; i = i + 1) begin

            @(negedge clk);
            din = i + 10;

            expected[i % 3] = i + 12;

            @(posedge clk);
            #1;

            if (i >= 2) begin
                if (dout !== expected[(i-2) % 3]) begin
                    $display("FAIL: Actual=%d", dout);
                    errors = errors + 1;
                end
                else
                    $display("PASS: Output=%d", dout);
            end

        end

        // Drain remaining pipeline stages
        @(negedge clk);
        din = 0;

        repeat (2) begin
            @(posedge clk);
            #1;
        end

        if (errors == 0)
            $display("ALL PIPELINE TESTS PASSED");
        else
            $display("PIPELINE ERRORS = %d", errors);

        $finish;

    end

endmodule
