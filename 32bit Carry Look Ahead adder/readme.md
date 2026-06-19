# 32-bit Carry Look-Ahead Adder (CLA)

## Overview
This project implements a 32-bit Carry Look-Ahead Adder (CLA) in Verilog and performs a complete RTL-to-GDSII ASIC implementation using the Sky130 PDK and OpenLane 2 flow.

The design is constructed hierarchically using 4-bit CLA blocks and synthesized, placed, routed, and verified through the OpenLane physical design flow.

---

## Features

- 32-bit addition
- Carry Look-Ahead architecture
- Faster carry computation than Ripple Carry Adder
- Verilog RTL implementation
- Functional verification through testbench simulation
- Complete ASIC implementation using OpenLane
- GDSII layout generation and visualization in KLayout

---

## Tools Used

| Tool | Purpose |
|--------|---------|
| Verilog | RTL Design |
| Icarus Verilog / GTKWave | Functional Verification |
| OpenLane 2 | ASIC Flow |
| OpenROAD | Physical Design |
| Magic | DRC & Layout Generation |
| Netgen | LVS Verification |
| KLayout | GDS Visualization |
| Sky130 HD | Standard Cell Library |

---

## ASIC Flow

1. RTL Design
2. Functional Simulation
3. Logic Synthesis
4. Floorplanning
5. Placement
6. Clock Tree Synthesis
7. Routing
8. DRC Verification
9. LVS Verification
10. GDSII Generation

---

## Physical Design Results

| Metric | Value |
|----------|----------|
| Standard Cell Count | 325 |
| IO Count | 100 |
| Die Area | 4893.70 µm² |
| Core Area | 2757.64 µm² |
| Standard Cell Area | 1983.15 µm² |
| Utilization | 71.91% |
| Total Nets | 348 |
| Total Wire Length | 5926 µm |
| Total Vias | 1620 |
| Routing DRC Errors | 0 |
| Flow Errors | 0 |

---

## Verification Results

### DRC

- Routing DRC Errors: 0
- Design successfully routed without violations.

### LVS

- Layout Versus Schematic (LVS) Passed
- Device counts matched
- Net counts matched
- Pin connectivity matched

### Timing

- No unannotated timing nets reported.
- STA completed successfully.

---

## Author

Priyansh Sarkar

B.Tech Electronics (VLSI Design and Technology)

### Layout Files

