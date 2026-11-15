1. What is an ALU?
An Arithmetic Logic Unit (ALU) is a digital circuit that performs arithmetic and logical operations on binary data.

It is an important component of a CPU and processor datapath.








community.iqoo.com


Main inputs:
- A: First operand.
- B: Second operand.
- OP: Operation selection.
- WIDTH: Configurable data width.
Main outputs:
- RESULT: ALU operation result.
- CARRY: Carry or borrow indicator, depending on operation.
2. Project specifications
We will design a parameterized ALU supporting eight operations.
OP code	Operation	Function
000	ADD	A + B
001	SUB	A - B
010	AND	A & B
011	OR	A | B
100	XOR	A ^ B
101	NOT	~A
110	SLL	Logical left shift
111	SRL	Logical right shift

Design parameters:
- Default WIDTH = 8 bits.
- Configurable WIDTH.
- Combinational logic.
- No clock required.
- Carry output for ADD.
- Borrow output for SUB.
- Zero flag indicates whether RESULT is zero.
3. ALU architecture








chegg.com


The ALU consists of:
1. Input operands.
2. Operation decoder.
3. Arithmetic unit.
4. Logical unit.
5. Shift unit.
6. Output selection logic.
7. Status flags.
The operation selector chooses which result is sent to the output.



Understanding the RTL
1. Parameterization

parameter WIDTH = 8 makes the ALU configurable for different data widths.

2. Arithmetic operations
- Addition produces a possible extra carry bit.
- Subtraction produces a borrow indicator using A < B.
3. Logical operations

AND, OR, XOR and NOT operate bit by bit.

4. Shift operations
- SLL shifts bits left by one position.
- SRL shifts bits right by one position.
- Vacated bit positions are filled with zeros.
5. Zero flag

ZERO becomes HIGH whenever the result is zero.

Important: CARRY is meaningful for addition and subtraction in this design. It is set to zero for other operations.

5. Self-checking testbench
File name: tb_parameterized_alu.v

This testbench includes:
- Directed testing.
- Independent reference model.
- Automatic PASS/FAIL checking.
- Corner-case testing.
- Exhaustive testing of all 8-bit input pairs for all eight operations.
