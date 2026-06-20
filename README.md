# RISC‑V 5‑Stage Pipelined CPU — From Scratch

This repository contains an end‑to‑end implementation of a **5‑stage pipelined RISC‑V RV32I CPU**, designed and verified over an 8‑week structured learning roadmap.

"I Build My Own CPU"

The CPU supports:

- Instruction Fetch, Decode, Execute, Memory, Write‑Back
- Hazard detection and data forwarding
- Branch handling and basic pipeline control
- Performance measurement (cycle and instruction counters)
- Execution of small RISC‑V programs in simulation

---

## 🧩 Overview

This repository presents a complete **RISC‑V RV32I pipelined processor**, designed and verified in Verilog HDL.  
The CPU implements the **classic 5‑stage pipeline architecture** with hazard detection, forwarding, branch handling, and performance measurement.

The design was developed through an 8‑week structured progression, evolving from basic instruction fetch to full program execution.

---

## 🧠 Architectural Summary

| Stage | Function | Key Modules |
|--------|-----------|-------------|
| **IF** | Instruction Fetch | `pc.v`, `instr_mem.v`, `if_id.v` |
| **ID** | Decode & Register Read | `decoder.v`, `regfile.v`, `imm_gen.v`, `alu_control.v` |
| **EX** | Execute & Branch Decision | `alu.v`, `branch_comp.v`, `id_ex.v` |
| **MEM** | Memory Access | `data_mem.v`, `ex_mem.v` |
| **WB** | Write‑Back | `writeback_mux.v`, `mem_wb.v` |

Each stage is separated by pipeline registers to maintain data flow and timing integrity.

---

## 🧮 Microarchitectural Design

### 1. **Pipeline Registers**
All inter‑stage data paths are latched using the generic `pipe_reg` module:
```verilog
pipe_reg #(WIDTH) REG(clk, reset, data_in, data_out);

---

## 🧠 Architecture Overview

The CPU implements the classic 5‑stage pipeline:

1. **IF — Instruction Fetch**  
   Program counter (PC) and instruction memory.

2. **ID — Instruction Decode & Register Read**  
   Decoder, register file, immediate generator.

3. **EX — Execute**  
   ALU, ALU control, branch comparison.

4. **MEM — Memory Access**  
   Data memory for loads and stores.

5. **WB — Write‑Back**  
   Selects between ALU result and memory data and writes to the register file.

Pipeline registers separate each stage: `IF/ID`, `ID/EX`, `EX/MEM`, `MEM/WB`.

---

## 📁 Repository Structure

```text
riscv_cpu_sai/
│
├── week1/          # PC, instruction memory, basic fetch
├── week2/          # Decoder, register file, immediate generator
├── week3/          # ALU, ALU control, execution stage
├── week4/          # Data memory, write-back logic
├── week5/          # Pipeline registers (IF/ID, ID/EX, EX/MEM, MEM/WB)
├── week6/          # Hazard detection, forwarding, branch flush
├── week7/          # Performance counters, CPI measurement
├── week8/          # Full program execution, integration testbench
│
├── top_week7.v     # Week 7 top-level (performance-focused)
├── top_week8.v     # Week 8 top-level (full program integration)
├── tb_top_week7.v  # Week 7 testbench
├── tb_top_week8.v  # Week 8 testbench
│
└── README.md       # Project documentation
