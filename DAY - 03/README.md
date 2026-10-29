Day 3: Gate-Level Modeling in Verilog — Theory Notes
1. What is Gate-Level Modeling?
Gate-level modeling is a modeling style in Verilog in which a digital circuit is described using built-in logic gate primitives such as AND, OR, NOT, NAND, NOR, XOR, and XNOR.

Each gate is instantiated and connected to other gates to form a digital circuit.

Applications: Basic digital circuit design, adders, control logic, and understanding gate-level netlists.
2. Built-in Gate Primitives
Verilog provides built-in primitives for describing basic logic gates.
Gate	Primitive	Boolean expression	Function
AND	and	\(Y=A\cdot B\)	Output is 1 when all inputs are 1
OR	or	\(Y=A+B\)	Output is 1 when any input is 1
NOT	not	\(Y=\overline A\)	Inverts the input
NAND	nand	\(Y=\overline{AB}\)	Inverts AND output
NOR	nor	\(Y=\overline{A+B}\)	Inverts OR output
XOR	xor	\(Y=A\oplus B\)	Output is 1 when inputs differ
XNOR	xnor	\(Y=\overline{A\oplus B}\)	Output is 1 when inputs are equal
Buffer	buf	\(Y=A\)	Output follows the input

3. Truth Tables
A truth table shows the output of a logic gate for every possible combination of binary inputs.
A	B	AND	OR	NAND	NOR	XOR	XNOR
0	0	0	0	1	1	0	1
0	1	0	1	1	0	1	0
1	0	0	1	1	0	1	0
1	1	1	1	0	0	0	1

For a NOT gate, the truth table is 0 → 1 and 1 → 0.

For \(n\) binary inputs, a complete truth table contains \(2^n\) input combinations. For example, three inputs require \(2^3=8\) rows.
4. Gate Primitive Instantiation
Gate instantiation means creating an instance of a built-in gate inside a Verilog module.

Syntax:
gate_type instance_name (output, input1, input2);


Example:
module and_gate (
    input a, b,
    output y
);
    and g1 (y, a, b);
endmodule


Here, and is the primitive, g1 is the instance name, y is the output, and a and b are the inputs.

Gate primitives use positional connections, with the output listed first. Their outputs are normally connected to nets, such as wire.
5. Universal Gates
NAND and NOR are called universal gates because any Boolean function can be implemented using only NAND gates or only NOR gates.

For example, using NAND gates:
- NOT: nand(y, a, a)
- AND: First NAND the inputs, then invert that output with another NAND.
- OR: Invert both inputs with NAND gates, then NAND those results.
Applications: Digital IC design, logic optimization, memory circuits, and control logic.
6. Gate Delays
A gate delay represents the time between an input change and the corresponding output response in simulation.

Example:
`timescale 1ns/1ps

and #5 g1 (y, a, b);


Here, #5 specifies a delay of 5 ns because the time unit is 1 ns.
Types of gate delays
- Rise delay: Output transitions to logic 1.
- Fall delay: Output transitions to logic 0.
- Turn-off delay: Output transitions to high impedance Z.
Example:
and #(3, 5) g1 (y, a, b);


The rise delay is 3 ns and the fall delay is 5 ns.

Gate delays help study propagation timing during simulation, but they do not guarantee the actual delay of a manufactured chip.
7. Half Adder Using Gate Primitives
A half adder adds two one-bit binary inputs and produces two outputs: sum and carry.
\[
Sum=A\oplus B
\]

\[
Carry=A\cdot B
\]

It is implemented using one XOR gate and one AND gate.

Applications: Arithmetic circuits, adders, and ALU design.
8. Full Adder Using Gate Primitives
A full adder adds three one-bit inputs: \(A\), \(B\), and carry-in \(C_{in}\).
\[
Sum=A\oplus B\oplus C_{in}
\]

\[
Carry=AB+C_{in}(A\oplus B)
\]

A full adder can be built using two XOR gates, two AND gates, and one OR gate.

Applications: Multi-bit binary adders, processors, and arithmetic datapaths.
9. Gate-Level vs. Dataflow vs. Behavioral Modeling
Gate-level	Dataflow	Behavioral
Uses gate primitives	Uses continuous assignments and expressions	Uses procedural blocks
Explicitly instantiates gates	Describes Boolean relationships	Describes the required behavior
Example: and g1(y,a,b);	Example: assign y=a & b;	Example: always @(*) y=a & b;

All three can describe the same combinational function. Gate-level modeling emphasizes structural connections, while dataflow and behavioral styles often make larger designs easier to write and maintain.
10. Testbench and Simulation
A testbench is a Verilog module used to verify a design by applying input combinations and observing outputs.

Important testbench constructs:
- reg — commonly used for testbench stimulus in Verilog.
- wire — commonly used to observe outputs driven by a design.
- initial — executes once at the beginning of simulation.
- #10 — waits for 10 simulation time units.
- $monitor — displays values when monitored signals change.
- $display — prints values when executed.
- $finish — ends simulation.
For two-input gates, testing all four input combinations helps verify the truth table.
