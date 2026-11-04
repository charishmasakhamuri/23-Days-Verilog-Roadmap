1. Blocking Assignment (=)
- Executes immediately.
- Statements execute one after another.
- Later statements see updated values.
- Mainly used in combinational logic.
always @(*) begin
    y = a;
    z = y;
end


2. Non-blocking Assignment (<=)
- Schedules the left-hand-side update for the NBA region.
- RHS is evaluated when the statement executes.
- Later statements see the old value.
- Mainly used in sequential logic.
always @(posedge clk) begin
    q1 <= d;
    q2 <= q1;
end


3. Blocking vs Non-blocking
Blocking =	Non-blocking <=
Immediate update	Scheduled update
Procedural order matters	Updates occur in NBA region
Combinational logic	Sequential logic
Can cause race conditions	Avoids many clocked-process races

Golden rule: Combinational → =; Sequential → <=.
4. Event Controls
Event controls determine when a procedural block executes.
Event	Meaning
@	Wait for an event
posedge clk	Rising edge
negedge clk	Falling edge
@(a or b)	When a or b changes
wait(condition)	Wait until condition becomes true

5. Sensitivity Lists
- Specify which signal changes trigger an always block.
- always @(*) automatically includes signals read in the block.
- Used for combinational logic.
always @(*) begin
    y = a & b;
end


Important: Missing signals in a manually written sensitivity list can cause simulation mismatches.
6. Race Conditions
- Occur when simulation results depend on the execution order of concurrent processes.
- Commonly caused by interacting processes using blocking assignments.
- Avoid using non-blocking assignments in clocked sequential logic.
- Avoid multiple procedural drivers for the same register.
7. Verilog Event Scheduling
Important simulation regions:
Region	Purpose
Active	Executes procedural statements
Inactive	Processes #0 scheduled events
NBA	Updates non-blocking assignments
Observed	Evaluates certain assertions
Reactive	Executes certain assertion/program activity
Postponed	Final observation, such as $strobe

8. Delta Cycles
- Zero-simulation-time scheduling steps.
- Used to propagate signal changes through logic.
- Do not represent physical hardware delay.
9. Delay Controls
Type	Example
Procedural delay	#10 a = b;
Blocking intra-assignment delay	a = #10 b;
Non-blocking intra-assignment delay	a <= #10 b;

#delay is generally used in testbenches and simulation models, not synthesizable RTL.
10. SystemVerilog Procedural Blocks
Block	Purpose
always @(*)	Combinational logic
always_comb	SystemVerilog combinational logic
always @(posedge clk)	Sequential logic
always_ff	SystemVerilog sequential logic

11. Important System Tasks
Task	Purpose
$display	Prints immediately when executed
$monitor	Prints when monitored values change
$strobe	Prints at the end of the current time slot
$time	Returns simulation time
$finish	Ends simulation

12. Timing and Physical Hardware
- Setup time: Data must be stable before the clock edge.
- Hold time: Data must remain stable after the clock edge.
- Clock-to-Q delay: Time from clock edge to output change.
- Clock skew: Difference in clock arrival times.
- Clock jitter: Variation in clock edge timing.
- Metastability: Temporary uncertain flip-flop state due to timing violations.
