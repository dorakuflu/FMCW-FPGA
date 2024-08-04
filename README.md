This is a FMCW Radar application built using Verilog and SystemVerilog on Xilinx Vivado for FPGA devices.

Current Development Phase:
* QSPI, Hamming window, and FPGA modules are functionaly and integrated together.
* CFAR module is under development, currently not working.

Resources:
There are two MATLAB modules used for development.
* computed_values.m is used to verify correct operation of the radar.
* coe.m is used to generate .coe (coefficient) files used in block RAM initialization, altough this script is currently not being used.
