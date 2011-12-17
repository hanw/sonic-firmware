NAME=sonic_rx_chan_66
LEVEL=../..
SRC_DIR = ../../../../lib/shared/
LIB_DIR = ../../../../lib/sonic/ram/
SIM_DIR = ../../../../lib/sonic/ram/sim/
CONST_DIR = ../../../../lib/shared/eth

# verilator -profile-cfuncs --trace --trace-depth 9 -Wall --cc $(SRC_DIR)/$(NAME) -I$(SRC_DIR) -I$(SRC_DIR)/circbuf -I$(LIB_DIR) -I$(SIM_DIR) -I$(CONST_DIR) --Wno-lint --exe sim_main.cpp; \
# override ALL target
OVERRIDE=yes
all:
	echo "compile verilog to c++"
	verilator --trace --trace-depth 9 -Wall --cc $(SRC_DIR)/$(NAME) -I$(SRC_DIR) -I$(SRC_DIR)/circbuf -I$(LIB_DIR) -I$(SIM_DIR) -I$(CONST_DIR) --Wno-lint --exe sim_main.cpp; \
 	cd obj_dir; \
	make -j -f V$(NAME).mk V$(NAME);# OPT=-DVL_DEBUG;
wave:
	./obj_dir/V$(NAME)
	gtkwave V$(NAME).vcd
dat:
	cd data; \
	python vector_gen.py; \
	cd ..
verify:
	cd data; \
	xxdiff result.hex test_vector.page; \
	cd ..
include $(LEVEL)/Makefile.common
