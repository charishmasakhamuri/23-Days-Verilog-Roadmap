
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


