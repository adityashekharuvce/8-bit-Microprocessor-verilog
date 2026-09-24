# 8-bit Microprocessor — Verilog RTL Design

## Overview 

An 8-bit microprocessor designed and implemented using Verilog HDL
at the Register Transfer Level (RTL).

## Architecture

## Architecture

The 8-bit microprocessor consists of the following major blocks:

```text
              ┌─────────────────┐
              │ Program Counter │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Instruction     │
              │ Memory / Fetch  │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Control Unit /  │
              │ Instruction     │
              │ Decoder         │
              └────────┬────────┘
                       │
             ┌─────────┴─────────┐
             ▼                   ▼
      ┌─────────────┐     ┌─────────────┐
      │ Register    │────►│     ALU     │
      │ File        │     └──────┬──────┘
      └─────────────┘            │
                                 ▼
                          ┌─────────────┐
                          │   Result    │
                          └─────────────┘
```

### Main Components

* **Program Counter (PC):** Holds the address of the current instruction.
* **Instruction Decoder:** Decodes the fetched instruction.
* **Control Unit:** Generates control signals for datapath operation.
* **Register File:** Stores processor registers.
* **ALU:** Performs arithmetic and logical operations.
* **Top Module:** Integrates the complete processor.
* **Testbench:** Verifies processor operation through simulation.

## Design

The processor follows a custom instruction set architecture (ISA).
Instructions are fetched, decoded, executed, and the results are
written back to the appropriate registers.

## Modules
| Module           | Description                       |
| ---------------- | --------------------------------- |
| `top.v`          | Top-level CPU                     |
| `alu.v`          | Arithmetic and logical operations |
| `regfile.v`      | Register storage                  |
| `control_unit.v` | Generates control signals         |
| `pc.v`           | Stores instruction address        |
| `tb.v`           | Testbench for verification        |


## Verification

The processor was simulated using a Verilog testbench to verify
instruction execution and datapath operation.

## Tools

- Verilog HDL
- RTL Design
- Digital Logic
- HDL Simulator

## Future Improvements

- FPGA implementation
- Pipelining
- UART interface
- Expanded instruction set
