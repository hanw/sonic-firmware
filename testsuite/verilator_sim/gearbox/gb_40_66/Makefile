NAME=sonic_gearbox_40_66
LEVEL=../..
SRC_DIR = ../../../../lib/shared/eth/
DATA=data

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
dat: $(LEVEL)/scripts/test_vector.dat
	cd data; \
	python convert.py; \
	cd ..
verify: $(DATA)/result.hex
	cd data; \
	python verify.py; \
	xxdiff /tmp/test_result.bin /tmp/test_vector.bin; \
	cd ..

include $(LEVEL)/Makefile.common
