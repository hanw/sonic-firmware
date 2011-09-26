# Set the hierarchy variables used in Qsys-generated msim_setup.tcl
set TOP_LEVEL_NAME "sonic_chaining_testbench"
set SYSTEM_INSTANCE_NAME "tb"
set SONIC_APP_SRCDIR "../../src/top_examples/sonic_chaining_dma/"
set SONIC_COMMON_SRCDIR "../../src/top_examples/common/testbench/"
set SONIC_PCI_IP_SRCDIR "../../src/ip_compiler_for_pci_express-library/"

source msim_setup.tcl
dev_com
com

source $SONIC_APP_SRCDIR/msim_setup.tcl
#Compile the code for sonic_app
sonic_app_com

source $SONIC_COMMON_SRCDIR/msim_setup.tcl
sonic_common_com

#source $SONIC_PCI_IP_SRCDIR/msim_setup.tcl
#sonic_pci_ip_com

# Compile the additional test files
vlog -sv +incdir+$SONIC_APP_SRCDIR+$SONIC_COMMON_SRCDIR+. ./sonictb_bfm_driver_chaining.v
vlog -sv +incdir+$SONIC_APP_SRCDIR+$SONIC_COMMON_SRCDIR+. ./sonic_chaining_testbench.v

# Elaborate top level design
elab
# Load the waveform "do file" Tcl script
do ./wave.do
# Log 
#add log -r sim:/top/tb/*
run 2ms
