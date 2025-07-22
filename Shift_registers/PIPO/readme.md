# Parallel-In Parallel-Out (PIPO) Shift Register – Verilog

This repository contains a Verilog implementation and testbench for a **Parallel-In Parallel-Out (PIPO)** shift register that accumulates **4-bit parallel inputs** over 16 clock cycles to produce a **64-bit parallel output**.

##  Files Included

| File          | Description                             |
|---------------|-----------------------------------------|
| `PIPO.v`      | RTL code for the PIPO shift register    |
| `PIPO_tb.v`   | Testbench with sample input sequences   |
| `README.md`   | Project overview and usage              |
| `RTL`         | RTL elaboration                         |
| `Synthesis`   | Synthesis schematic view                |
| `utilization` | Report on hardware utilization          |

##  Functionality

The PIPO module:

- Accepts **4-bit parallel input** on each clock cycle
- Collects 16 such inputs to build a **64-bit wide output**
- Asserts a `done` flag once all data is accumulated

##  Port Description

| Port         | Direction | Width   | Description                             |
|--------------|-----------|---------|-----------------------------------------|
| `clk`        | Input     | 1-bit   | System clock                            |
| `rst`        | Input     | 1-bit   | Active-high synchronous reset           |
| `ready`      | Input     | 1-bit   | Enables capturing of 4-bit inputs       |
| `parallel_in`| Input     | 4-bit   | 4-bit parallel input data               |
| `parallel_out`| Output   | 64-bit  | Full 64-bit parallel output             |
| `done`       | Output    | 1-bit   | High when all 64 bits are accumulated   |
