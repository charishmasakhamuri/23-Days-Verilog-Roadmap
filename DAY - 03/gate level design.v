module basic_gates (
    input a, b,
    output y_and, y_or, y_not,
    output y_nand, y_nor, y_xor, y_xnor, y_buf
);

    and  g1 (y_and,  a, b);
    or   g2 (y_or,   a, b);
    not  g3 (y_not,  a);
    nand g4 (y_nand, a, b);
    nor  g5 (y_nor,  a, b);
    xor  g6 (y_xor,  a, b);
    xnor g7 (y_xnor, a, b);
    buf  g8 (y_buf,  a);

endmodule

//222
module full_adder (
    input a, b, cin,
    output sum, carry
);
    wire x1, c1, c2;

    xor g1 (x1, a, b);
    xor g2 (sum, x1, cin);

    and g3 (c1, a, b);
    and g4 (c2, x1, cin);
    or  g5 (carry, c1, c2);
endmodule
