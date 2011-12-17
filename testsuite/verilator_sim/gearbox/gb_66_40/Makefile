NAME=sonic_gb_66_40_testbench
LEVEL=../..
SRC_DIR = ../../../../lib/shared/eth/

# override ALL target
OVERRIDE=yes
all:
	echo "compile verilog to c++"
	verilator --trace --trace-depth 9 -Wall --cc $(NAME) --I$(SRC_DIR) --Wno-lint --exe sim_main.cpp; \
 	cd obj_dir; \
	make -j -f V$(NAME).mk V$(NAME) ;
wave:
	./obj_dir/V$(NAME)
	gtkwave V$(NAME).vcd
dat:
	cd data; \
	python convert.py; \
	cd ..;
verify:
	cd data; \
	tail -n +9 result.hex > /tmp/actual_result.hex ; \
	cat test_vector.dat > /tmp/actual_test_vector.dat; \
	python verify.py; \
	xxdiff /tmp/actual_test_result.bin /tmp/actual_test_vector.bin; \
	cd ..;
include $(LEVEL)/Makefile.common
