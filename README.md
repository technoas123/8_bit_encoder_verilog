# DVB-RCS2 Turbo Encoder Implementation

A high-performance, FPGA-targeted Verilog implementation of a **DVB-RCS2 compliant constituent Recursive Systematic Convolutional (RSC) encoder**. This project includes complete hardware design sources, a verification testbench environment, and Xilinx Vivado tracking architectures.

The core implementation features a systematic feedback encoder layout operating with a 3-bit internal state machine layout (`s0`, `s1`, `s2`) optimized for satellite communication standards.

---

## 🚀 Structural Architecture & Logic Design

The internal hardware maps the mathematical feedback paths and systematic constraints of the system using concurrent and synchronous logic lines.

### Logic Equations
* **Feedback Path (\(f\)):**  
  \[f = a_{in} \oplus s_2\]
* **Systematic Outputs:**  
  \[y_{out} = a_{in} \oplus s_1 \oplus s_2\]  
  \[w_{out} = b_{in} \oplus s_0 \oplus s_2\]
* **State Updates (Synchronous on `posedge clk`):**  
  \[s_0 \leftarrow b_{in} \oplus f\]  
  \[s_1 \leftarrow s_0\]  
  \[s_2 \leftarrow s_1\]

### Hardware Pin Interface

| Signal Name | I/O Direction | Type | Description |
| :--- | :--- | :--- | :--- |
| `clk` | Input | `wire` | Master System Clock |
| `rst` | Input | `wire` | Active-High Synchronous Reset |
| `ce` | Input | `wire` | Clock Enable (Active-High processing controller) |
| `a_in` | Input | `wire` | Systematic Input bit stream A |
| `b_in` | Input | `wire` | Systematic Input bit stream B |
| `y_out` | Output | `reg` | Encoded parity output bit stream Y |
| `w_out` | Output | `reg` | Encoded parity output bit stream W |

---

## 📂 Project Directory Structure

To maintain a clean version control ecosystem, temporary files (`.cache`, `.sim`, `.hw`, `.ip_user_files`) are systematically untracked via `.gitignore`. The required workspace structure consists of:

```text
DVB_RCS2/
├── .gitignore                             # Untracks localized Vivado temp/log files
├── README.md                              # Full architectural documentation
├── constituent_encoder_8bit_schematic.pdf  # Schematic and hardware design layouts
├── dvb_rcs2_turbo_encoder.xpr             # Xilinx Vivado main project file
└── dvb_rcs2_turbo_encoder.srcs/
    ├── sources_1/
    │   └── new/
    │       └── constituent_encoder.v      # Core structural design file
    └── sim_1/
        └── new/
            └── tb_constituent_encoder.v   # Behavioral testbench simulation file
```

---

## 🛠️ Verification & Simulation Environment

Hardware verification is evaluated using the behavioral pipeline in the Xilinx Vivado Simulator. The test sequence in `tb_constituent_encoder.v` evaluates critical control thresholds, reset stabilization, and dynamic bit pair encodings.

### Verification Sequence Steps
1. **System Initialization:** All input stimuli (`clk`, `rst`, `ce`, `a_in`, `b_in`) clear to `0` at time \(t = 0\text{ ns}\).
2. **Hardware Power-On Reset:** The reset line (`rst`) asserts high for a duration of \(20\text{ ns}\) to guarantee complete state clearing of internal registers (`s0`, `s1`, `s2`) and parity outputs.
3. **Module Activation:** The module transitions out of reset, and Clock Enable (`ce`) asserts high to accept system data.
4. **Test Couple Stimulus:** 4 consecutive data couple variations are driven into the encoder every clock cycle (\(10\text{ ns}\)):
   * `a_in = 1; b_in = 0;`
   * `a_in = 0; b_in = 1;`
   * `a_in = 1; b_in = 1;`
   * `a_in = 0; b_in = 0;`
5. **Idle and Clear:** Module drops `ce` and zeros incoming data nodes for \(30\text{ ns}\) before a deliberate `$finish` system task gracefully ends the simulation runner.

---

## 🛠️ Running the Simulation via Terminal

If running execution runs outside the Vivado graphical user interface, you can initialize simulation tests directly using your Linux terminal:

```bash
# Parse and compile the design and testbench modules
xvlog constituent_encoder.v
xvlog tb_constituent_encoder.v

# Elaborate the compiled design structural boundaries
xelab -top tb_constituent_encoder -snapshot snapshot_tb_encoder

# Execute behavioral simulation run inside your terminal engine
xsim snapshot_tb_encoder -runall
```

