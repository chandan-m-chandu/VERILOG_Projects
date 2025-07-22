# Parallel-In Serial-Out (PISO) Shift Register – Verilog

This repository contains a Verilog implementation and testbench for an 8-bit **Parallel-In Serial-Out (PISO)** shift register.

##  Files Included

| File         | Description                            |
|--------------|----------------------------------------|
| `PISO.v`     | RTL code for the PISO shift register   |
| `PISO_tb.v`  | Testbench with multiple test vectors   |
| `README.md`  | Project overview and usage             |
| `RTL      `  | RTL eloboration                        |
| `Synthesis`  | Synthesis schematic view               |
| `utilization`| Reoprt Hardware utilaization           |


##  Functionality

The PISO module:

- Accepts an **8-bit parallel input**
- On a `ready` signal, loads the input into an internal shift register
- Serially outputs **MSB-first** bits on each clock cycle
- Asserts a `done` flag after all 8 bits are shifted out

##  Port Description

| Port         | Direction | Width   | Description                        |
|--------------|-----------|---------|------------------------------------|
| `clk`        | Input     | 1-bit   | System clock                       |
| `rst`        | Input     | 1-bit   | Active-high synchronous reset      |
| `ready`      | Input     | 1-bit   | Triggers parallel data loading     |
| `parallel_in`| Input     | 8-bit   | Parallel data to be serialized     |
| `serial_out` | Output    | 1-bit   | Serial output bit                  |
| `done`       | Output    | 1-bit   | High when 8 bits are shifted out   |

