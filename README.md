# vhdl_open_cores

VHDL Open Cores that may be synthesized and/or implemented on (Xilinx, Altera, etc.) FPGAs.

![alt text](https://raw.githubusercontent.com/enthusiasticgeek/vhdl_open_cores/main/vhdl_open_cores.png "vhdl_open_cores")

**OS Supported**

Ubuntu 18.04/20.04 LTS

**Tools Required**

sudo apt update
sudo apt install ghdl gtkwave

**Example Usage**

cd src/<folder of interest>

#### Adjust the STOP_TIME parameter in the Makefile to the desired value.

#### To compile the .vhd file with default Makefile

make file=<name of the file without .vhd extension>

#### To view the waveform

make run file=<name of the file without .vhd extension>

#### How do I create a new vhdl file and it's test bench?

e.g. To create a new counter the file must be named **counter.vhd** (entity name in this file must be **counter**) and the corresponding testbench **counter_testbench.vhd** (entity name in this file must be **counter_testbench**).
  
**GtkWave Tips**

1. Select all the input/output signals for Design Under Test (DUT) - SHIFT to select all the signals (left pane) and drag to waveform to display.

2. ALT+SHIFT+F key to fit the graph.

![alt text](https://raw.githubusercontent.com/enthusiasticgeek/vhdl_open_cores/main/gtkwave_counter_example.png "gtkwave_counter_example")
