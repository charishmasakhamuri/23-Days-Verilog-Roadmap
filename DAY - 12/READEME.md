Day 12 – FIFO Design (Short Notes)
1. What is FIFO?
FIFO stands for First In, First Out.

The first data written into the FIFO is the first data read out.

Applications: UART, SPI, AXI, NoC routers, processors and image processing.
2. FIFO Architecture
Four main components:
1. Memory: Stores data.
2. Write Pointer: Indicates where next data is written.
3. Read Pointer: Indicates where next data is read.
4. Control Logic: Generates full and empty flags.
3. Write and Read Pointers
- Write pointer increments after an accepted write.
- Read pointer increments after an accepted read.
- Both pointers wrap around when they reach the last memory location.
- They operate independently.
For power-of-two FIFO depth:
\[
Address\ Width=\log_2(D)
\]

4. FIFO Occupancy
Occupancy means the number of valid data items stored.
\[
Count_{next}=Count+Write_{accepted}-Read_{accepted}
\]

Example: 4 writes and 2 reads → occupancy = 2.
5. Full and Empty Flags
Empty condition:
\[
Empty=(wptr=rptr)
\]

Full condition (extra-bit pointer architecture):
- Lower address bits are equal.
- Wrap bits are different.
These conditions are used in conventional power-of-two circular FIFOs.
6. Overflow and Underflow
Overflow	Underflow
Write when FIFO is full	Read when FIFO is empty
Prevent further writing	Prevent further reading
Can cause data loss	Can return invalid/stale data

// Overflow protection
if (wr_en && !full)
    mem[wptr] <= din;

// Underflow protection
if (rd_en && !empty)
    dout <= mem[rptr];


7. Synchronous vs Asynchronous FIFO
Synchronous FIFO	Asynchronous FIFO
Single clock	Two independent clocks
Same clock domain	Different clock domains
Simple design	More complex design
Binary pointers commonly used	Gray-code pointers commonly used

8. Binary vs Gray Code
- Binary pointer: Multiple bits may change during an increment.
- Gray-code pointer: Only one bit changes between consecutive values.
- Gray code helps reduce inconsistent pointer sampling in CDC.
Binary to Gray conversion:
\[
Gray=Binary\oplus(Binary>>1)
\]

Remember: Gray code does not eliminate metastability; synchronizers are still required.
9. Pointer Wraparound
For depth 4, a 2-bit address pointer follows:
00 → 01 → 10 → 11 → 00


An extra pointer bit is used to distinguish full and empty conditions.
10. Simultaneous Read and Write
When both operations are accepted:
\[
Count_{next}=Count
\]
