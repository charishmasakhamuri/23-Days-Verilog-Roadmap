Day 14 – Generate and Parameters (Short Notes)
1. Parameters in Verilog
A parameter is a constant used to configure a module without changing its internal RTL code.
- Improves code reusability.
- Allows configurable data width and memory depth.
- Can be overridden during module instantiation.
Applications: Parameterized ALU, adder, counter, RAM and FIFO.
2. Types of Parameters
Parameter
- Used to configure a module.
- Can be overridden during instantiation.
- Commonly used for width, depth and configuration.
Localparam
- Used for internal constants.
- Cannot be overridden through normal parameter overrides.
- Commonly used for state encoding and derived constants.
Parameter vs Localparam
Parameter	Localparam
Externally configurable	Internally fixed
Can be overridden	Cannot be overridden
Module configuration	Internal constants

3. What is Generate?
Generate is a Verilog construct used to create hardware structures repeatedly or conditionally during elaboration.

Three important types:
1. Generate-for
2. Generate-if
3. Generate-case
Applications:
- Ripple Carry Adder
- Multiplexers
- Counters
- Registers
- Comparators
- Systolic arrays
4. Generate-for
- Used to instantiate repeated hardware blocks.
- Uses genvar.
- Creates multiple hardware instances during elaboration.
- Commonly used in adders, registers and processing elements.
Example application: A 4-bit ripple carry adder requires four full-adder instances.
5. Generate-if
- Used for conditional hardware generation.
- Selects hardware based on compile/elaboration-time constant conditions.
- Only the selected branch is elaborated.
Application: Selecting different hardware architectures based on data width.
6. Generate-case
- Selects one hardware implementation from multiple alternatives.
- Based on a constant expression.
- Useful for configurable hardware designs.
Application: Selecting AND, OR or XOR logic based on a configuration parameter.
7. What is Genvar?
genvar is a special variable used in generate-for loops.

Important points:
- Used during elaboration.
- Controls repeated hardware generation.
- Does not represent a physical hardware register.
- Each iteration generates a separate hardware structure or scope.
8. Generate-for vs Procedural-for
Generate-for	Procedural-for
Uses genvar	Usually uses integer
Elaboration time	Procedural execution
Creates hardware structures	Repeats procedural statements
Used for module instantiation	Used in combinational/sequential logic

Important: A procedural loop with a static bound can also be unrolled into hardware during synthesis.
9. What is Elaboration?
Elaboration is the process that resolves the design hierarchy and constructs the configured hardware model before simulation or synthesis.

During elaboration:
- Parameter values are resolved.
- Localparam expressions are evaluated.
- Generate conditions are evaluated.
- Generate loops are expanded.
- Module instances and connections are resolved.
10. What is Defparam?
- An older Verilog construct used to override module parameters.
- Named parameter overrides during instantiation are preferred.
- defparam cannot override a localparam.
