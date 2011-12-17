# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "top"
set SYSTEM_INSTANCE_NAME "tb"
set QSYS_SIMDIR "../sonic_application_top_testbench/testbench"
set SONIC_LIB_SRCDIR "../../../lib/shared/"
set SONIC_SPEC_SRCDIR "../../../lib/sonic/"
set SONIC_DES_SRCDIR "../../../designs/sonic_xg_blocksync/"

# Source Qsys-generated script and set up alias commands used below
#source $QSYS_SIMDIR/msim_setup.tcl      
# Compile device library files
#dev_com
# Compile the design files in correct order
#com               

# Compile the code for sonic_app
#source $SONIC_LIB_SRCDIR/msim_setup.tcl
#sonic_lib_com

#source $SONIC_SPEC_SRCDIR/msim_setup.tcl
#sonic_spec_com

#source $SONIC_DES_SRCDIR/msim_setup.tcl
#sonic_des_com

# Compile code for xg_blocksync design

# Compile the additional test files
#vlog -dpiheader dpiheader.h -sv ./test_program.sv
#vlog -sv ./top.sv
# Elaborate top level design
#elab
# Load the waveform "do file" Tcl script
#do ./wave.do
# Log 
#add log -r sim:/top/tb/*


