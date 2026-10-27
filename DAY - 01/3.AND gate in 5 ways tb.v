//1
`timescale 1ns/1ps

module tb_and1;
    reg a, b;
    wire y;

    and_gate1 dut (.a(a), .b(b), .y(y));

    initial begin
        $monitor("T=%0t a=%b b=%b y=%b",
                  $time, a, b, y);

        a=0; b=0; #10;
        a=0; b=1; #10;
        a=1; b=0; #10;
        a=1; b=1; #10;

        $finish;
    end
endmodule
//2
`timescale 1ns/1ps

module tb_and2;
    reg a, b;
    wire y;
    integer i;

    and_gate2 dut (.a(a), .b(b), .y(y));

    initial begin
        $display("A B | Y");

        for (i = 0; i < 4; i = i + 1) begin
            {a, b} = i;
            #10;
            $display("%b %b | %b", a, b, y);
        end

        $finish;
    end
endmodule
//3
`timescale 1ns/1ps

module tb_and3;
    reg a, b;
    wire y;

    and_gate3 dut (.a(a), .b(b), .y(y));

    task apply_inputs;
        input x, z;
        begin
            a = x;
            b = z;
            #10;
            $display("A=%b B=%b Y=%b", a, b, y);
        end
    endtask

    initial begin
        apply_inputs(0, 0);
        apply_inputs(0, 1);
        apply_inputs(1, 0);
        apply_inputs(1, 1);
        $finish;
    end
endmodule
//4
`timescale 1ns/1ps

module tb_and4;
    reg a, b;
    wire y;
    reg expected;

    and_gate4 dut (.a(a), .b(b), .y(y));

    initial begin
        a=0; b=0; expected=0; #10;
        if (y !== expected)
            $display("FAIL: a=%b b=%b y=%b", a, b, y);
        else
            $display("PASS: a=%b b=%b y=%b", a, b, y);

        a=0; b=1; expected=0; #10;
        if (y !== expected)
            $display("FAIL: a=%b b=%b y=%b", a, b, y);
        else
            $display("PASS: a=%b b=%b y=%b", a, b, y);

        a=1; b=0; expected=0; #10;
        if (y !== expected)
            $display("FAIL: a=%b b=%b y=%b", a, b, y);
        else
            $display("PASS: a=%b b=%b y=%b", a, b, y);

        a=1; b=1; expected=1; #10;
        if (y !== expected)
            $display("FAIL: a=%b b=%b y=%b", a, b, y);
        else
            $display("PASS: a=%b b=%b y=%b", a, b, y);

        $finish;
    end
endmodule
//5
`timescale 1ns/1ps

module tb_and5;
    reg a, b;
    wire y;
    integer i;

    and_gate5 dut (.a(a), .b(b), .y(y));

    initial begin
        i = 0;

        $display("A B | Y");

        while (i < 4) begin
            {a, b} = i;
            #10;
            $display("%b %b | %b", a, b, y);
            i = i + 1;
        end

        $finish;
    end
endmodule
