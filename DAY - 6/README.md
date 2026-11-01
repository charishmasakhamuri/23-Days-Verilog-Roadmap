Day 6 – Combinational Circuits: Short Theory Notes
23-Day RTL Design Challenge
1. Combinational circuits
- A combinational circuit is a digital circuit whose output depends only on the present inputs.
- It does not store previous values or require a clock for its basic operation.
- Examples: MUX, DEMUX, encoder, decoder, comparator, adder and ALU.
Difference: Combinational circuits have no memory; sequential circuits contain memory elements and depend on previous states.
2. Multiplexer (MUX)
- MUX is a data selector.
- It selects one input from multiple inputs and sends it to a single output.
- A \(2^n:1\) MUX requires \(n\) select lines.
- Example: 4:1 MUX has 4 inputs, 2 select lines and 1 output.
- Applications: CPU data selection, ALU input selection and data routing.
3. Demultiplexer (DEMUX)
- DEMUX distributes one input to one of multiple outputs.
- Select lines determine which output receives the input.
- Example: 1:4 DEMUX has 1 input, 2 select lines and 4 outputs.
- Applications: Data distribution, communication systems and memory write selection.
4. Encoder
- An encoder converts an active input line into a binary code.
- Example: 4:2 encoder converts 4 input lines into 2 output bits.
- A basic encoder assumes only one input is active at a time.
Priority encoder:
- Handles multiple active inputs.
- Selects the highest-priority input.
- Applications: Interrupt controllers, arbitration and keyboard encoding.
5. Decoder
- A decoder converts binary input into a corresponding active output line.
- Example: 2:4 decoder has 2 inputs and 4 outputs.
- An enable signal controls whether the decoder is active.
- Applications: Memory address decoding, instruction decoding and chip selection.
6. Comparator
- A comparator compares two binary numbers.
- It produces three possible results:
  - A greater than B (A_gt_B)
  - A less than B (A_lt_B)
  - A equal to B (A_eq_B)
- Comparisons can be signed or unsigned.
- Applications: CPU comparison instructions, sorting and control systems.
7. Adder circuits
An adder performs binary addition.
Adder	Function
Half Adder	Adds two 1-bit inputs
Full Adder	Adds two bits and carry-in
Ripple Carry Adder	Connects multiple full adders in series
Carry Look-Ahead Adder	Calculates carry faster using generate and propagate
Carry Select Adder	Computes results for possible carry inputs and selects one
Carry Save Adder	Adds multiple operands efficiently

Important equations:

Half Adder
\[
Sum=A\oplus B
\]

\[
Carry=A\cdot B
\]

Full Adder
\[
Sum=A\oplus B\oplus Cin
\]

\[
Cout=AB+ACin+BCin
\]

Ripple Carry: Simple but slower for wider adders due to carry propagation.

Carry Look-Ahead: Faster carry computation but requires more hardware.
8. Arithmetic Logic Unit (ALU)
- ALU stands for Arithmetic Logic Unit.
- It performs arithmetic and logical operations.
- Operation selection is controlled by select lines.
Common operations:
Operation	Function
ADD	A + B
SUB	A - B
AND	A & B
OR	A | B
XOR	A ^ B
NOT	~A
Shift Left	A > 1

Applications: CPUs, processors, DSPs and hardware accelerators.
9. Additional important combinational circuits
Subtractor
- Performs binary subtraction.
- Half subtractor subtracts two bits.
- Full subtractor also considers borrow-in.
Parity Generator
- Generates parity bits for error detection.
- Even parity makes the total number of 1s even.
- Odd parity makes the total number of 1s odd.
Barrel Shifter
- Shifts binary data by a variable number of positions in one combinational operation.
- Used in processors and DSP systems.
Tri-state Buffer
- Produces 0, 1 or high impedance (Z).
- Used in shared-bus architectures.
10. Important timing concepts
- Propagation delay: Time taken for an input change to affect the output.
- Fan-out: Number of logic inputs that one output can drive reliably.
- Glitch: Temporary unwanted output transition caused by unequal signal propagation delays.
- Static hazard: A brief incorrect transition when the output should remain constant.
- Dynamic hazard: Multiple unwanted transitions when the output should change only once.
11. Verilog coding rules
Concept	Recommended coding
Continuous assignment	assign
Combinational procedural block	always @(*)
SystemVerilog alternative	always_comb
Assignment inside combinational block	Blocking =
Default output assignment	Prevents unintended latches
Clock	Not required for basic combinational logic
Incomplete assignments	Can infer latches

Example:
always @(*) begin
    Y = 1'b0;

    if (sel)
        Y = A;
end


12. Important interview differences
Comparison	Key difference
MUX vs DEMUX	Many inputs to one output vs one input to many outputs
Encoder vs Decoder	Input encoding vs binary decoding
Half Adder vs Full Adder	Full adder includes carry-in
RCA vs CLA	Sequential carry propagation vs look-ahead carry calculation
Carry vs Overflow	Unsigned carry-out vs signed arithmetic overflow
assign vs always @(*)	Continuous assignment vs procedural assignment
Signed vs Unsigned	Different interpretation of binary values
