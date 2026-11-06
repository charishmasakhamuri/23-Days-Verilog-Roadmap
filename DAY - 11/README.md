Day 11 – Memory Design in Verilog (Short Notes)
1. What is Memory?
Memory is a hardware block used to store and retrieve binary data.
- Depth: Number of memory locations.
- Width: Number of bits per location.
- Capacity: Depth × Width.
- Address: Selects a memory location.
Example: 256 × 8 RAM = 256 locations × 8 bits = 2048 bits.
\[
Address\ Width=\log_2(\text{Depth})
\]

2. Types of Memory
RAM (Random Access Memory)
- Supports read and write operations.
- Usually volatile.
- Used for temporary data storage.
ROM (Read Only Memory)
- Stores predefined data.
- Normally used for read operations.
- Used for lookup tables and fixed data.
3. SRAM vs DRAM
SRAM	DRAM
Uses latch-based cells	Uses capacitor-based cells
No periodic refresh	Requires refresh
Faster typically	Slower typically
Used in cache	Used in main memory

4. Read and Write Operations
- Write: Stores data at a selected address.
- Read: Retrieves data from a selected address.
- WE (Write Enable): Controls writing.
- RE (Read Enable): Controls reading.
// Write
if (we)
    mem[addr] <= din;

// Read
dout <= mem[addr];


5. Synchronous vs Asynchronous Memory
Synchronous	Asynchronous
Controlled by clock edge	Read responds to address changes
Registered read output	Combinational read output
Common in FPGA Block RAM	May use LUT logic or other resources

// Synchronous read
always @(posedge clk)
    dout <= mem[addr];

// Asynchronous read
assign dout = mem[addr];


6. Single-Port vs Dual-Port RAM
- Single-port RAM: One access port.
- Dual-port RAM: Two access ports; supports two operations according to its configuration.
7. Memory Initialization
Loading predefined values into memory.
- $readmemh – Loads hexadecimal data.
- $readmemb – Loads binary data.
initial begin
    $readmemh("memory.hex", mem);
end


8. Memory Inference
Memory inference is when synthesis tools recognize memory behaviour in RTL and map it to hardware memory resources.

Examples:
- Block RAM (BRAM)
- Distributed RAM (LUT RAM)
- Register-based memory
