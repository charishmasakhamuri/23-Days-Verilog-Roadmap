
`timescale 1ns/1ps

module tb_parameter_mux;

    reg [3:0] A4, B4;
    reg sel4;
    wire [3:0] Y4;

    reg [7:0] A8, B8;
    reg sel8;
    wire [7:0] Y8;

    // 4-bit MUX
    mux_2to1 #(.WIDTH(4)) dut4 (
        .A(A4), .B(B4), .sel(sel4), .Y(Y4)
    );

    // 8-bit MUX
    mux_2to1 #(.WIDTH(8)) dut8 (
        .A(A8), .B(B8), .sel(sel8), .Y(Y8)
    );

    initial begin

        // 4-bit test
        A4 = 4'b1010;
        B4 = 4'b0101;

        sel4 = 0;
        #10;
        $display("4-bit MUX sel=0 Y=%b", Y4);

        sel4 = 1;
        #10;
        $display("4-bit MUX sel=1 Y=%b", Y4);

        // 8-bit test
        A8 = 8'hAA;
        B8 = 8'h55;

        sel8 = 0;
        #10;
        $display("8-bit MUX sel=0 Y=%h", Y8);

        sel8 = 1;
        #10;
        $display("8-bit MUX sel=1 Y=%h", Y8);

        $finish;
    end

endmodule


`timescale 1ns/1ps

module tb_ripple_carry_adder;

    // 4-bit signals
    reg [3:0] A4, B4;
    reg Cin4;
    wire [3:0] Sum4;
    wire Cout4;

    // 8-bit signals
    reg [7:0] A8, B8;
    reg Cin8;
    wire [7:0] Sum8;
    wire Cout8;

    // Expected results
    reg [4:0] expected4;
    reg [8:0] expected8;

    // 4-bit adder instantiation
    ripple_carry_adder #(.WIDTH(4)) dut4 (
        .A(A4),
        .B(B4),
        .Cin(Cin4),
        .Sum(Sum4),
        .Cout(Cout4)
    );

    // 8-bit adder instantiation
    ripple_carry_adder #(.WIDTH(8)) dut8 (
        .A(A8),
        .B(B8),
        .Cin(Cin8),
        .Sum(Sum8),
        .Cout(Cout8)
    );

    initial begin

        // TEST 1: 4-bit addition
        A4 = 4'd7;
        B4 = 4'd5;
        Cin4 = 0;

        expected4 = {1'b0, A4} +
                    {1'b0, B4} + Cin4;

        #10;

        $display("\n--- 4-BIT ADDER TEST ---");
        $display("A = %d, B = %d, Cin = %b",
                  A4, B4, Cin4);
        $display("Sum = %d, Cout = %b",
                  Sum4, Cout4);

        if ({Cout4, Sum4} === expected4)
            $display("4-BIT ADDITION PASS");
        else
            $display("4-BIT ADDITION FAIL");


        // TEST 2: 4-bit carry generation
        A4 = 4'd15;
        B4 = 4'd1;
        Cin4 = 0;

        expected4 = {1'b0, A4} +
                    {1'b0, B4} + Cin4;

        #10;

        $display("\n--- 4-BIT CARRY TEST ---");
        $display("A = %d, B = %d", A4, B4);
        $display("Sum = %d, Cout = %b",
                  Sum4, Cout4);

        if ({Cout4, Sum4} === expected4)
            $display("4-BIT CARRY TEST PASS");
        else
            $display("4-BIT CARRY TEST FAIL");


        // TEST 3: 8-bit addition
        A8 = 8'd200;
        B8 = 8'd100;
        Cin8 = 0;

        expected8 = {1'b0, A8} +
                    {1'b0, B8} + Cin8;

        #10;

        $display("\n--- 8-BIT ADDER TEST ---");
        $display("A = %d, B = %d, Cin = %b",
                  A8, B8, Cin8);
        $display("Sum = %d, Cout = %b",
                  Sum8, Cout8);

        if ({Cout8, Sum8} === expected8)
            $display("8-BIT ADDITION PASS");
        else
            $display("8-BIT ADDITION FAIL");


        // TEST 4: 8-bit carry input
        A8 = 8'd100;
        B8 = 8'd50;
        Cin8 = 1;

        expected8 = {1'b0, A8} +
                    {1'b0, B8} + Cin8;

        #10;

        $display("\n--- 8-BIT CIN TEST ---");
        $display("A = %d, B = %d, Cin = %b",
                  A8, B8, Cin8);
        $display("Sum = %d, Cout = %b",
                  Sum8, Cout8);

        if ({Cout8, Sum8} === expected8)
            $display("8-BIT CIN TEST PASS");
        else
            $display("8-BIT CIN TEST FAIL");


        $display("\n========== SIMULATION COMPLETED ==========");

        $finish;

    end

endmodule


