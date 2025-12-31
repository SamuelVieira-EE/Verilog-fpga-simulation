## Verilog-fpga-simulation
# 3-Bit 2's Complement Calculator

A Verilog calculator for adding and subtracting 3-bit 2's complement numbers. Only the simulation was done no FPGA board was included.

# What it can do 
- Addition and subtraction
- 3-bit two's complement input (-4 to +3)
- Overflow detection
- 7-segment display output (8 displays)
- Display multiplexing

# How to Use / Getting started
- Input values using switches 
- Choose the operation add or subtract
- Press calc_button to calculate 
- View result on displays 
- LED would be on or off depending on overflow

# Simulation 
Run the testbench in Vivado:

Test Case Shown:
- Input A: 3  or 011 in binary
- Input B: 2 or 010 in binary
- Operation: Addition, subtraction = 0
- Result: displays 5 or binary 101 but displays as -3 due to overflow
- Overflow: 1, detected correctly

# Simulation Results
<img width="1538" height="412" alt="image" src="https://github.com/user-attachments/assets/f24e9406-dbc4-423d-9ae1-d3c9fbd8bcd2" />
