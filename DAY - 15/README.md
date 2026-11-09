1. What is a Testbench?
A testbench is a simulation environment used to verify the functionality of an RTL design (DUT – Design Under Test).

It applies input stimulus and checks the DUT outputs.

Main components:
1. DUT – Design Under Test.
2. Clock generator.
3. Reset generator.
4. Stimulus generator.
5. Monitor.
6. Checker.
2. DUT (Design Under Test)
- The RTL module being tested.
- Testbench instantiates the DUT.
- Inputs are driven by the testbench.
- Outputs are observed and verified.
3. Clock Generation
A clock is a periodic signal used to synchronize sequential circuits.
- Time period (T): Duration of one complete cycle.
- Frequency (f): Number of cycles per second.
- Duty cycle: Percentage of time the clock remains HIGH.
\[
f=\frac{1}{T}
\]

Example: 10 ns clock period = 100 MHz.
4. Reset Generation
Reset initializes the internal state of a design.

Synchronous reset
- Acts only at the active clock edge.
- Depends on the clock.
Asynchronous reset
- Assertion acts immediately.
- Does not wait for a clock edge.
- Deassertion requires careful synchronization.
5. Stimulus Generation
Stimulus means applying input signals to the DUT.

Types:
- Directed stimulus: Manually selected input values.
- Random stimulus: Automatically generated random inputs.
- Constrained-random stimulus: Random inputs generated according to specified conditions.
6. Important System Tasks
System task	Purpose
$display	Prints values once when executed
$monitor	Prints whenever monitored values change
$strobe	Prints at the end of the current time slot
$write	Prints without automatically adding a newline
$finish	Terminates simulation
$stop	Suspends simulation for debugging
$time	Returns current simulation time
$realtime	Returns real-valued simulation time
$timeformat	Controls time display format

7. $display vs $monitor vs $strobe
$display	$monitor	$strobe
Executes when called	Automatically monitors changes	Executes at end of time slot
Prints once per call	Prints when values change	Shows final values for that time slot
Used for debugging	Used for continuous observation	Useful for checking updated NBA values

8. Timescale Directive
Defines simulation time unit and precision.

Example:

`timescale 1ns/1ps
- Time unit = 1 ns.
- Time precision = 1 ps.
Delay	Simulation time
#1	1 ns
#5	5 ns
#10	10 ns

9. Race Conditions
A race condition occurs when concurrent simulation processes execute at the same time and the result depends on their execution order.

Prevention:
- Drive inputs at the negative clock edge.
- Use nonblocking assignments for clocked RTL.
- Sample outputs after the relevant updates.
- Use SystemVerilog clocking blocks in advanced testbenches.
10. Self-Checking Testbench
A self-checking testbench automatically compares actual output with expected output.
- PASS – Output matches expected value.
- FAIL – Output does not match expected value.
Use !== when unknown values (X or Z) should also cause a failure.
11. Directed vs Random Testing
Directed testing	Random testing
Manually selected inputs	Automatically generated inputs
Easy to debug	Explores more combinations
Tests specific scenarios	Tests varied scenarios
