[![Librelane Digital Flow (UNIC-CASS)](https://github.com/unic-cass/unic-cass-wrapper/actions/workflows/digital-flow.yaml/badge.svg?branch=dev&event=push)](https://github.com/unic-cass/unic-cass-wrapper/actions/workflows/digital-flow.yaml)

# CLB Module – UNIC-CASS Wrapper (Mock Tapeout)

This repository contains a **Configurable Logic Block (CLB)** integrated into the **UNIC-CASS user project wrapper**, targeting the **IHP SG13G2 130nm open-source PDK**. The CLB is a simple **2-input LUT** supporting four logic modes: AND, OR, XOR, and a default zero output. It is designed to demonstrate a complete **RTL-to-GDSII flow** using open-source ASIC tools.

Functional verification includes **16 test cases** covering all input combinations and modes, with a 100% pass rate. The final outputs include **GDS, LEF, gate-level netlist, timing libraries, and parasitics**.

**Status:** 
- Mock tapeout complete and wrapper-integrated.
- Working on Input/Output Direction Configuration for CLB.
- Working on FPGA Programming/Interaction State Machine.

