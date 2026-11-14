Day 19 – Short Notes: Advanced RTL Design Patterns
1. Parameterizable Modules
- A parameterized module is a reusable RTL module whose design characteristics can be changed during instantiation.
- Improves code reusability and flexibility.
- Avoids writing separate modules for different data widths.
- Used in ALUs, adders, memories and FIFOs.
Parameter vs Localparam
Parameter	Localparam
Configurable constant	Internal constant
Can be overridden during instantiation	Cannot be overridden through normal parameter overrides
Used for module configuration	Used for internal calculations

$clog2: Returns the ceiling of the base-2 logarithm of a number. Commonly used to calculate address and pointer widths.
2. Pipelining
- Pipelining divides a complex operation into multiple smaller stages.
- Registers are placed between stages.
- Allows multiple data items to be processed simultaneously.
- Improves throughput and helps meet timing requirements.
Important terms:
- Latency: Time taken for one input transaction to produce its output.
- Throughput: Number of transactions processed per unit time.
- Clock period: Time between consecutive clock edges.
Pipeline hazards:
1. Data hazard – Dependency between operations.
2. Control hazard – Changes in program or control flow.
3. Structural hazard – Multiple operations require the same hardware resource.
Applications: CPU pipelines, image processing, DSP and systolic arrays.
3. Valid/Ready Handshake Protocol
- A flow-control mechanism used for data transfer between hardware modules.
- Uses two control signals:
- VALID: Sender has valid data.
- READY: Receiver is ready to accept data.
Data transfer condition:
\[
Transfer = VALID \land READY
\]

VALID	READY	Operation
0	0	No transfer
0	1	Receiver ready, no data
1	0	Data available, receiver not ready
1	1	Data transfer occurs

Backpressure:
- Occurs when the receiver cannot accept more data.
- Receiver deasserts READY.
- Sender holds VALID and data stable until transfer occurs.
Applications: AXI, AXI-Stream, FIFOs and NoC routers.
4. Clock-Domain Crossing (CDC)
- CDC occurs when a signal or data moves between two different clock domains.
- Example: 100 MHz clock communicating with a 50 MHz clock.
- Requires special techniques to transfer signals safely.
5. Metastability
- A temporary unstable condition in a flip-flop.
- Can occur when input changes near the active clock edge.
- May result from setup-time or hold-time violations.
- Can cause unpredictable behavior.
6. Two-Flip-Flop Synchronizer
- Commonly used for synchronizing single-bit control signals.
- Uses two flip-flops driven by the destination clock.
- First flip-flop may become metastable.
- Second flip-flop provides additional settling time.
- Reduces the probability of metastability propagating.
Important: It reduces metastability risk but does not completely eliminate it.
7. Multi-bit CDC
A two-flip-flop synchronizer should not be used independently on every bit of a coherent multi-bit data bus.

Common solutions:
- Asynchronous FIFO.
- Handshake-based CDC.
- Gray-code pointer synchronization.
8. Synchronous vs Asynchronous FIFO
Synchronous FIFO	Asynchronous FIFO
One common clock	Separate read/write clocks
Same clock domain	Different clock domains
Simpler design	More complex design
No CDC pointer synchronization needed	Requires pointer synchronization

9. Gray Code
- A binary-to-Gray conversion technique.
- Only one bit changes between consecutive Gray-code values.
- Reduces the risk of inconsistent multi-bit pointer sampling.
- Commonly used in asynchronous FIFO pointer synchronization.
