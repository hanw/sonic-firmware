NAME=sonic_downstream_gearbox
LEVEL=..
SRC_DIR = ../../../lib/shared/eth/

# override ALL target
OVERRIDE=yes
all:
	echo "compile verilog to c++"
	verilator --trace -Wall --cc $(SRC_DIR)/$(NAME) --Wno-lint --exe sim_main.cpp

include $(LEVEL)/Makefile.common
