NAME=sonic_blocksync_xg
LEVEL=..
SRC_DIR = ../../../lib/shared/

# override ALL target
OVERRIDE=yes
all:
	echo "compile verilog to c++"
	verilator --trace --trace-depth 9 -Wall --cc $(SRC_DIR)/$(NAME) --Wno-lint --exe sim_main.cpp; \
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
	cd ..
include $(LEVEL)/Makefile.common
