// 4 bit alu
`timescale 1ns/1ps

module tb_alu_4bit;

    reg [3:0] A, B;
    reg [2:0] OP;

    wire [3:0] result;
    wire carry_out;

    reg [4:0] expected;
    integer errors;
    integer i, j, k;

    // DUT instantiation
    alu_4bit dut (
        .A(A),
        .B(B),
        .OP(OP),
        .result(result),
        .carry_out(carry_out)
    );

    // Reference Model
    function [4:0] reference_model;

        input [3:0] a, b;
        input [2:0] op;

        begin
            case (op)

                3'b000:
                    reference_model = {1'b0, a} + {1'b0, b};

                3'b001: begin
                    reference_model[3:0] = a - b;
                    reference_model[4] = (a < b);
                end

                3'b010:
                    reference_model = {1'b0, (a & b)};

                3'b011:
                    reference_model = {1'b0, (a | b)};

                3'b100:
                    reference_model = {1'b0, (a ^ b)};

                default:
                    reference_model = 5'b00000;

            endcase
        end

    endfunction

    // Self-checking task
    task check_result;

        input [3:0] a_in, b_in;
        input [2:0] op_in;

        begin
            A = a_in;
            B = b_in;
            OP = op_in;

            expected = reference_model(a_in, b_in, op_in);

            #10;

            if ({carry_out, result} !== expected) begin

                $display("FAIL: A=%d B=%d OP=%b ACTUAL=%b EXPECTED=%b",
                         A, B, OP, {carry_out, result}, expected);

                errors = errors + 1;

            end
            else begin

                $display("PASS: A=%d B=%d OP=%b RESULT=%d CARRY/BORROW=%b",
                         A, B, OP, result, carry_out);

            end
        end

    endtask

    // Main test sequence
    initial begin

        errors = 0;

        $display("================================");
        $display("       4-BIT ALU VERIFICATION");
        $display("================================");

        // Directed test cases
        $display("\n--- DIRECTED TESTING ---");

        check_result(4'd5,  4'd3, 3'b000);
        check_result(4'd9,  4'd4, 3'b001);
        check_result(4'd15, 4'd15, 3'b010);
        check_result(4'd10, 4'd5, 3'b011);
        check_result(4'd10, 4'd5, 3'b100);

        // Corner cases
        $display("\n--- CORNER CASE TESTING ---");

        check_result(4'd0,  4'd0,  3'b000);
        check_result(4'd15, 4'd15, 3'b000);
        check_result(4'd0,  4'd15, 3'b001);
        check_result(4'd15, 4'd0,  3'b001);
        check_result(4'd0,  4'd0,  3'b010);
        check_result(4'd15, 4'd15, 3'b011);

        // Exhaustive testing
        $display("\n--- EXHAUSTIVE TESTING ---");

        for (k = 0; k < 5; k = k + 1) begin

            for (i = 0; i < 16; i = i + 1) begin

                for (j = 0; j < 16; j = j + 1) begin

                    check_result(i, j, k);

                end
            end
        end

        // Final report
        $display("\n================================");

        if (errors == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("TEST FAILED! Errors = %0d", errors);

        $display("Total exhaustive test cases = 1280");
        $display("Total errors = %0d", errors);

        $display("================================");

        $finish;

    end

endmodule
