file=${1}
GHDL_CMD = ghdl
STOP_TIME = 1000ns
# Simulation break condition
#GHDL_SIM_OPT = --assert-level=error
GHDL_FLAGS  = --ieee=synopsys --warn-no-vital-generic
all:
	@$(GHDL_CMD) -a $(GHDL_FLAGS) $(file).vhd
	@$(GHDL_CMD) -a $(GHDL_FLAGS) $(file)_testbench.vhd
	@$(GHDL_CMD) -e $(GHDL_FLAGS) $(file)_testbench
	@$(GHDL_CMD) -r $(GHDL_FLAGS) $(file)_testbench --assert-level=error --stop-time=$(STOP_TIME) --vcd=$(file).vcd
	gtkwave $(file).vcd
run:
	gtkwave $(file).vcd
