Day 10 – FSM Design: Short Theory Notes
23-Day RTL Design Challenge
1. Finite State Machine (FSM)
- FSM stands for Finite State Machine.
- It is a sequential circuit with a finite number of states.
- Output depends on the current state and, in some FSMs, the present input.
- Used to control operations in a specific sequence.
Examples: Traffic lights, vending machines, UART, SPI, AXI controllers and NoC routers.

FSM equation:
\[
NextState=f(CurrentState,Inputs)
\]

2. Main Components of FSM
1. State Register: Stores the current state using flip-flops.
2. Next-State Logic: Determines the next state.
3. Output Logic: Generates the output signals.
3. Moore Machine
- Output depends only on the current state.
- Output changes when the state changes.
- Generally provides more stable outputs.
\[
Output=f(CurrentState)
\]

4. Mealy Machine
- Output depends on current state and present input.
- Output can change immediately when the input changes.
- Often requires fewer states than an equivalent Moore machine.
\[
Output=f(CurrentState,Input)
\]

Moore vs Mealy
Moore	Mealy
State-dependent output	State and input-dependent output
Output changes with state	Output can change with input
Generally more stable	Can be sensitive to input glitches
May require more states	May require fewer states

5. State Encoding Techniques
State encoding means assigning binary values to FSM states.

A. Binary Encoding
- Uses minimum number of flip-flops.
- For N states, requires \(\lceil\log_2 N\rceil\) flip-flops.
B. One-Hot Encoding
- One flip-flop per state.
- Only one state bit is HIGH at a time.
- Often simplifies state decoding.
C. Gray Encoding
- Adjacent state codes differ by only one bit.
- Can reduce switching activity during adjacent state transitions.
Encoding	Flip-flops
Binary	\(\lceil\log_2 N\rceil\)
One-hot	N
Gray	Usually \(\lceil\log_2 N\rceil\)

6. Sequence Detector
- A sequence detector is an FSM that detects a specific binary pattern.
- Example: Detecting 101 in a serial input stream.
- Used in communication systems and digital data monitoring.
7. Overlapping vs Non-overlapping
Overlapping:
- Previously detected bits can be reused for the next detection.
- Example: Input 10101, pattern 101 gives two detections.
Non-overlapping:
- Previously detected bits cannot be reused.
- For input 10101, pattern 101 gives one detection.
8. Three-Block FSM Coding Style
A professional FSM is commonly divided into three blocks.
Block	Purpose	Assignment
State register	Stores current state	Non-blocking <=
Next-state logic	Calculates next state	Blocking =
Output logic	Generates outputs	Blocking =

State register
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= IDLE;
    else
        state <= next_state;
end


Next-state logic
always @(*) begin
    next_state = state;

    case (state)
        IDLE:
            if (start)
                next_state = RUN;

        RUN:
            if (done)
                next_state = IDLE;

        default:
            next_state = IDLE;
    endcase
end


Output logic (Moore)
always @(*) begin
    busy = 1'b0;

    case (state)
        RUN: busy = 1'b1;
        default: busy = 1'b0;
    endcase
end


9. FSM Extraction in Synthesis
- Synthesis tools identify FSM structures automatically from RTL.
- They recognize state registers and transition logic.
- They may optimize state encoding and logic.
- The result is an optimized gate-level netlist.
Flow: RTL → FSM extraction → Optimization → Gate-level netlist.
10. State Minimization
- Reduces the number of states without changing required input-output behavior.
- Helps reduce hardware complexity.
- Equivalent states can be merged.
11. Illegal-State Recovery
- An illegal state is an unused or unexpected state encoding.
- A default branch can direct the FSM back to its initial state.
default: next_state = IDLE;


Always test recovery behavior during verification.
12. Important FSM Coding Rules
Concept	Recommended practice
State register	always @(posedge clk)
State update	Non-blocking <=
Next-state logic	always @(*)
Next-state assignment	Blocking =
Default next state	next_state = state
Output initialization	Assign default values
Reset	Initialize FSM to IDLE
Invalid state	Include default recovery

13. Real-World Applications
Application	FSM function
Traffic light	Controls light sequence
Vending machine	Handles payment and dispensing
UART	Controls serial transmission/reception
SPI/I2C	Controls communication protocol
AXI/APB	Controls bus transactions
NoC router	Controls routing and arbitration
FIFO	Controls read/write operations
