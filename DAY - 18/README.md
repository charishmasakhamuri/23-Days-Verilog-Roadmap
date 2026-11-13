Day 18 – Short Notes: Synthesizable RTL
1. Synthesizable RTL
- RTL code that can be converted into actual hardware by a synthesis tool.
- Synthesis converts RTL into a gate-level netlist.
- Examples: Multiplexers, adders, counters, registers and FSMs.
- Tools: Xilinx Vivado, Synopsys Design Compiler.
2. Synthesizable vs Non-Synthesizable Constructs
Synthesizable	Generally simulation-only
assign	$display
always @(*)	$monitor
always @(posedge clk)	$finish
if-else, case	#10 delays
Parameters	Testbench stimulus
Generate constructs	Testbench clock generation

Synthesizability depends on the coding style and synthesis tool.
3. Latch Inference
- A latch is a level-sensitive storage element.
- It is inferred when a combinational block does not assign a variable on every possible execution path.
- It stores the previous value when its enable condition is inactive.
- Unintended latch inference can cause timing and verification problems.
4. Causes of Latch Inference
- Incomplete if-else statements.
- Missing assignments in case statements.
- Missing default assignments.
- Not assigning outputs in every branch of combinational logic.
5. How to Avoid Latch Inference
- Assign default values at the beginning of combinational blocks.
- Cover all possible conditions.
- Use complete if-else statements.
- Include a default branch in case statements.
- Check synthesis warnings.
6. Combinational Logic
- Output depends only on present inputs.
- Does not store previous values.
- Does not require a clock.
- Uses always @(*).
- Uses blocking assignment (=).
Examples: MUX, DEMUX, decoder, encoder, adder, comparator and ALU.
7. Sequential Logic
- Output depends on present inputs and previous stored state.
- Contains memory elements such as flip-flops.
- Usually operates with a clock.
- Uses always @(posedge clk) or always @(negedge clk).
- Uses nonblocking assignment (<=).
Examples: Counters, registers, FSMs, FIFOs and shift registers.
8. Latch vs Flip-Flop
Latch	Flip-Flop
Level-sensitive	Edge-sensitive
Controlled by enable	Controlled by clock
Output follows input during active enable	Output updates at active clock edge
Stores data	Stores data

9. Blocking vs Nonblocking
Blocking (=)	Nonblocking (<=)
Updates immediately	Schedules update in NBA region
Used commonly in combinational logic	Used commonly in sequential logic
Executes statements in order	RHS values are evaluated before scheduled updates

10. SystemVerilog Coding Styles
- always_comb: Used for combinational logic.
- always_ff: Used for sequential logic.
- Helps improve code readability and detect certain coding errors.
11. Good RTL Coding Practices
- Avoid unintended latch inference.
- Use blocking assignments for combinational logic.
- Use nonblocking assignments for sequential logic.
- Assign all outputs in every combinational branch.
- Avoid multiple drivers.
- Use meaningful signal names.
- Follow proper reset and clocking practices.
- Check synthesis reports and warnings.
12. Real-Time Applications
Circuit	Logic type
ALU	Combinational
Multiplexer	Combinational
Counter	Sequential
FSM	Both
FIFO	Both
Pipeline	Sequential
Systolic array	Both
NoC Router	Both
