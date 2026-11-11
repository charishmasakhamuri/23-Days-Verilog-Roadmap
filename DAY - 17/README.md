Day 17 – Short Notes: Compiler Directives and Timing
1. Compiler Directives
- Special instructions given to the Verilog compiler.
- Begin with a backtick (`).
- Control source-code processing and simulation settings.
- They do not directly create hardware.
2. Important Compiler Directives
Directive	Purpose
`define	Defines a macro
`undef	Removes a macro
`include	Includes another Verilog file
`ifdef	Checks whether a macro is defined
`ifndef	Checks whether a macro is not defined
`else	Alternative compilation block
`endif	Ends conditional compilation
`timescale	Defines simulation time unit and precision
`default_nettype	Sets the default net type
`resetall	Resets compiler directive settings

3. define and undef
- `define creates reusable macros.
- Helps avoid repeated values and improves readability.
- `undef removes an existing macro.
4. `include
- Includes the contents of another Verilog file.
- Useful for sharing common definitions and macros.
- Helps organize large RTL projects.
5. Conditional Compilation
- `ifdef: Compiles code if a macro is defined.
- `ifndef: Compiles code if a macro is not defined.
- `else: Provides an alternative block.
- `endif: Ends the conditional block.
- Used for debug modes and different design configurations.
6. `timescale
Defines simulation time unit and precision.

Example: `timescale 1ns/1ps
- Time unit = 1 ns.
- Time precision = 1 ps.
- Controls how simulation delays are interpreted and rounded.
7. Delay Controls
- # is used to introduce simulation delays.
- Inter-assignment delay: #5 A = B;
- Intra-assignment delay: A = #5 B;
- Nonblocking delay: A <= #5 B;
- Mainly used in testbenches and simulation.
8. Clock Generation
- A clock can be generated using an always block and delay control.
- Example: always #5 clk = ~clk;
- Clock period = 10 ns.
- Frequency = 100 MHz.
- Duty cycle = 50%.
9. Event Scheduling
Verilog simulator executes events in scheduling regions.

Important regions:
- Active: Executes procedural statements.
- Inactive: Processes #0 scheduled events.
- NBA: Updates nonblocking assignments.
- Monitor: Handles end-of-time-slot monitoring activities.
SystemVerilog adds further scheduling regions for assertions and testbench execution.
10. Blocking vs Nonblocking
Blocking (=)	Nonblocking (<=)
Updates immediately	Schedules update in NBA region
Used commonly in combinational logic	Used commonly in sequential logic
Statements execute in order	Updates occur after evaluation

11. Race Condition
- Occurs when simulation results depend on the execution order of concurrent processes.
- Can cause unexpected simulation behavior.
- Avoid using nonblocking assignments for clocked sequential RTL and driving testbench inputs away from the sampling edge.
12. Simulation vs Physical Timing
- Simulation delay represents simulator time.
- Physical delay depends on actual hardware characteristics.
- #5 does not create a guaranteed 5 ns physical delay.
- Static Timing Analysis (STA) checks real implementation timing.
