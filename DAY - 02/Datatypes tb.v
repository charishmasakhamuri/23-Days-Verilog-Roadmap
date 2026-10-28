`timescale 1ns/1ps

module tb_datatype_demo;

    reg clk, rst, wire_in;
    reg [3:0] data_in;

    wire wire_out;
    wire reg_out;
    wire [7:0] vector_out;
    wire signed [3:0] signed_out;
    wire [3:0] unsigned_out;

    // Traditional Verilog simulation types
    integer count;
    time sim_time;
    real voltage;
    realtime elapsed_time;

    // SystemVerilog data types
    logic [7:0] logic_data;
    bit [3:0] bit_data;
    byte byte_data;
    shortint short_data;
    int int_data;
    longint long_data;

    // Enumeration type
    typedef enum logic [1:0] {
        IDLE, RUN, DONE
    } state_t;

    state_t state;

    // Packed structure
    typedef struct packed {
        logic valid;
        logic [3:0] payload;
    } packet_t;

    packet_t packet;

    datatype_demo dut (
        .clk(clk),
        .rst(rst),
        .wire_in(wire_in),
        .data_in(data_in),
        .wire_out(wire_out),
        .reg_out(reg_out),
        .vector_out(vector_out),
        .signed_out(signed_out),
        .unsigned_out(unsigned_out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        wire_in = 0;
        data_in = 0;

        // Initialize variables
        count = 25;
        voltage = 3.3;
        logic_data = 8'hA5;
        bit_data = 4'b1010;
        byte_data = 8'sd25;
        short_data = 16'sd1000;
        int_data = 32'sd50000;
        long_data = 64'sd100000;
        state = IDLE;
        packet.valid = 1'b1;
        packet.payload = 4'b1010;

        #12 rst = 0;

        wire_in = 1;
        data_in = 4'b0111;
        #10;

        wire_in = 0;
        data_in = 4'b1111;
        #10;

        // Simulation time types
        sim_time = $time;
        elapsed_time = $realtime;

        $display("\n--- Verilog Data Types ---");
        $display("wire_out=%b reg_out=%b", wire_out, reg_out);
        $display("vector_out=%b", vector_out);
        $display("signed_out=%0d unsigned_out=%0d",
                  signed_out, unsigned_out);

        $display("\n--- Simulation Types ---");
        $display("integer count=%0d", count);
        $display("time=%0t", sim_time);
        $display("real voltage=%0f", voltage);
        $display("realtime=%0f", elapsed_time);

        $display("\n--- SystemVerilog Types ---");
        $display("logic_data=%h", logic_data);
        $display("bit_data=%b", bit_data);
        $display("byte=%0d shortint=%0d", byte_data, short_data);
        $display("int=%0d longint=%0d", int_data, long_data);
        $display("enum state=%0d", state);
        $display("struct packet=%b", packet);

        $finish;
    end

    initial begin
        $monitor("T=%0t rst=%b in=%b data=%b | wire=%b reg=%b vector=%b",
                  $time, rst, wire_in, data_in,
                  wire_out, reg_out, vector_out);
    end

endmodule
