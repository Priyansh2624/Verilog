# Working of the Synchronous FIFO

The implemented FIFO is a **parameterized synchronous FIFO memory** designed using Verilog HDL. It temporarily stores data while maintaining the order in which it is received, following the **First-In First-Out (FIFO)** principle. Since the design is synchronous, all read and write operations occur only on the **positive edge of the clock**.

The FIFO consists of four major components:

* FIFO Memory Array
* Write Pointer
* Read Pointer
* Full and Empty Detection Logic

These components work together to provide reliable data storage and retrieval while maintaining the correct order of data.

---

## FIFO Memory

The FIFO stores data inside a memory array whose size is determined by two parameters:

* **FIFO Depth** – Number of memory locations available.
* **Data Width** – Number of bits stored in each memory location.

For example, when:

* FIFO Depth = 8
* Data Width = 32

the FIFO memory consists of eight memory locations, each capable of storing one 32-bit word.

```text
Address      Data

0            32 bits
1            32 bits
2            32 bits
3            32 bits
4            32 bits
5            32 bits
6            32 bits
7            32 bits
```

The total storage capacity becomes:

```text
8 × 32 = 256 bits
```

The data stored inside these memory locations is never shifted. Instead, different locations are accessed using read and write pointers.

---

# Write Pointer

The write pointer identifies the location where the next incoming data will be stored.

The pointer width is one bit larger than the address width.

For an 8-entry FIFO:

```text
Address Width = log₂(8) = 3 bits

Write Pointer Width = 4 bits
```

The lower three bits represent the memory address, while the additional most significant bit is used for wrap-around detection during full flag generation.

Initially,

```text
Write Pointer = 0000
```

After every successful write operation, the write pointer increments by one.

Example:

```text
Write Pointer

0000

↓

0001

↓

0010

↓

0011
```

After reaching the final address:

```text
0111
```

the pointer wraps around and becomes

```text
1000
```

The lower address bits return to zero, while the most significant bit changes to indicate that one complete traversal of the FIFO has been completed.

---

# Read Pointer

The read pointer always points to the oldest unread data stored inside the FIFO.

Similar to the write pointer, the read pointer also contains one additional wrap-around bit.

Initially,

```text
Read Pointer = 0000
```

Whenever a valid read operation occurs, the read pointer increments to the next memory location.

Example:

```text
0000

↓

0001

↓

0010

↓

0011
```

Like the write pointer, after reaching the last memory location, it wraps around while toggling its most significant bit.

---

# Write Operation

A write operation is performed only when all the following conditions are satisfied:

* The FIFO is selected (`cs = 1`)
* Write Enable is asserted (`write_en = 1`)
* FIFO is not full (`full = 0`)

When these conditions are satisfied, the incoming data is stored in the memory location indicated by the lower address bits of the write pointer.

For example,

```text
Write Pointer = 0011
```

The lower three bits are

```text
011
```

Therefore, the data is written into

```text
FIFO Memory Address = 3
```

After storing the data, the write pointer increments to point to the next available memory location.

If the FIFO is full, no write operation is performed and the write pointer remains unchanged.

---

# Read Operation

A read operation is performed only when all the following conditions are satisfied:

* The FIFO is selected (`cs = 1`)
* Read Enable is asserted (`read_en = 1`)
* FIFO is not empty (`empty = 0`)

During a successful read operation, the data stored at the address indicated by the read pointer is transferred to the output register (`data_out`).

For example,

```text
Read Pointer = 0010
```

The lower address bits are

```text
010
```

Therefore,

```text
Data is read from FIFO Address 2
```

After the data has been transferred to the output, the read pointer increments to the next location.

If the FIFO is empty, no read operation is performed and the read pointer remains unchanged.

---

# Circular Buffer Operation

The FIFO uses a **circular buffer** architecture.

Instead of stopping after reaching the final memory location, both pointers wrap around to the beginning of the FIFO.

```text
        +----------------------+
        |                      |
        V                      |
0 → 1 → 2 → 3 → 4 → 5 → 6 → 7
^                             |
|_____________________________|
```

This allows memory locations to be reused after their contents have already been read.

Because only the pointers move, the stored data never needs to be physically shifted inside the memory array.

---

# Empty Flag Generation

The FIFO is considered empty whenever the write pointer and read pointer are identical.

```text
Write Pointer = Read Pointer
```

Example:

```text
Write Pointer = 0011

Read Pointer  = 0011
```

Since both pointers are identical, every written data item has already been read.

Therefore,

```text
Empty = 1
```

---

# Full Flag Generation

The FIFO is considered full when:

* The lower address bits of both pointers are identical.
* The most significant bits are different.

Instead of comparing these conditions separately, the design compares the read pointer with a modified version of the write pointer in which only the most significant bit is inverted.

Example:

```text
Write Pointer = 1010

Invert MSB

0010
```

Now compare with

```text
Read Pointer = 0010
```

Since both values are equal after inverting the write pointer's MSB, the FIFO is full.

This indicates that the write pointer has completed one additional wrap around the FIFO compared to the read pointer and every memory location currently contains unread data.

---

# Why an Extra Pointer Bit is Used

If only the address bits were used, both the full and empty conditions would produce identical pointer values after wrapping around.

For example,

Initially,

```text
Write Pointer = 0000

Read Pointer  = 0000
```

The FIFO is empty.

After writing eight entries,

```text
Write Pointer = 1000

Read Pointer  = 0000
```

The address bits are still identical:

```text
000
```

However, the additional most significant bit has changed.

This extra bit allows the FIFO to distinguish between:

* Empty FIFO
* Full FIFO

without requiring any additional counters.

---

# Data Flow Through the FIFO

Suppose three data values are written into the FIFO.

```text
Write A

Write B

Write C
```

Memory becomes

```text
Address      Data

0            A
1            B
2            C
```

The write pointer now points to address **3**, while the read pointer still points to address **0**.

The first read returns

```text
A
```

The second read returns

```text
B
```

The third read returns

```text
C
```

Thus, the FIFO always preserves the order in which the data was written.

---

# Summary

This synchronous FIFO implementation uses a parameterized memory array, independent read and write pointers, and a circular buffer architecture to efficiently store and retrieve data. Read and write operations occur only on the rising edge of the clock when the appropriate control signals are asserted. The use of an additional pointer bit enables accurate detection of full and empty conditions while allowing the FIFO memory to be reused continuously without shifting stored data.
