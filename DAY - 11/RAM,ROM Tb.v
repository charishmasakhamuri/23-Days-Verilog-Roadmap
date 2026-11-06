
`timescale 1ns/1ps

module tb_single_port_ram;

    reg clk, we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    single_port_ram dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock period = 10 ns
    always #5 clk = ~clk;

    initial begin
        clk  = 0;
        we   = 0;
        addr = 0;
        din  = 0;

        // Write 25 to address 3
        @(negedge clk);
        we   = 1;
        addr = 3;
        din  = 25;

        @(posedge clk);
        #1;
        $display("WRITE: addr=3 data=25");

        // Write 50 to address 5
        @(negedge clk);
        addr = 5;
        din  = 50;

        @(posedge clk);
        #1;
        $display("WRITE: addr=5 data=50");

        // Read address 3
        @(negedge clk);
        we   = 0;
        addr = 3;

        @(posedge clk);
        #1;
        $display("READ: addr=3 data=%0d", dout);

        // Read address 5
        @(negedge clk);
        addr = 5;

        @(posedge clk);
        #1;
        $display("READ: addr=5 data=%0d", dout);

        if (dout == 50)
            $display("RAM TEST PASSED");
        else
            $display("RAM TEST FAILED");

        $finish;
    end

endmodule

//rom
`timescale 1ns/1ps

module tb_rom_8x8;

reg  [2:0] addr;
    wire [7:0] data;

integer i;
    integer errors;

rom_8x8 dut (
        .addr(addr),
        .data(data)
    );

initial begin
        errors = 0;

$display("Address | Data");
        $display("----------------");

        for (i = 0; i <8; i = i + 1) begin
            addr = i;
            #10;

            $display("   %0d    |  %0d", addr, data);

if (data !== (i + 1) * 10)
                errors = errors + 1;
        end

if (errors == 0)
            $display("ROM TEST PASSED");
        else
            $display("ROM TEST FAILED: %0d errors", errors);

$finish;
    end

endmodule
