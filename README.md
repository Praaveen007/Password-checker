# Password Checker

# 📌 Project Configuration
This repository contains a digital password checker implemented as a Finite State Machine (FSM) for authenticating a fixed 4-bit password. The design uses sequential logic suitable for implementation in hardware description languages such as Verilog or VHDL.

The FSM waits for a 4-bit input supplied all at once, then verifies whether the entered sequence matches the predefined password. On successful authentication, the system outputs a signal indicating access granted.

---

## ⚙️ Attribute

- **FSM Stages:**  
  `IDLE` → `CHECK_PASSWORD` → `ACCESS_GRANTED` / `ACCESS_DENIED`  
  (The FSM waits for input, checks the entire 4-bit password simultaneously, then signals the result.)

- **Operation:**  
  - Waits in `IDLE` state until `start` signal is asserted  
  - On `start`, FSM moves to `CHECK_PASSWORD` state and compares input with stored password  
  - Depending on the comparison, signals `access_granted` or `access_denied`  
  - Returns to `IDLE` waiting for the next input  

- **Preset Password:**  
  Fixed 4-bit password defined in the code (default example: `4'b1010`), easily customizable.
  
  ---
# 🛠️ Specifications
- **Software**: Vivado ML Edition (Standard) 2024.2
- **Hardware**: ZedBoard Zynq-7000 ARM / FPGA SoC Development Board
 ---
# 🔌Inputs
| Name   | Description        |
|--------|--------------------|
| clk    | Clock              |
| reset  | Reset              |
| S0-S3  | Password input bits|

---

# 💡Outputs
| Name           | Description                  |
|----------------|------------------------------|
| access_granted | High if password is correct  |
| error          | High if password is wrong    |
| time_out         | High after 3 wrong attempts  |

---

# 📊 FSM State Log (Based on Simulation)

| Input Password | Event Description              | FSM State  | access_granted | error | locked (timeout) |
|----------------|--------------------------------|------------|----------------|-------|------------------|
| `1011`         | ✅ Correct password             | `GRANTED`  | 1              | 0     | 0                |
| `1001`         | ❌ Wrong password #1            | `DENIED`   | 0              | 1     | 0                |
| `0000`         | ❌ Wrong password #2            | `DENIED`   | 0              | 1     | 0                |
| `0101`         | ❌ Wrong password #3 → Locked   | `LOCKED`   | 0              | 1     | 1 ✅              |
| `1011`         | 🔒 Input blocked while locked   | `LOCKED`   | 0              | 0     | 1                |
| `1011`         | 🔁 Reset followed by correct pw | `GRANTED`  | 1              | 0     | 0                |

---


# 🔄 FSM Transitions

| Current State | Input Condition            | Next State | Description                          |
|---------------|----------------------------|------------|--------------------------------------|
| `IDLE`        | Password entered           | `CHECK`    | Start checking on clock edge         |
| `CHECK`       | Input == `1011`            | `GRANTED`  | Password matched                     |
| `CHECK`       | Input ≠ `1011`             | `DENIED`   | Password incorrect                   |
| `DENIED`      | Error count ≥ 3            | `LOCKED`   | Lock system after 3 failed attempts  |
| `GRANTED`     | System not locked          | `IDLE`     | Return to idle after access granted  |
| `DENIED`      | System not locked          | `IDLE`     | Return to idle for retry             |
| `LOCKED`      | Reset = 1                  | `IDLE`     | Unlock only on reset                 |

---

# 🖼️State Diagram
![WhatsApp Image 2025-08-09 at 12 20 31_bb7b88da](https://github.com/user-attachments/assets/3fdc577a-a1cc-4587-853d-a5cff22f6fab)

---

# 🗂️ – File collection

[🧾PROBLEM STATEMENT](https://github.com/INDRA2006MG/Password-Checker-4-BIT---FSM/blob/main/Problem%20statement)

[🧾 TEST BENCH ](https://github.com/INDRA2006MG/Password-Checker-4-BIT---FSM/blob/main/Password%20Checker.tb.v)

[🧾 DESIGN ](https://github.com/INDRA2006MG/Password-Checker-4-BIT---FSM/blob/main/Password%20Checker.v)

[🧾 TOP MODULE](https://github.com/INDRA2006MG/Password-Checker-4-BIT---FSM/blob/main/Top%20Module)

[🧾 CLOCK MODULE](https://github.com/INDRA2006MG/Password-Checker-4-BIT---FSM/blob/main/Clock%20Module)

---

# 🧩 SCHEMATIC BLOCK
<img width="1564" height="793" alt="image" src="https://github.com/user-attachments/assets/1a7e91e2-9c59-45fa-b33f-44bfadd31e92" />

<img width="1162" height="402" alt="image" src="https://github.com/user-attachments/assets/225d2803-388d-41ac-8b8c-8b56e670e2ed" />



---

# 🎛️ SIMULATION WAVEFORM
![WhatsApp Image 2025-08-08 at 15 44 51_53df435e](https://github.com/user-attachments/assets/5afcb352-52df-404c-94e4-757ad3e7055f)

---

# 🔧 IMPLEMENTATION DESIGN
<img width="1172" height="533" alt="image" src="https://github.com/user-attachments/assets/078adbc5-4e9f-4fc3-a580-6066c10435e4" />


---

#  🎯 SIMULATION OUTPUT
<img width="1333" height="750" alt="image" src="https://github.com/user-attachments/assets/1172123b-1335-4691-8272-5aaa198099b2" />

---


---

# 🧪 Simulation Demo

## 🎥 Demo Video
[Watch the Simulation Video](https://drive.google.com/file/d/10txqIYbCHSzcoH6OyQAw9UrUZ_sKm43Y/view?usp=sharing) <!-- Replace # with the actual YouTube or drive link -->


---

## 🔍 Reports

### ⛓️ Resource Utilization (Post-Synthesis)


<img width="549" height="297" alt="image" src="https://github.com/user-attachments/assets/7098dea6-a745-4b21-9b91-61afe139dcd4" />


---

### ⏱️ Timing Summary


<img width="1052" height="267" alt="image" src="https://github.com/user-attachments/assets/8a51b58f-6620-4445-a83a-13c192ac8439" />


---

### ⚡ Power Summary


<img width="603" height="286" alt="image" src="https://github.com/user-attachments/assets/9cc3dd37-09e7-4db3-a91d-e4bcf4502277" />

## 🔌 Pin Assignment

> 📍 Based on the FPGA constraints shown in Vivado.

| Signal         | Direction | Pin  | Description              |
|----------------|-----------|------|--------------------------|
| password[0]    | Input     | F21  | Password bit 0 (LSB)     |
| password[1]    | Input     | H22  | Password bit 1           |
| password[2]    | Input     | G22  | Password bit 2           |
| password[3]    | Input     | F22  | Password bit 3 (MSB)     |
| clk            | Input     | Y9   | Clock signal             |
| reset          | Input     | H19  | Active-high reset        |
| enter          | Input     | M15  | Enter to check password  |
| access_granted | Output    | U14  | High when password matches |
| error          | Output    | U19  | High when incorrect password |

<img width="1593" height="442" alt="image" src="https://github.com/user-attachments/assets/151cf3ec-cdb6-4a3f-89d8-9cf6793b3d02" />


> ⚠️ All pins are configured as `LVCMOS18`, with Drive Strength = 12, Slew Rate = SLOW (for outputs).

---

##  🗂️ Source File
<img width="419" height="455" alt="image" src="https://github.com/user-attachments/assets/d6491ed3-6678-42f3-bb1a-d95732cea2cf" />

---

##  📰 Summary
<img width="804" height="444" alt="image" src="https://github.com/user-attachments/assets/a5d4619c-90ac-4ad1-a84d-2fa2511bec3d" />

---
