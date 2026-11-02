Day 7 – Sequential Circuits: Simple Theory Notes
23-Day Verilog RTL Challenge
1. Sequential Circuits
- A sequential circuit is a digital circuit whose output depends on present inputs and previous states.
- It contains memory elements to store data.
- Usually operates using a clock signal.
Examples: Flip-flops, registers, counters, FSMs and FIFOs.

Equation:
\[
Q_{next}=f(Q_{current},Inputs)
\]

2. Latch
- A latch is a level-sensitive memory element.
- It stores one bit of data.
- Output follows input when enable is active.
- Holds the previous value when enable is inactive.
D Latch:
Enable	D	Q
0	X	Previous Q
1	0	0
1	1	1

3. Flip-Flop
- A flip-flop is an edge-triggered memory element.
- It stores one bit of data.
- Output changes only at the active clock edge.
Types of triggering:
- Positive edge: Rising edge (0 → 1).
- Negative edge: Falling edge (1 → 0).
4. Types of Flip-Flops
A. SR Flip-Flop
SR stands for Set-Reset.
S	R	Q(next)	Operation
0	0	Q	Hold
0	1	0	Reset
1	0	1	Set
1	1	Invalid	Forbidden

For the basic active-high NOR SR latch.
B. D Flip-Flop
- D stands for Data.
- Stores the input value at the active clock edge.
\[
Q_{next}=D
\]

Application: Registers and pipeline storage.
C. JK Flip-Flop
An improved SR flip-flop that supports toggle operation.
J	K	Q(next)	Operation
0	0	Q	Hold
0	1	0	Reset
1	0	1	Set
1	1	Q̅	Toggle

Race-around condition: Repeated toggling in a level-triggered JK flip-flop when J=K=1 and the clock pulse is sufficiently long.
D. T Flip-Flop
T stands for Toggle.
T	Q(next)	Operation
0	Q	Hold
1	Q̅	Toggle

Application: Counters and frequency dividers.
5. Difference Between Latch and Flip-Flop
Latch	Flip-Flop
Level-sensitive	Edge-sensitive
Controlled by enable	Controlled by clock
Output can change during active enable	Output changes at clock edge
Stores one bit	Stores one bit

6. Registers
- A register is a group of flip-flops used to store multiple bits.
- A 4-bit register contains four flip-flops.
- Used for temporary data storage.
Types:
1. SISO – Serial-In Serial-Out
2. SIPO – Serial-In Parallel-Out
3. PISO – Parallel-In Serial-Out
4. PIPO – Parallel-In Parallel-Out
Applications: CPU registers, data buffering and serial communication.
7. Synchronous Reset
- Reset works only at the active clock edge.
- If reset becomes active between clock edges, the output does not immediately change.
always @(posedge clk) begin
    if (rst)
        Q <= 1'b0;
    else
        Q <= D;
end


8. Asynchronous Reset
- Reset assertion works immediately, without waiting for the clock.
- Commonly used to initialize sequential circuits.
always @(posedge clk or posedge rst) begin
    if (rst)
        Q <= 1'b0;
    else
        Q <= D;
end


Synchronous vs Asynchronous Reset
Synchronous	Asynchronous
Acts at clock edge	Assertion acts immediately
Depends on clock	Does not need clock for assertion
@(posedge clk)	@(posedge clk or posedge rst)
Easier clock-domain timing behavior	Reset release needs careful handling

Important: Asynchronous reset deassertion should be synchronized to avoid recovery/removal violations.
9. Clock Enable
- Controls whether a flip-flop captures new data.
- Enable = 1: Stores new data at the active clock edge.
- Enable = 0: Holds previous data.
always @(posedge clk) begin
    if (en)
        Q <= D;
end


10. Important Timing Parameters
Parameter	Meaning
Setup time	Minimum time data must be stable before the clock edge
Hold time	Minimum time data must remain stable after the clock edge
Clock-to-Q delay	Time from clock edge to output change
Clock period	Time between consecutive clock edges
Recovery time	Reset deassertion requirement before clock edge
Removal time	Reset deassertion requirement after clock edge

11. Metastability
- Metastability is a temporary uncertain state of a flip-flop.
- It can occur when setup or hold timing is violated.
- It is a major concern in Clock Domain Crossing (CDC).
Solution: A two-flop synchronizer reduces the probability of metastability propagating into the destination logic.
12. Clock Concepts
- Clock frequency: Number of clock cycles per second.
- Clock period: Time for one complete cycle.
- Clock skew: Difference in clock arrival times at different flip-flops.
- Clock jitter: Variation in clock edge timing.
- Clock gating: Controls clock delivery to reduce dynamic power.
\[
T=\frac{1}{f}
\]

Example: 100 MHz = 10 ns clock period.
13. Shift Register
- A shift register shifts stored data left or right by one or more bit positions.
- Constructed using flip-flops.
Types: SISO, SIPO, PISO and PIPO.

Applications: Serial communication, data conversion and buffering.
