Day 22 – Short Notes: Debugging and Interview Practice
Today's topics:
1. Finding bugs in RTL.
2. Predicting simulation waveforms.
3. Understanding synthesis implications.
4. RTL debugging techniques.
5. Technical interview preparation.
1. RTL Debugging
- RTL debugging is the process of identifying and correcting errors in Verilog/SystemVerilog designs.
- Helps ensure the design behaves as expected.
- Common debugging tools: Xilinx Vivado, ModelSim, Questa and Riviera-PRO.
Common RTL bugs:
- Incorrect logical conditions.
- Missing assignments.
- Unintended latch inference.
- Incorrect bit widths.
- Blocking vs nonblocking assignment mistakes.
- Reset problems.
- Incorrect FSM transitions.
- FIFO overflow and underflow.
- Clock-domain crossing issues.
2. Debugging Techniques
1. Read compiler and elaboration errors.
2. Check signal declarations and widths.
3. Verify module instantiations and port connections.
4. Apply testbench stimulus.
5. Observe simulation waveforms.
6. Compare actual and expected outputs.
7. Identify the failing condition.
8. Correct the RTL and rerun simulation.
3. Waveform Prediction
- Waveform prediction means determining expected signal values before running simulation.
- Understand clock edges, reset behavior and input changes.
- Track blocking (=) and nonblocking (<=) assignments.
- Understand combinational and sequential logic.
- Observe setup, hold and clock-to-Q timing concepts.
Important signals to observe:
- Clock (clk)
- Reset (rst)
- Input (din)
- Enable (en)
- Output (dout)
- State registers
- Valid and Ready signals
4. Synthesis Implications
Synthesis converts RTL code into hardware structures.
RTL coding style	Hardware implication
assign	Combinational logic
always @(*)	Combinational logic
always @(posedge clk)	Flip-flops
Incomplete assignments	Possible latch inference
case statement	Selection logic / MUX
Arithmetic operators	Adders, subtractors, etc.
Registers between stages	Pipeline registers

Important: Different coding styles can produce different hardware structures, area and timing results.
5. Simulation vs Synthesis
Simulation	Synthesis
Checks functional behavior	Converts RTL into hardware
Uses testbench stimulus	Uses synthesizable RTL
Produces waveforms	Produces a netlist
Detects functional errors	Reports hardware resources
Uses simulation time	Estimates implementation characteristics

6. Common RTL Debugging Mistakes
- Missing semicolons.
- Incorrect port connections.
- Width mismatches.
- Incomplete case statements.
- Incorrect sensitivity lists.
- Missing reset conditions.
- Multiple drivers.
- Incorrect array indexing.
- Race conditions in testbenches.
7. Important Vivado Reports
Report	Purpose
Synthesis Report	Checks synthesis results
Utilization Report	Shows LUT, FF, BRAM usage
Timing Report	Checks timing paths
DRC Report	Identifies design rule violations
Power Report	Estimates power consumption
