Behavioral modeling describes the functionality of digital circuits using procedural statements such as always, initial, if-else, case and loops.

It is mainly used to design combinational and sequential circuits.
1. Procedural Blocks
Verilog has two main procedural blocks.
Initial block	Always block
Executes once	Executes repeatedly when triggered
Mainly used in testbenches	Used in RTL and testbenches
Commonly used for stimulus	Used for combinational and sequential logic

Example:
initial begin
    a = 0;
    #10 a = 1;
end


always @(*) begin
    y = a & b;
end


2. Types of Always Blocks
A. Combinational always block
always @(*) begin
    y = a & b;
end


- Output depends on current inputs.
- No memory is required.
- Use blocking assignment (=).
- Assign outputs in every possible execution path.
B. Sequential always block
always @(posedge clk) begin
    q <= d;
end


- Output depends on current inputs and previous state.
- Uses memory elements such as flip-flops.
- Normally uses nonblocking assignment (<=).
3. Conditional Statements
Used to select operations based on conditions.

If-else
always @(*) begin
    if (sel)
        y = b;
    else
        y = a;
end


Application: Multiplexer, comparator and priority encoder.

If-else-if
if (a > b)
    y = 2'b01;
else if (a < b)
    y = 2'b10;
else
    y = 2'b00;


Application: Priority-based control logic.

Case statement
always @(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        2'b11: y = d;
        default: y = 0;
    endcase
end


Application: MUX, ALU operation selection and FSM.
4. Looping Statements
Loop	Function	Common application
for	Repeats using initialization, condition and update	Repeated hardware generation
while	Repeats while condition is true	Testbench
repeat	Executes a fixed number of times	Clock cycles and stimulus
forever	Executes continuously	Testbench clock generation

Example:
for (i = 0; i < 4; i = i + 1)
    y[i] = ~a[i];


Interview point: Statically bounded for loops can be synthesized and generally unrolled into hardware. Do not assume every loop is synthesizable.
5. Blocking vs Nonblocking Assignments
One of the most important RTL interview topics.
Blocking =	Nonblocking <=
Executes immediately	Schedules an update
Procedural order matters	Updates occur later in the simulation time step
Used in combinational logic	Used in sequential logic
Later statements see updated values	Later statements generally see old values

Example:
// Combinational
always @(*) begin
    y = a & b;
end

// Sequential
always @(posedge clk) begin
    q <= d;
end


Remember: Blocking for combinational logic; nonblocking for clocked sequential logic is the recommended RTL coding convention.
6. Latch Inference
A latch is inferred when an output is not assigned in every possible execution path of a combinational block.

Incorrect:
always @(*) begin
    if (en)
        y = a;
end


When en = 0, y retains its previous value. Therefore, a latch is inferred.

Correct:
always @(*) begin
    y = 0;
    if (en)
        y = a;
end


Why avoid unintended latches?
- Unexpected storage in combinational logic.
- More complicated timing analysis.
- Potential hold-time and race-through concerns.
- Increased debugging effort.
Latches are valid when intentionally designed.
7. Sensitivity Lists
A sensitivity list determines when an always block executes.
Syntax	Meaning
always @(*)	Combinational logic
always @(posedge clk)	Rising clock edge
always @(negedge clk)	Falling clock edge
always @(posedge clk or posedge rst)	Rising clock or asynchronous reset

In SystemVerilog, always_comb and always_ff provide more specialized constructs.
8. Synchronous vs Asynchronous Reset
Reset initializes sequential circuits to a known state.

Synchronous reset: Works only at the active clock edge.
always @(posedge clk) begin
    if (rst)
        q <= 0;
    else
        q <= d;
end


Asynchronous reset: Acts independently of the clock.
always @(posedge clk or posedge rst) begin
    if (rst)
        q <= 0;
    else
        q <= d;
end


Synchronous	Asynchronous
Clock-dependent	Clock-independent assertion
Checked at active clock edge	Responds to reset event
Clock must be available	Can assert without clock
Reset sampled synchronously	Deassertion needs careful synchronization

9. Race Conditions
A race condition occurs when the simulation result depends on the execution order of concurrent procedural blocks.

Example:
always @(posedge clk)
    a = b;

always @(posedge clk)
    b = a;


Using blocking assignments in multiple clocked processes can cause order-dependent behavior.

Solution: Use nonblocking assignments for sequential logic.
always @(posedge clk)
    a <= b;

always @(posedge clk)
    b <= a;


10. Finite State Machines (FSM)
An FSM is a sequential circuit that changes states according to its current state and inputs.

Two types:
Moore FSM	Mealy FSM
Output depends only on current state	Output depends on current state and input
Output changes with state transitions	Output can respond to input changes
Generally more stable outputs	Often fewer states
Traffic light controller	Sequence detector

Applications: UART, SPI, I2C, AXI/APB controllers, NoC routers and vending machines.
11. Case, Casez and Casex
Statement	X handling	Z handling
case	Exact matching	Exact matching
casez	X is not wildcard	Z and ? are wildcards
casex	X is wildcard	Z is wildcard

Example:
casez (data)
    4'b1???: y = 2'b11;
    4'b01??: y = 2'b10;
    4'b001?: y = 2'b01;
    default: y = 2'b00;
endcase


casez is useful for priority encoding.

Interview point: Avoid casex in synthesizable RTL because it can hide unknown values and design bugs.
12. Synthesizable vs Non-Synthesizable Constructs
Construct	Typical synthesis support
always @(*)	Yes
always @(posedge clk)	Yes
if-else	Yes
case	Yes
Statically bounded for	Yes
initial	Generally not for ordinary ASIC RTL; some FPGA initialization is supported
#10 delay	No
$display	No
$monitor	No
$finish	No
forever #5	No

13. Important Additional Topics
These are also worth knowing for interviews:
Topic	Meaning
begin-end	Groups multiple procedural statements
Nested if-else	Multiple conditional decisions
Nested case	Selection within selection
Event control @	Waits for an event
Delay control #	Simulation delay
FSM encoding	Binary, one-hot and Gray
Priority logic	Earlier conditions get priority
disable	Terminates a named procedural block or loop
always_comb	SystemVerilog combinational block
always_ff	SystemVerilog sequential block
