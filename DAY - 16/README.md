Day 16 – Short Notes: Verification Techniques
1. Verification
- Verification is the process of checking whether an RTL design works according to its specification.
- It helps identify functional errors before hardware implementation.
- Design creates hardware; verification checks its correctness.
2. Directed Testing
- Applies predefined input combinations to the DUT.
- Tests specific functionalities manually.
- Example: Testing a 4-bit adder with 0+0, 5+3 and 15+15.
- Easy to implement but may miss unexpected conditions.
3. Self-Checking Testbench
- Automatically compares actual DUT outputs with expected outputs.
- Reports PASS or FAIL.
- Reduces manual waveform checking.
- Uses comparison operators such as == and !==.
4. Reference Model
- An independent model that calculates the expected output.
- Also called a Golden Model.
- Used to compare expected results with actual DUT results.
- Example: Using mathematical addition as a reference for verifying an RTL adder.
5. Corner Cases
- Special or boundary conditions that may cause design failures.
- Important for finding hidden bugs.
Examples:
- Minimum and maximum input values.
- Reset conditions.
- FIFO full and empty conditions.
- Overflow and underflow.
- Simultaneous read and write.
- Invalid FSM states.
6. Scoreboard
- A verification component that compares expected and actual outputs.
- Identifies mismatches between the DUT and reference model.
7. Code Coverage
- Measures how much of the RTL code has been exercised during simulation.
- Includes statement, branch, condition and toggle coverage.
8. Functional Coverage
- Measures whether important functional scenarios have been tested.
- Helps identify missing test cases.
9. Constrained-Random Testing
- Generates random input values within specified constraints.
- Helps explore many input combinations.
- Useful for finding unexpected bugs.
10. Assertions
- Assertions check whether specified conditions or properties hold during simulation.
- Help detect design errors automatically.

Important differences
Technique	Purpose
Directed testing	Tests predefined inputs
Self-checking testbench	Automatically checks outputs
Reference model	Calculates expected outputs
Corner-case testing	Tests boundary conditions
Scoreboard	Compares expected and actual results
Code coverage	Measures RTL code exercised
Functional coverage	Measures scenarios tested
Assertions	Check required design properties
