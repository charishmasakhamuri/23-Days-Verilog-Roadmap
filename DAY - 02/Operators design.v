module operator_demo (
    input  [3:0] a, b,
    input        sel,

    output [4:0] add_result,
    output [3:0] sub_result, mul_result,
    output [3:0] div_result, mod_result,

    output gt, lt, eq, neq, ge, le,
    output logical_and, logical_or, logical_not,
    output [3:0] bitwise_and, bitwise_or,
    output [3:0] bitwise_xor, bitwise_not,

    output reduction_and, reduction_or,
    output reduction_xor, reduction_xnor,

    output [3:0] left_shift, right_shift,
    output [3:0] mux_result,
    output [7:0] concat_result,
    output [3:0] replicate_result
);

    // 1. Arithmetic operators
    assign add_result = a + b;
    assign sub_result = a - b;
    assign mul_result = a * b;
    assign div_result = (b != 0) ? a / b : 4'b0000;
    assign mod_result = (b != 0) ? a % b : 4'b0000;

    // 2. Relational and equality operators
    assign gt  = (a > b);
    assign lt  = (a < b);
    assign eq  = (a == b);
    assign neq = (a != b);
    assign ge  = (a >= b);
    assign le  = (a <= b);

    // 3. Logical operators
    assign logical_and = (a && b);
    assign logical_or  = (a || b);
    assign logical_not = !a;

    // 4. Bitwise operators
    assign bitwise_and = a & b;
    assign bitwise_or  = a | b;
    assign bitwise_xor = a ^ b;
    assign bitwise_not = ~a;

    // 5. Reduction operators
    assign reduction_and  = &a;
    assign reduction_or   = |a;
    assign reduction_xor  = ^a;
    assign reduction_xnor = ~^a;

    // 6. Shift operators
    assign left_shift  = a << 1;
    assign right_shift = a >> 1;

    // 7. Conditional operator (MUX)
    assign mux_result = sel ? b : a;

    // 8. Concatenation
    assign concat_result = {a, b};

    // 9. Replication
    assign replicate_result = {4{sel}};

endmodule
