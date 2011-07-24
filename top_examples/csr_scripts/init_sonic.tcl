#---------------------------
#  SoNIC initialization
#---------------------------

source common.tcl
source pma.tcl

#init external xcvr (NETLOGIC)
source init_xcvr.tcl

#set PCIe to normal operation mode
set_pcie_operational
