BENCHMARK = 
BENCHMARK_FOLDERS = 
BENCHMARK_HYBRID_FOLDERS = 
# there is no mips in the 2nd hybrid
BENCHMARK_FOLDERS2 = 
DIRS = gearbox \
	   $(BENCHMARK) \
	   $(BENCHMARK_HYBRID_FOLDERS)
LEVEL = .

include Makefile.config

$(TARGETS):
	for dir in $(DIRS); do make $@ -C $$dir; done

# Run a full Quartus compile for all the benchmark circuits
benchmark:
	for dir in $(BENCHMARK); do make p -C $$dir; done
	for dir in $(BENCHMARK); do make f -C $$dir; done
	./benchmark.pl --family $(FAMILY)

# compile hybrids with quartus
hybrid_quartus:
	for dir in $(BENCHMARK_FOLDERS); do make hybridquartus -C $$dir; done

# simulate the hybrids
hybrid_sim:
	$(RUNTEST) ../dejagnu/hybrid_sim/*.exp

hybrid_parse:
	# these files are parsed by benchmark.pl for the buildbot plots
	for dir in $(BENCHMARK_FOLDERS); do make benchmarkfiles -C $$dir; done
	./benchmark.pl --family $(FAMILY)
	cat benchmark.csv

# compile 2nd hybrids with quartus
hybrid2_quartus:
	for dir in $(BENCHMARK_FOLDERS2); do make hybrid2quartus -C $$dir; done

# simulate the 2nd hybrids
hybrid2_sim:
	$(RUNTEST) ../dejagnu/hybrid2_sim/*.exp

hybrid2_parse:
	# these files are parsed by benchmark.pl for the buildbot plots
	for dir in $(BENCHMARK_FOLDERS2); do make benchmarkfiles2 -C $$dir; done
	./benchmark.pl --family $(FAMILY)
	cat benchmark.csv

estimate:
	./runnoop.pl

# include output from tests
# Surprisingly you need to manually set status=1
# to ensure runtest fails on all tcl errors
#RUNTEST = runtest -v -v -v -v --all --status=1
RUNTEST = runtest -all --status=1

# should finish quickly (doesn't run jpeg)
test:
	$(RUNTEST)

test_jpeg:
	$(RUNTEST) ../dejagnu/jpeg.exp

test_tiger_sim:
	$(RUNTEST) ../dejagnu/tiger_sim/*.exp

tiger_quartus:
	# compile tiger standalone processor
	cd $(PROC_DIR)/.. && quartus_sh --flow compile tiger_top

tiger_sim:
	# simulate benchmarks on tiger
	for dir in $(BENCHMARK); do make tigersim -C $$dir; done

tiger_parse:
	# these files are parsed by benchmark.pl for the buildbot plots
	# every benchmark is run on tiger - they all have the same area/fmax
	for dir in $(BENCHMARK_FOLDERS); do cp -f $(PROC_DIR)/../tiger_top.tan.summary $$dir/top.tan.summary; done
	for dir in $(BENCHMARK_FOLDERS); do cp -f $(PROC_DIR)/../tiger_top.fit.summary $$dir/top.fit.summary; done
	./benchmark.pl --family $(FAMILY)
	cat benchmark.csv

test_full:
	# run everything (including jpeg) with:
	# NO_OPT=0 NO_INLINE=1
	# NO_OPT=1 NO_INLINE=1
	$(RUNTEST) ../dejagnu/full_test/*.exp

test_legup:
	make cleanall

test_tiger_gxemul:
	make cleanall

test_tiger_gxemul_no_opt:
	make cleanall

test_legup_no_opt:
	make cleanall

test_tiger_jpeg:
	make cleanall

test_legup_jpeg:
	make cleanall


# Create a tarball of all the chstone benchmarks + dhrystone
# ie. benchmarks-Aug-18.tar.gz
folder=benchmarks-`date +%b-%d-%Y`
define TARBALL_README
Legup Benchmarks
-----------------
To simulate mips.v with modelsim:
	cd chstone/mips
	vlib work
	vlog -v ../../lib/altera_mf.v ../../lib/220model.v mips.v
	vsim -c -do "run 7000000000000000ns; exit;" work.main_tb

All benchmarks should finish with return_val = 0.
endef
export TARBALL_README
tarball:
	# for cleanup:
	for dir in $(BENCHMARK_FOLDERS); do rm $$dir/*.v ; done
	for dir in $(BENCHMARK_FOLDERS); do rm $$dir/*.mif ; done
	# generate verilog (including jpeg)
	for dir in $(BENCHMARK); do make -C $$dir; done
	# copy over verilog into temporary folder
	mkdir -p ${folder}
	mkdir -p ${folder}/lib
	for dir in $(BENCHMARK_FOLDERS); do mkdir -p ${folder}/$$dir; done
	for dir in $(BENCHMARK_FOLDERS); do cp $$dir/*.v ${folder}/$$dir; done
	for dir in $(BENCHMARK_FOLDERS); do cp $$dir/*.mif ${folder}/$$dir; done
	# include altera modules
	cp ${VERILOG_LIBS} ${folder}/lib/
	# add a readme
	echo "$$TARBALL_README" > ${folder}/README
	# tarball benchmarks
	tar cvzf ${folder}.tar.gz ${folder}

.PHONY : $(TARGETS) benchmark estimate test tarball test_tiger_sim test_full test_legup test_tiger_gxemul test_tiger_gxemul_no_opt test_legup_no_opt test_tiger_jpeg test_legup_jpeg hybrid_sim hybrid_parse hybrid_quartus tiger_parse tiger_sim tiger_quartus
