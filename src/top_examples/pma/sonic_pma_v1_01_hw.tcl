# TCL File Generated by Component Editor 11.0
# Mon Sep 05 22:21:22 EDT 2011
# DO NOT MODIFY


# +-----------------------------------
# | 
# | sonic_pma_v1_01 "sonic_pma_v1_01" v1.0
# | null 2011.09.05.22:21:22
# | 
# | 
# | /home/hwang/sonic/projects/sonic_fpga_bugfix/dup_bar/src/top_examples/pma/sonic_pma_v1_01.v
# | 
# |    ./sonic_pma_v1_01.v syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# | 
package require -exact sopc 11.0
# | 
# +-----------------------------------

# +-----------------------------------
# | module sonic_pma_v1_01
# | 
set_module_property NAME sonic_pma_v1_01
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property DISPLAY_NAME sonic_pma_v1_01
set_module_property TOP_LEVEL_HDL_FILE sonic_pma_v1_01.v
set_module_property TOP_LEVEL_HDL_MODULE sonic_pma_v1_01
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
set_module_property STATIC_TOP_LEVEL_MODULE_NAME sonic_pma_v1_01
set_module_property FIX_110_VIP_PATH false
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file sonic_pma_v1_01.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point phy_mgmt
# | 
add_interface phy_mgmt avalon end
set_interface_property phy_mgmt addressUnits WORDS
set_interface_property phy_mgmt associatedClock phy_mgmt_clk
set_interface_property phy_mgmt associatedReset phy_mgmt_clk_reset
set_interface_property phy_mgmt bitsPerSymbol 8
set_interface_property phy_mgmt burstOnBurstBoundariesOnly false
set_interface_property phy_mgmt burstcountUnits WORDS
set_interface_property phy_mgmt explicitAddressSpan 0
set_interface_property phy_mgmt holdTime 0
set_interface_property phy_mgmt linewrapBursts false
set_interface_property phy_mgmt maximumPendingReadTransactions 0
set_interface_property phy_mgmt readLatency 0
set_interface_property phy_mgmt readWaitTime 1
set_interface_property phy_mgmt setupTime 0
set_interface_property phy_mgmt timingUnits Cycles
set_interface_property phy_mgmt writeWaitTime 0

set_interface_property phy_mgmt ENABLED true

add_interface_port phy_mgmt phy_mgmt_address address Input 9
add_interface_port phy_mgmt phy_mgmt_read read Input 1
add_interface_port phy_mgmt phy_mgmt_readdata readdata Output 32
add_interface_port phy_mgmt phy_mgmt_waitrequest waitrequest Output 1
add_interface_port phy_mgmt phy_mgmt_write write Input 1
add_interface_port phy_mgmt phy_mgmt_writedata writedata Input 32
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point phy_mgmt_clk
# | 
add_interface phy_mgmt_clk clock end
set_interface_property phy_mgmt_clk clockRate 0

set_interface_property phy_mgmt_clk ENABLED true

add_interface_port phy_mgmt_clk phy_mgmt_clk clk Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point tx_ready
# | 
add_interface tx_ready conduit end

set_interface_property tx_ready ENABLED true

add_interface_port tx_ready tx_ready export Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_ready
# | 
add_interface rx_ready conduit end

set_interface_property rx_ready ENABLED true

add_interface_port rx_ready rx_ready export Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point pll_ref_clk
# | 
add_interface pll_ref_clk clock end
set_interface_property pll_ref_clk clockRate 0

set_interface_property pll_ref_clk ENABLED true

add_interface_port pll_ref_clk pll_ref_clk clk Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point pll_locked
# | 
add_interface pll_locked conduit end

set_interface_property pll_locked ENABLED true

add_interface_port pll_locked pll_locked export Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point tx_serial_data
# | 
add_interface tx_serial_data conduit end

set_interface_property tx_serial_data ENABLED true

add_interface_port tx_serial_data tx_serial_data export Output 2
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_serial_data
# | 
add_interface rx_serial_data conduit end

set_interface_property rx_serial_data ENABLED true

add_interface_port rx_serial_data rx_serial_data export Input 2
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_is_lockedtoref
# | 
add_interface rx_is_lockedtoref conduit end

set_interface_property rx_is_lockedtoref ENABLED true

add_interface_port rx_is_lockedtoref rx_is_lockedtoref export Output 2
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_is_lockedtodata
# | 
add_interface rx_is_lockedtodata conduit end

set_interface_property rx_is_lockedtodata ENABLED true

add_interface_port rx_is_lockedtodata rx_is_lockedtodata export Output 2
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point tx_clkout_0
# | 
add_interface tx_clkout_0 clock start
set_interface_property tx_clkout_0 associatedDirectClock ""
set_interface_property tx_clkout_0 clockRate 0
set_interface_property tx_clkout_0 clockRateKnown false

set_interface_property tx_clkout_0 ENABLED true

add_interface_port tx_clkout_0 tx_clkout0 clk Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_clkout_0
# | 
add_interface rx_clkout_0 clock start
set_interface_property rx_clkout_0 associatedDirectClock ""
set_interface_property rx_clkout_0 clockRate 0
set_interface_property rx_clkout_0 clockRateKnown false

set_interface_property rx_clkout_0 ENABLED true

add_interface_port rx_clkout_0 rx_clkout0 clk Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point phy_mgmt_clk_reset
# | 
add_interface phy_mgmt_clk_reset reset end
set_interface_property phy_mgmt_clk_reset associatedClock phy_mgmt_clk
set_interface_property phy_mgmt_clk_reset synchronousEdges DEASSERT

set_interface_property phy_mgmt_clk_reset ENABLED true

add_interface_port phy_mgmt_clk_reset phy_mgmt_clk_reset reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_parallel_data0
# | 
add_interface rx_parallel_data0 avalon_streaming start
set_interface_property rx_parallel_data0 associatedClock rx_clkout_0
set_interface_property rx_parallel_data0 associatedReset phy_mgmt_clk_reset
set_interface_property rx_parallel_data0 dataBitsPerSymbol 40
set_interface_property rx_parallel_data0 errorDescriptor ""
set_interface_property rx_parallel_data0 firstSymbolInHighOrderBits true
set_interface_property rx_parallel_data0 maxChannel 0
set_interface_property rx_parallel_data0 readyLatency 0

set_interface_property rx_parallel_data0 ENABLED true

add_interface_port rx_parallel_data0 rx_parallel_data0 data Output 40
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point tx_parallel_data0
# | 
add_interface tx_parallel_data0 avalon_streaming end
set_interface_property tx_parallel_data0 associatedClock tx_clkout_0
set_interface_property tx_parallel_data0 associatedReset phy_mgmt_clk_reset
set_interface_property tx_parallel_data0 dataBitsPerSymbol 40
set_interface_property tx_parallel_data0 errorDescriptor ""
set_interface_property tx_parallel_data0 firstSymbolInHighOrderBits true
set_interface_property tx_parallel_data0 maxChannel 0
set_interface_property tx_parallel_data0 readyLatency 0

set_interface_property tx_parallel_data0 ENABLED true

add_interface_port tx_parallel_data0 tx_parallel_data0 data Input 40
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_parallel_data1
# | 
add_interface rx_parallel_data1 avalon_streaming start
set_interface_property rx_parallel_data1 associatedClock rx_clkout_1
set_interface_property rx_parallel_data1 associatedReset phy_mgmt_clk_reset
set_interface_property rx_parallel_data1 dataBitsPerSymbol 40
set_interface_property rx_parallel_data1 errorDescriptor ""
set_interface_property rx_parallel_data1 firstSymbolInHighOrderBits true
set_interface_property rx_parallel_data1 maxChannel 0
set_interface_property rx_parallel_data1 readyLatency 0

set_interface_property rx_parallel_data1 ENABLED true

add_interface_port rx_parallel_data1 rx_parallel_data1 data Output 40
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point tx_parallel_data1
# | 
add_interface tx_parallel_data1 avalon_streaming end
set_interface_property tx_parallel_data1 associatedClock tx_clkout_1
set_interface_property tx_parallel_data1 associatedReset phy_mgmt_clk_reset
set_interface_property tx_parallel_data1 dataBitsPerSymbol 40
set_interface_property tx_parallel_data1 errorDescriptor ""
set_interface_property tx_parallel_data1 firstSymbolInHighOrderBits true
set_interface_property tx_parallel_data1 maxChannel 0
set_interface_property tx_parallel_data1 readyLatency 0

set_interface_property tx_parallel_data1 ENABLED true

add_interface_port tx_parallel_data1 tx_parallel_data1 data Input 40
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point tx_clkout_1
# | 
add_interface tx_clkout_1 clock start
set_interface_property tx_clkout_1 associatedDirectClock ""
set_interface_property tx_clkout_1 clockRate 0
set_interface_property tx_clkout_1 clockRateKnown false

set_interface_property tx_clkout_1 ENABLED true

add_interface_port tx_clkout_1 tx_clkout1 clk Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_clkout_1
# | 
add_interface rx_clkout_1 clock start
set_interface_property rx_clkout_1 associatedDirectClock ""
set_interface_property rx_clkout_1 clockRate 0
set_interface_property rx_clkout_1 clockRateKnown false

set_interface_property rx_clkout_1 ENABLED true

add_interface_port rx_clkout_1 rx_clkout1 clk Output 1
# | 
# +-----------------------------------
