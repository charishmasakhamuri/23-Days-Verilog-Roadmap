Day 21 – Short Notes
1. FIFO (First In, First Out)
- FIFO is a memory structure that follows First In, First Out data ordering.
- The first data written is the first data read.
- Used for temporary data storage and buffering.
2. FIFO Architecture
Main components:
- Memory array.
- Write pointer.
- Read pointer.
- Full flag.
- Empty flag.
- Occupancy counter.
- Control logic.
3. FIFO Parameters
- Width: Number of bits stored in each location.
- Depth: Number of memory locations.
- Capacity: Width × Depth.
Example: 8-bit width and depth 4 = 32 bits.
4. Write Operation
- Controlled by wr_en.
- Data is stored when writing is accepted.
- Write pointer advances after a successful write.
- Writing is rejected when FIFO is full, except when a simultaneous read makes space.
5. Read Operation
- Controlled by rd_en.
- Data is retrieved from the read pointer.
- Read pointer advances after a successful read.
- Reading is rejected when FIFO is empty.
- In this design, read data is registered.
6. Full and Empty Flags
Flag	Condition
Full	Count = FIFO depth
Empty	Count = 0

7. FIFO Overflow and Underflow
- Overflow: Attempting to write when the FIFO cannot accept data.
- Underflow: Attempting to read when no data is available.
- Proper control logic prevents invalid operations.
8. Simultaneous Read and Write
- Both operations can happen during the same clock cycle.
- Occupancy remains unchanged when both are accepted.
- At full capacity, a simultaneous read and write can both be accepted.
- When empty, a simultaneous request accepts the write but rejects the read in this design.
9. FIFO Pointer Management
- Write pointer identifies the next write location.
- Read pointer identifies the next read location.
- Both pointers wrap around to zero after reaching the final memory location.
10. Synchronous vs Asynchronous FIFO
Synchronous FIFO	Asynchronous FIFO
Uses one clock	Uses separate read/write clocks
Same clock domain	Different clock domains
Simpler design	More complex design
No CDC pointer synchronization needed	Requires CDC techniques
Used for same-clock buffering	Used for cross-clock data transfer

11. FIFO Applications
- UART communication.
- AXI and AXI-Stream interfaces.
- NoC routers.
- Processor data buffering.
- Image processing.
- Systolic hardware accelerators.
