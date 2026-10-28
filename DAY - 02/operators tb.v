`timescale 1ns/1ps

module tb_operator_demo;

    reg [3:0] a, b;
    reg sel;

    wire [4:0] add_result;
    wire [3:0] sub_result, mul_result;
    wire [3:0] div_result, mod_result;

    wire gt, lt, eq, neq, ge, le;
    wire logical_and, logical_or, logical_not;

    wire [3:0] bitwise_and, bitwise_or;
    wire [3:0] bitwise_xor, bitwise_not;

    wire reduction_and, reduction_or;
    wire reduction_xor, reduction_xnor;

    wire [3:0] left_shift, right_shift;
    wire [3:0] mux_result;
    wire [7:0] concat_result;
    wire [3:0] replicate_result;

    operator_demo dut (
        .a(a), .b(b), .sel(sel),

        .add_result(add_result),
        .sub_result(sub_result),
        .mul_result(mul_result),
        .div_result(div_result),
        .mod_result(mod_result),

        .gt(gt), .lt(lt), .eq(eq), .neq(neq),
        .ge(ge), .le(le),

        .logical_and(logical_and),
        .logical_or(logical_or),
        .logical_not(logical_not),

        .bitwise_and(bitwise_and),
        .bitwise_or(bitwise_or),
        .bitwise_xor(bitwise_xor),
        .bitwise_not(bitwise_not),

        .reduction_and(reduction_and),
        .reduction_or(reduction_or),
        .reduction_xor(reduction_xor),
        .reduction_xnor(reduction_xnor),

        .left_shift(left_shift),
        .right_shift(right_shift),
        .mux_result(mux_result),
        .concat_result(concat_result),
        .replicate_result(replicate_result)
    );

    initial begin
        $monitor(
            "T=%0t a=%b b=%b sel=%b | ADD=%0d SUB=%0d MUL=%0d DIV=%0d MOD=%0d | GT=%b LT=%b EQ=%b | AND=%b OR=%b XOR=%b",
            $time, a, b, sel,
            add_result, sub_result, mul_result,
            div_result, mod_result,
            gt, lt, eq,
            bitwise_and, bitwise_or, bitwise_xor
        );

        // Test 1
        a = 4'd10; b = 4'd3; sel = 0;
        #10;

        // Test 2
        a = 4'd5; b = 4'd5; sel = 1;
        #10;

        // Test 3
        a = 4'd2; b = 4'd7; sel = 0;
        #10;

        // Test 4: division by zero handling
        a = 4'd8; b = 4'd0; sel = 1;
        #10;

        // Display all operator results for the final test
        $display("\n--- Final Test: All Operator Results ---");
        $display("Arithmetic: ADD=%0d SUB=%0d MUL=%0d DIV=%0d MOD=%0d",
            add_result, sub_result, mul_result, div_result, mod_result);

        $display("Relational: GT=%b LT=%b EQ=%b NEQ=%b GE=%b LE=%b",
            gt, lt, eq, neq, ge, le);

        $display("Logical: AND=%b OR=%b NOT_A=%b",
            logical_and, logical_or, logical_not);

        $display("Bitwise: AND=%b OR=%b XOR=%b NOT_A=%b",
            bitwise_and, bitwise_or, bitwise_xor, bitwise_not);

        $display("Reduction: AND=%b OR=%b XOR=%b XNOR=%b",
            reduction_and, reduction_or,
            reduction_xor, reduction_xnor);

        $display("Shift: LEFT=%b RIGHT=%b", left_shift, right_shift);

        $display("MUX=%b CONCAT=%b REPLICATE=%b",
            mux_result, concat_result, replicate_result);

        $finish;
    end

endmodule
