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
