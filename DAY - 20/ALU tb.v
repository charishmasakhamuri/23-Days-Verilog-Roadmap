
`timescale 1ns/1ps

module tb_parameterized_alu;

    parameter WIDTH = 8;

    reg [WIDTH-1:0] A, B;
    reg [2:0] OP;

    wire [WIDTH-1:0] RESULT;
    wire CARRY, ZERO;

    reg [WIDTH:0] expected;
    reg expected_zero;

    integer errors;
    integer i, j, k;

    // DUT instantiation
    parameterized_alu #(.WIDTH(WIDTH)) dut (
        .A(A),
        .B(B),
        .OP(OP),
        .RESULT(RESULT),
        .CARRY(CARRY),
        .ZERO(ZERO)
    );

    // Independent reference model
    function [WIDTH:0] reference_model;

        input [WIDTH-1:0] a, b;
        input [2:0] op;

        begin
            case (op)

                3'b000:
                    reference_model =
                        {1'b0,a} + {1'b0,b};

                3'b001: begin
                    reference_model[WIDTH-1:0] = a - b;
                    reference_model[WIDTH] = (a < b);
                end

                3'b010:
                    reference_model = {1'b0,(a & b)};

                3'b011:
                    reference_model = {1'b0,(a | b)};

                3'b100:
                    reference_model = {1'b0,(a ^ b)};

                3'b101:
                    reference_model = {1'b0,(~a)};

                3'b110:
                    reference_model = {1'b0,(a << 1)};

                3'b111:
                    reference_model = {1'b0,(a >> 1)};

                default:
                    reference_model = 0;

            endcase
        end

    endfunction

    // Self-checking task
    task check_result;

        input [WIDTH-1:0] a_in, b_in;
        input [2:0] op_in;

        begin

            A = a_in;
            B = b_in;
            OP = op_in;

            expected =
                reference_model(a_in,b_in,op_in);

            expected_zero =
                (expected[WIDTH-1:0] == 0);

            #1;

            if ({CARRY,RESULT} !== expected ||
                ZERO !== expected_zero) begin

                $display("FAIL: A=%h B=%h OP=%b",
                         A,B,OP);

                $display("Actual=%h Expected=%h",
                         {CARRY,RESULT},expected);

                errors = errors + 1;

            end

        end

    endtask

    initial begin

        errors = 0;

        $display("--------------------------------");
        $display(" PARAMETERIZED ALU VERIFICATION ");
        $display(" WIDTH = %0d", WIDTH);
        $display("--------------------------------");

        // Directed testing
        $display("Directed testing...");

        check_result(8'd10, 8'd5, 3'b000);
        check_result(8'd10, 8'd5, 3'b001);
        check_result(8'd10, 8'd5, 3'b010);
        check_result(8'd10, 8'd5, 3'b011);
        check_result(8'd10, 8'd5, 3'b100);
        check_result(8'd10, 8'd5, 3'b101);
        check_result(8'd10, 8'd5, 3'b110);
        check_result(8'd10, 8'd5, 3'b111);

        // Corner-case testing
        $display("Corner-case testing...");

        check_result(8'd0,   8'd0,   3'b000);
        check_result(8'd255, 8'd1,   3'b000);
        check_result(8'd0,   8'd1,   3'b001);
        check_result(8'd255, 8'd255, 3'b010);
        check_result(8'd0,   8'd0,   3'b101);
        check_result(8'd128, 8'd0,   3'b110);
        check_result(8'd1,   8'd0,   3'b111);

        // Exhaustive testing
        $display("Exhaustive testing...");

        for (k = 0; k < 8; k = k + 1) begin

            for (i = 0; i < 256; i = i + 1) begin

                for (j = 0; j < 256; j = j + 1) begin

                    check_result(i,j,k);

                end

            end

        end

        // Final report
        $display("--------------------------------");

        if (errors == 0)
            $display("ALL TESTS PASSED!");
        else
            $display("TEST FAILED: %0d errors", errors);

        $display("Exhaustive combinations = 524288");
        $display("Total errors = %0d", errors);

        $display("--------------------------------");

        $finish;

    end

endmodule
