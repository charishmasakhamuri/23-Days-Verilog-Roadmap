module and_gate1 (
    input a, b,
    output y
);
    and (y, a, b);
endmodule

module and_gate2 (
    input a, b,
    output y
);
    assign y = a & b;
endmodule

module and_gate3 (
    input a, b,
    output reg y
);
    always @(*) begin
        y = a & b;
    end
endmodule

module and_gate4 (
    input a, b,
    output y
);
    assign y = (a && b) ? 1'b1 : 1'b0;
endmodule

module and_gate5 (
    input a, b,
    output reg y
);
    always @(*) begin
        if (a == 1'b1 && b == 1'b1)
            y = 1'b1;
        else
            y = 1'b0;
    end
endmodule
