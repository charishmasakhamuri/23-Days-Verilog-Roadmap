Day 13 – Tasks and Functions (Short Notes)
1. What are Tasks and Functions?
Tasks and functions are reusable procedural blocks in Verilog used to avoid repeated code and improve readability.

Function: Used to calculate and return a value.

Task: Used to perform a sequence of operations.

2. Function
Characteristics:

Returns one value through its function name.

Executes in zero simulation time.

Cannot contain timing controls (#, @, wait) in traditional Verilog.

Uses input arguments.

Useful for arithmetic and combinational calculations.

Syntax:

function [7:0] add;
    input [7:0] a, b;
    begin
        add = a + b;
    end
endfunction

Calling:

result = add(10, 20);

3. Task
Characteristics:

Can perform multiple operations.

Supports input, output and inout arguments.

Can contain delays and event controls.

Does not return a value through a function-style return variable.

Commonly used in testbenches.

Syntax:

task addition;
    input [7:0] a, b;
    output [8:0] result;

    begin
        result = a + b;
    end
endtask

Calling:

addition(10, 20, result);

5. Task Arguments
Three types of arguments:

input – Passes data into a task.

output – Passes results out.

inout – Allows data to enter and be updated.

6. Timing Control in Tasks
Tasks can contain:

#10;
@(posedge clk);
wait(valid);

These are useful for:

Memory read/write operations.

Clock synchronization.

UART/SPI verification.

Testbench stimulus generation.

7. Scope
Scope specifies where tasks, functions and variables can be accessed.

They can be declared inside:

Modules

Interfaces

Programs

Packages (SystemVerilog)

Classes (SystemVerilog)

A task can call another task or function.

A traditional Verilog function cannot call a timing-consuming task.

8. Static vs Automatic
Static

Automatic

Default in traditional Verilog

Declared using automatic

Shared local storage

Separate local storage per invocation

Not naturally reentrant

Supports reentrant calls

Recursion unsuitable

Supports recursion

Example:

task automatic calculate;
    input integer a;
    integer temp;
    begin
        temp = a * 2;
    end
endtask

9. SystemVerilog Enhancements
Typed function return values.

automatic functions and tasks.

void functions (no return value).

Argument declarations directly in the task/function header.

Example:

function automatic logic [7:0] add(
    input logic [7:0] a,
    input logic [7:0] b
);
    return a + b;
endfunction

Important: Tasks and functions do not automatically create separate hardware blocks. Synthesis generally incorporates their logic into the surrounding design.
