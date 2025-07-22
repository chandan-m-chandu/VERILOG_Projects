# Serial-In Parallel-Out (SIPO) Shift Register – Verilog

This repository contains a Verilog implementation and testbench for an 8-bit **Serial-In Parallel-Out (SIPO)** shift register.

##  Files Included

| File          | Description                             |
|---------------|-----------------------------------------|
| `SIPO.v`      | RTL code for the SIPO shift register    |
| `SIPO_tb.v`   | Testbench with sample input patterns    |
| `README.md`   | Project overview and usage              |
| `eloborstion` | RTL elaboration                         |
| `Synthesis`   | Synthesis schematic view                |
| `utilization` | Report on hardware utilization          |

##  Functionality

The SIPO module:

- Receives **1-bit serial input** per clock cycle  
- After 8 clock cycles, outputs the **8-bit parallel word**
- Asserts a `done` flag once all 8 bits are received

##  Port Description

| Port          | Direction | Width   | Description                         |
|---------------|-----------|---------|-------------------------------------|
| `clk`         | Input     | 1-bit   | System clock                        |
| `rst`         | Input     | 1-bit   | Active-high synchronous reset       |
| `ready`       | Input     | 1-bit   | Enables serial data shifting        |
| `serial_in`   | Input     | 1-bit   | Serial data input (1 bit per cycle) |
| `parallel_out`| Output    | 8-bit   | Parallel data output after 8 bits   |
| `done`        | Output    | 1-bit   | High when 8 bits are received       |
