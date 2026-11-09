//. Parameterized 2:1 MUX

module mux_2to1 #(
    parameter WIDTH = 4
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire sel,
    output wire [WIDTH-1:0] Y
);

    assign Y = sel ? B : A;

endmodule

//Parameterized Ripple Carry Adder using Generate-for
module full_adder (
    input  wire a, b, cin,
    output wire sum, cout
);


assign sum = a ^ b ^ cin;
assign cout = (a & b)	

(a & cin);

endmodule
module ripple_carry_adder #(
    parameter WIDTH = 4
)(
    input  wire [WIDTH-1:0] A,
    input  wire [WIDTH-1:0] B,
    input  wire Cin,
    output wire [WIDTH-1:0] Sum,
    output wire Cout
);


wire [WIDTH:0] carry;

assign carry[0] = Cin;
assign Cout = carry[WIDTH];

genvar i;

generate
for (i = 0; i < WIDTH; i = i + 1) begin : FA_BLOCK

full_adder FA (
.a(A[i]),
.b(B[i]),
.cin(carry[i]),
.sum(Sum[i]),
.cout(carry[i+1])
);

end
endgenerate

endmodule
