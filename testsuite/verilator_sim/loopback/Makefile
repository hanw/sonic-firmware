NAME=sonic_loopback_test
LEVEL=..
SRC_DIR = ../../../lib/shared/
LIB_DIR = ../../../lib/sonic/ram/
SIM_DIR = ../../../lib/sonic/ram/sim/
CONST_DIR = ../../../lib/shared/circbuf/

# override ALL target
OVERRIDE=yes
all:
	echo "compile verilog to c++"
	verilator --trace --trace-depth 9 -Wall --cc $(NAME) -I$(SRC_DIR) -I$(LIB_DIR) -I$(SIM_DIR) -I$(CONST_DIR) -I$(SRC_DIR)/eth/ --Wno-lint --exe sim_main.cpp; \
 	cd obj_dir; \
	make -j -f V$(NAME).mk V$(NAME) ;
wave:
	./obj_dir/V$(NAME)
	gtkwave V$(NAME).vcd
dat:
	cd data; \
	python vector_gen.py; \
	cd ..
verify:
	cd data; \
	python verify.py; \
	xxdiff result.66b test_ref.66b;\
	cd ..
include $(LEVEL)/Makefile.common
