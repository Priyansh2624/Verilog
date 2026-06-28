# Synchronous FIFO Memory using Verilog

## Overview

This project implements a parameterized **Synchronous FIFO (First-In First-Out) Memory** in Verilog. The FIFO is designed using a circular buffer architecture and supports configurable data width and FIFO depth.

The FIFO uses:

- Separate read and write pointers
- Full and Empty flag generation
- Active-low synchronous reset
- Chip Select (CS)
- Read and Write enable signals

Since the FIFO is synchronous, both read and write operations occur only on the rising edge of the clock.

---

# FIFO Architecture

```
                 +--------------------------+
                 |      FIFO MEMORY         |
                 |                          |
 data_in ------->|                          |-------> data_out
                 |                          |
                 +--------------------------+
                       ^             ^
                       |             |
                 Write Pointer   Read Pointer
                       |             |
                    Write Logic   Read Logic

                +-----------------------+
                |  Full/Empty Logic     |
                +-----------------------+
```

---

# Features

- Parameterized FIFO Depth
- Parameterized Data Width
- Circular Buffer implementation
- Synchronous Read
- Synchronous Write
- Full flag generation
- Empty flag generation
- Active-low Reset
- Chip Select support

---

# FIFO Principle

FIFO follows the **First-In First-Out** principle.

Example:

```
Write:

10
20
30

FIFO

Front

10 -> 20 -> 30

Read Order

10
20
30
```

---

# Module Declaration

```verilog
module sync_fifo(
input clk,
input cs,
input rst_n,
input [data_width-1:0] data_in,
input write_en,
input read_en,
output reg [data_width-1:0] data_out,
output empty,
output full
);
```

---

# Parameters

```verilog
parameter fifo_depth = 8;
parameter data_width = 32;
```

These parameters allow the FIFO to be resized without changing the RTL.

Example:

```
FIFO Depth = 8

Number of memory locations = 8
```

```
Data Width = 32

Each memory location stores 32 bits.
```

---

# Address Width Calculation

```verilog
localparam fifo_depth_log = $clog2(fifo_depth);
```

The address width is calculated automatically.

Example

| FIFO Depth | Address Width |
|------------|---------------|
| 4 | 2 bits |
| 8 | 3 bits |
| 16 | 4 bits |
| 32 | 5 bits |

---

# FIFO Memory

```verilog
reg [data_width-1:0] fifo [0:fifo_depth-1];
```

Example

```
reg [31:0] fifo [0:7];
```

creates

```
Address        Data

0             32 bits
1             32 bits
2             32 bits
3             32 bits
4             32 bits
5             32 bits
6             32 bits
7             32 bits
```

Total Memory

```
8 × 32 = 256 bits
```

---

# Read and Write Pointers

```verilog
reg [fifo_depth_log:0] w_pointer;
reg [fifo_depth_log:0] r_pointer;
```

Notice that the pointer width is

```
Address Width + 1
```

The additional MSB is used for Full detection.

For FIFO depth = 8

```
Pointer

MSB   Address

0     000
0     001
0     010
...
0     111

Pointer wraps

1     000
1     001
```

The MSB indicates whether the pointer has wrapped around the circular buffer.

---

# Write Operation

```verilog
always @(posedge clk) begin
    if(!rst_n)
        w_pointer <= 0;

    else if(cs && write_en && !full) begin

        fifo[w_pointer[fifo_depth_log-1:0]] <= data_in;

        w_pointer <= w_pointer + 1'b1;

    end
end
```

### Operation

The write occurs only when

- FIFO selected
- Write enabled
- FIFO not full

The lower address bits of the pointer select the memory location.

Example

```
Write Pointer =

0011

Address Bits

011

Write

fifo[3] = data_in
```

---

# Read Operation

```verilog
always @(posedge clk) begin

    if(!rst_n)

        r_pointer <= 0;

    else if(cs && read_en && !empty) begin

        data_out <= fifo[r_pointer[fifo_depth_log-1:0]];

        r_pointer <= r_pointer + 1'b1;

    end

end
```

Read occurs only when

- FIFO selected
- Read enabled
- FIFO not empty

---

# Empty Flag

```verilog
assign empty = (w_pointer == r_pointer);
```

The FIFO is empty whenever both pointers are identical.

Example

```
Write Pointer

0010

Read Pointer

0010

Empty = 1
```

---

# Full Flag

```verilog
assign full =
(r_pointer ==
{
~w_pointer[fifo_depth_log],
w_pointer[fifo_depth_log-1:0]
});
```

This compares

```
Read Pointer

with

Write Pointer

having the MSB inverted.
```

Example

```
Write Pointer

1010

Invert MSB

0010

Compare

Read Pointer = 0010

Match

FIFO Full
```

---

# Why Invert the MSB?

Suppose

```
FIFO Depth = 8
```

Pointers

```
MSB Address

0   000
...
0   111

Wrap

1   000
```

When the write pointer wraps around and catches the read pointer,

the address becomes identical,

but the MSB changes.

Therefore,

```
Addresses Equal

AND

MSBs Different

=

FIFO Full
```

---

# Circular Buffer

```
        +----------------+
        |                |
        V                |
0 ->1 ->2 ->3 ->4 ->5 ->6 ->7
^                           |
|___________________________|
```

Instead of shifting data,

only the pointers move.

This makes FIFO implementation efficient.

---

# Timing

Write

```
Clock ↑

Write Enable = 1

↓

Store data

↓

Increment Write Pointer
```

Read

```
Clock ↑

Read Enable = 1

↓

Read data

↓

Increment Read Pointer
```

---

# Advantages

- Simple hardware implementation
- No data shifting required
- Fast read/write operation
- Low hardware complexity
- Easy FPGA/ASIC implementation
- Parameterized design
- Efficient circular memory

---

# Applications

- UART Buffers
- SPI Controllers
- I2C Controllers
- DMA Buffers
- Network Routers
- Processor Pipelines
- Clock Domain Crossing (Asynchronous FIFO)
- Audio Streaming
- Video Processing
- FPGA Designs
- ASIC Designs

---

# Future Improvements

- Asynchronous FIFO
- Almost Full flag
- Almost Empty flag
- Occupancy Counter
- Programmable Threshold
- Error Detection
- Overflow Detection
- Underflow Detection
- First Word Fall Through (FWFT)
- AXI Stream FIFO Interface
- Dual Clock FIFO
- ECC Protected FIFO

---

# Tools

- Verilog HDL
- Xilinx Vivado / ModelSim / Icarus Verilog
- GTKWave
- Cadence Xcelium
- Cadence Genus
- OpenLane (ASIC Flow)

---

# Author

**Priyansh Sarkar**

B.Tech – Electronics (VLSI Design and Technology)

Focused on Digital Design, RTL Design, ASIC Design Flow, FPGA Design and Computer Architecture.
