# 23-Days-Verilog-Roadmap
A 23-day hands-on learning journey covering Verilog HDL, RTL design, combinational and sequential circuits, FSMs, memories, FIFOs, testbench development, verification techniques, and mini-projects using Xilinx Vivado. Includes code examples, simulation testbenches, and interview preparation.


# Day 01 — Verilog HDL Fundamentals

**Challenge:** 23 Days of Verilog HDL Revision  
**Focus:** Revisiting the fundamental building blocks of Verilog.

## 1. Learning Objectives

By the end of this revision, you should be able to:

- Understand the structure of a Verilog module.
- Declare input and output ports.
- Distinguish between nets and variables.
- Declare scalar and vector signals.
- Understand basic signal widths and bit selection.

## 2. Module Structure

A module is the basic design unit in Verilog HDL.

```verilog
module and_gate (
    input  wire a,
    input  wire b,
    output wire y
);
    assign y = a & b;
endmodule
```

**Explanation:**
- `module`: Starts the design definition.
- `input`: Declares an input port.
- `output`: Declares an output port.
- `wire`: Declares a net.
- `assign`: Creates a continuous assignment.
- `endmodule`: Ends the module definition.

## 3. Ports

| Port | Purpose |
|---|---|
| `input` | Receives signals |
| `output` | Sends signals |
| `inout` | Supports bidirectional connections |

## 4. Nets vs. Variables

### `wire`
A net represents a connection and is commonly used with continuous assignments.

```verilog
wire a, b, y;
assign y = a & b;
```

### `reg`
In classic Verilog, `reg` is a variable type that can receive assignments inside procedural blocks. It does not necessarily represent a physical register.

```verilog
reg result;

always @(*) begin
    result = a & b;
end
```

The example above describes combinational logic, not a clocked register.

## 5. Scalar and Vector Declarations

```verilog
wire a;          // 1-bit signal
wire [7:0] data; // 8-bit signal
reg  [3:0] count; // 4-bit variable
```

A declaration such as `wire [7:0] data` represents eight bits, indexed from 7 down to 0.

## 6. Key Takeaways

- A module defines a unit of hardware.
- Ports define how a module communicates with its environment.
- Nets and variables have different assignment and modeling roles.
- Vector widths determine the number of bits represented.
- Correct declarations help prevent width mismatches and coding errors.

## 7. Practice Tasks

1. Write a module with two inputs and one output.
2. Declare an 8-bit input bus and a 4-bit output bus.
3. Write a continuous assignment using `wire`.
4. Write an `always @(*)` block using `reg`.
5. Compile the code and inspect any warnings or errors.

## 8. Simulation

Add your testbench and actual simulator output when available. Record the simulator name and the tests you performed.

**Day 01 complete when:** You can explain each declaration, write the examples independently, and verify the behavior of your code.

**Next:** Continue revising Verilog coding techniques and combinational logic.
