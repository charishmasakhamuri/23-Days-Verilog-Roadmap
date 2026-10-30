Day 4 – Dataflow Modeling in Verilog
23-Day RTL Design Revision
 Day 4 Theory Notes


Today's topic focuses on Dataflow Modeling, Continuous Assignments, Operators, Operator Precedence, 4-bit Comparator and Arithmetic Unit.
1. What is Dataflow Modeling?
Dataflow modeling is a modeling style in Verilog used to describe the flow of data between inputs and outputs using Boolean expressions and operators.

It describes what logical relationship exists between signals, rather than specifying every individual gate or procedural step.

It mainly uses the assign keyword.

Example:
module and_gate(
    input a, b,
    output y
);

assign y = a & b;

endmodule


Explanation:
- a and b are inputs.
- & performs bitwise AND.
- assign continuously drives output y.
- Whenever an input changes, the output is updated.
Real-time applications:
- ALU design
- Multiplexers
- Comparators
- Adders and subtractors
- Address decoding
- Digital control circuits
2. Continuous Assignment – assign
A continuous assignment is used to drive a net with an expression.

Syntax:
assign output_signal = expression;


Example:
wire a, b;
wire y;

assign y = a & b;


1. Inputs are connected to the expression.
2. Verilog continuously evaluates the expression.
3. If an input changes, the expression is evaluated again.
4. The output is updated automatically.
Important points:
- assign is a continuous assignment.
- It is written outside procedural blocks such as always and initial.
- In traditional Verilog, the left-hand side must be a net such as wire.
- It is commonly used for combinational logic.
- Multiple continuous assignments can drive different nets or different bits of a vector. Multiple drivers on the same net need careful consideration.
3. Operators Used in Dataflow Modeling
Operators perform operations on signals and values.
A. Arithmetic operators
Used for mathematical calculations.
Operator	Operation	Example
+	Addition	assign y = a + b;
-	Subtraction	assign y = a - b;
*	Multiplication	assign y = a * b;
/	Division	assign y = a / b;
%	Modulo	assign y = a % b;

Application: Arithmetic Logic Unit (ALU), counters and address calculations.

Example:
assign sum = a + b;
assign diff = a - b;


B. Relational operators
Used to compare two values.
Operator	Meaning
>	Greater than
<	Less than
>=	Greater than or equal
<=	Less than or equal

Example:
assign greater = (A > B);
assign smaller = (A < B);


Application: Magnitude comparators, threshold detection and control logic.
C. Equality operators
Used to check whether two values are equal or different.
Operator	Meaning
==	Logical equality
!=	Logical inequality
===	Case equality
!==	Case inequality

Example:
assign equal = (A == B);
assign not_equal = (A != B);


Important difference:
- == and != can produce X if unknown bits affect the comparison.
- === and !== compare X and Z as literal values and always produce a known 0 or 1.
Application: Comparators and verification testbenches.
D. Logical operators
Used to combine logical conditions.

| Operator | Meaning |
|---|---|
| && | Logical AND |
| || | Logical OR |
| ! | Logical NOT |

Example:
assign valid = (a != 0) && (b != 0);


Logical operators treat each operand as a logical truth value.
E. Bitwise operators
Perform operations on corresponding bits.

| Operator | Meaning |
|---|---|
| & | AND |
| | | OR |
| ^ | XOR |
| ~ | NOT |
| ~^ | XNOR |
| ^~ | XNOR |

Example:
assign y_and = a & b;
assign y_or  = a | b;
assign y_xor = a ^ b;


Suppose:
a = 4'b1010;
b = 4'b1100;


Operation	Result
a & b	1000
a \| b	1110
a ^ b	0110

Application: ALU, masking, parity generation and bit manipulation.
F. Reduction operators
Reduction operators perform an operation across all bits of a vector and produce a single-bit result.
Operator	Meaning
&a	Reduction AND
~&a	Reduction NAND
\|a	Reduction OR
~\|a	Reduction NOR
^a	Reduction XOR
~^a	Reduction XNOR

Example:
wire [3:0] a;

assign and_result = &a;
assign or_result  = |a;
assign parity     = ^a;


If:
a = 4'b1011;


- Reduction AND = 0
- Reduction OR = 1
- Reduction XOR = 1 (odd number of ones)
Application: Parity generators, parity checkers and error detection.
G. Shift operators
Used to shift bits left or right.
Operator	Meaning
<<	Logical left shift
>>	Logical right shift
<<<	Arithmetic left shift
>>>	Arithmetic right shift

Example:
assign left_shift  = a << 1;
assign right_shift = a >> 1;


For a 4-bit value:
a = 1010

a << 1 = 0100
a >> 1 = 0101


Arithmetic right shift (>>>) preserves the sign bit when the left operand is signed.

Application: Barrel shifters, multipliers, dividers and DSP circuits.
H. Conditional operator ?:
The conditional operator is also called the ternary operator.

It is used to select one of two values based on a condition.

Syntax:
assign y = condition ? value1 : value2;

Select	Output
sel = 0	A
sel = 1	B

Application: Multiplexers, ALU operation selection and control circuits.
I. Concatenation operator { }
Concatenation combines two or more vectors into a single vector.

Example:
wire [3:0] a = 4'b1010;
wire [3:0] b = 4'b1100;

assign y = {a,b};


Result:
y = 8'b10101100


Application: Combining data buses, assembling instruction fields and constructing output vectors.
J. Replication operator {n{value}}
Replication repeats a bit or vector a specified number of times.

Example:
assign y = {4{2'b10}};


Result:
y = 8'b10101010


Application: Creating masks, sign extension and repeated control patterns.

4. Operator Precedence and Associativity
Operator precedence defines which operation is performed first when multiple operators appear in an expression.

Example:
assign y = a | b & c;


Since bitwise AND has higher precedence than bitwise OR:
assign y = a | (b & c);


It is not:
assign y = (a | b) & c;


Important precedence examples
| Expression | Evaluation order |
|---|---|
| a + b * c | a + (b * c) |
| a \| b & c | a \| (b & c) |
| a || b && c | a || (b && c) |
| a > b == 1'b1 | (a > b) == 1'b1 |
| a - b - c | (a - b) - c |

Associativity: When operators have equal precedence, associativity determines how they are grouped.

For example, subtraction is left-associative.
y = a - b - c;


means:
y = (a - b) - c;


Best practice: Use parentheses in complex RTL expressions to make the intended operation clear.
5. Bit Width and Expression Sizing
Bit width determines how many bits are used to represent a value.

For example:
reg [3:0] A, B;
wire [4:0] sum;

assign sum = A + B;


Why is sum 5 bits?

Because the addition of two 4-bit unsigned numbers can generate a carry.

Example:
\[
1111_2+0001_2=10000_2
\]

Signal	Width
A	4 bits
B	4 bits
sum	5 bits

If the output is only 4 bits, the carry may be lost.

Important: Verilog expression sizing rules can affect intermediate results too. Explicitly extend operands when you need to preserve carry.
assign sum = {1'b0,A} + {1'b0,B};


6. Signed and Unsigned Arithmetic
Verilog supports signed and unsigned values.

For a 4-bit vector:
Binary	Unsigned	Signed (two's complement)
0000	0	0
0011	3	3
0111	7	7
1000	8	-8
1111	15	-1

Example:
reg signed [3:0] A;
reg signed [3:0] B;


The signed keyword tells Verilog to interpret the values using two's complement representation.

Application: Signed ALUs, DSP, image processing and mathematical calculations.
7. Sign Extension and Zero Extension
Extension is used when converting a smaller-width value into a larger-width value.
Zero extension
Adds zeros to the most significant side.
reg [3:0] A;
wire [7:0] Y;

assign Y = {4'b0000,A};


Example:
A = 1010
Y = 00001010


Sign extension
Copies the sign bit to the additional upper bits.
reg signed [3:0] A;
wire signed [7:0] Y;

assign Y = {{4{A[3]}},A};


Example:
A = 1010  // -6 as signed 4-bit
Y = 11111010  // -6 as signed 8-bit


Application: ALUs and signed arithmetic datapaths.
8. 4-bit Comparator
A comparator is a combinational circuit that compares two binary numbers.

For two 4-bit inputs A and B, it produces three outputs:
- A greater than B.
- A less than B.
- A equal to B.
| A | B | A>B | A B);
assign A_lt_B = (A < B);
assign A_eq_B = (A == B);
