NAME=sonic_rx_ctl_66
LEVEL=../..
SRC_DIR = ../../../../lib/shared/circbuf/
LIB_DIR = ../../../../lib/sonic/ram/
SIM_DIR = ../../../../lib/sonic/ram/sim/
CONST_DIR = ../../../../lib/shared/
PYTHONPATH = /home/hwang/sonic/projects/sonic_fpga_bugfix/pcie-refactor-debug-port1/dma_rxtx_p1/testsuite/verilator_sim/scripts/

# override ALL target
OVERRIDE=yes
all:
	echo "compile verilog to c++"
	verilator --trace --trace-depth 9 -Wall --cc $(SRC_DIR)/$(NAME) -I$(SRC_DIR) -I$(LIB_DIR) -I$(SIM_DIR) -I$(CONST_DIR) -I$(CONST_DIR)/eth/ --Wno-lint --exe sim_main.cpp; \
 	cd obj_dir; \
	make -j -f V$(NAME).mk V$(NAME) ;
wave:
	./obj_dir/V$(NAME)
	gtkwave V$(NAME).vcd
dat:
	export PYTHONPATH=$(PYTHONPATH)
	cd data; \
	python vector_gen.py; \
	cd ..
verify:
	xxdiff data/result.hex data/test_ref.dat;
include $(LEVEL)/Makefile.common
