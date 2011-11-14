# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "top"
set SYSTEM_INSTANCE_NAME "tb"
set QSYS_SIMDIR "../sonic_application_top_testbench/testbench"
set SONIC_APP_SRCDIR "../../../src/top_examples/sonic_chaining_dma/"
# Source Qsys-generated script and set up alias commands used below
source $QSYS_SIMDIR/msim_setup.tcl      
# Compile device library files
dev_com
# Compile the design files in correct order
com               

source $SONIC_APP_SRCDIR/msim_setup.tcl
#Compile the code for sonic_app
sonic_app_com

# Compile the additional test files
vlog -sv ./test_program.sv
vlog -sv ./top.sv           
# Elaborate top level design
elab
# Load the waveform "do file" Tcl script
do ./wave.do
# Log 
add log -r sim:/top/tb/*
