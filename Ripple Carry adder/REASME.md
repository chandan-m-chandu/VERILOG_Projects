# Ripple Carry Adder -in Verilog

## Overview
This folder contains a 4-bit Ripple Carry Adder (RCA) design, designed using Verilog and testbench in SystemVerilog. 

## Features
- 4-bit Ripple Carry Adder implementation.
- Supports carry-in and produces carry-out.
- Testbench written in SystemVerilog for simulation.
- Simulated on Zedboard (xa7z020clg484-1)
![image](https://github.com/user-attachments/assets/3c742b5a-9be0-49f0-94d1-6484b61e838d)


## Description
The Ripple Carry Adder is a simple digital circuit used for binary addition. It adds two 4-bit binary numbers and outputs a 4-bit sum along with 1-bit carry-out. This works by cascading full adders which are instansiated, each full adder in the chain is responsible for adding a pair of bits and the carry-in from the previous stage. The RCA is called "ripple" because the carry-out from each stage is passed to the next stage as carry-in.

### RCA Module:
- **Inputs**: 
  - `A[3:0]`: 4-bit input operand A.
  - `B[3:0]`: 4-bit input operand B.
  - `Cin`: Carry-in bit.
- **Outputs**:
  - `Sum[3:0]`: 4-bit sum result.
  - `Cout`: Carry-out bit.

### Testbench:
A testbench is included to simulate and verify the Ripple Carry Adder. The testbench applies various input combinations and monitors the outputs.

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/ripple-carry-adder.git
