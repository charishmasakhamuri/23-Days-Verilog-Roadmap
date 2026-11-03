Day 8/23 – Short Notes: Counters and Shift Registers
VLSI Interview Revision
1. Counter
A counter is a sequential circuit that counts clock pulses using flip-flops.

Types of counters:

Synchronous counter

Asynchronous (ripple) counter

Up counter

Down counter

Up/Down counter

MOD-N counter

Ring counter

Johnson counter

Synchronous vs Asynchronous Counter
Synchronous

Asynchronous

Common clock to all FFs

Output of one FF clocks next FF

Faster in general

Slower due to ripple delay

More combinational logic

Simpler logic

Simultaneous triggering

Ripple triggering

2. Up Counter
Increments by 1 for every active clock edge.

Example: 000 → 001 → 010 → 011 → 100.

3. Down Counter
Decrements by 1 for every active clock edge.

Example: 111 → 110 → 101 → 100.

When it reaches zero, it wraps around to the maximum value.

4. Up/Down Counter
Can count in both directions.

Controlled using a mode/direction signal.

Mode

Operation

1

Up counting

0

Down counting

5. MOD-N Counter
A MOD-N counter counts N states and then repeats.


MOD-10 = Decade counter.

MOD-8 = 3-bit binary counter.

MOD-13 = Counts 0 to 12.

6. Ring Counter
A ring counter is a shift-register-based counter in which the last flip-flop output is connected directly to the first flip-flop input.

PPT - Counters PowerPoint Presentation, free download - ID:6160351

Example sequence:

1000
→
0100
→
0010
1000→0100→0010
→
0001
→
1000
→0001→1000

Number of states=N
For 4 flip-flops = 4 states.

Key points:

Direct feedback.

One-hot sequence.

Requires initialization.

Used in sequence generation and control circuits.

7. Johnson Counter
A Johnson counter is also called a twisted ring counter.

The complemented output of the last flip-flop is connected to the first flip-flop input.

Johnson Ring Counter



8. Shift Registers
A shift register is a sequential circuit that stores and shifts binary data using flip-flops.

Applications:

Data storage

Serial communication

Data conversion

Data transfer

Delay generation

Four types of Shift Registers
Pipo Shift Register Circuit Diagram

Type

Input

Output

Application

SISO

Serial

Serial

Serial transfer

SIPO

Serial

Parallel

Serial-to-parallel conversion

PISO

Parallel

Serial

Parallel-to-serial conversion

PIPO

Parallel

Parallel

Data storage

9. Universal Shift Register
Supports four operations:

S1S0 : Operation 00: hold
S1S0 : Operation 01: shift right
S1S0 : Operation 10: Shift left
S1S0 : Operation 11: Parallel load
Multiplexers are used to select the required operation.

10. Important Interview Questions
Question

Short answer

What is a counter?

Sequential circuit that counts clock pulses

What is a ripple counter?

Asynchronous counter

Maximum count of 4-bit counter?

15

Number of states in 5-bit counter?

32

FFs required for MOD-20?

5

What is a decade counter?

MOD-10

Ring counter states?

N

Johnson counter states?

2N

What is a twisted ring counter?

Johnson counter

Which register performs serial-to-parallel conversion?

SIPO

Which performs parallel-to-serial conversion?

PISO

Why use non-blocking assignments?

To model simultaneous sequential updates

What is clock skew?

Difference in clock arrival times

What is overflow?

Counter wraps around after maximum count

