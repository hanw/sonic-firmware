# TCL File Generated by Component Editor 11.0
# Fri Aug 19 10:39:38 EDT 2011
# DO NOT MODIFY


# +-----------------------------------
# | 
# | avalon_read_master "avalon_read_master" v1.0
# | Han Wang 2011.08.19.10:39:38
# | 
# | 
# | /home/hwang/sonic/projects/sonic_fpga/src/top_examples/misc/avalon_mm_master/latency_aware_read_master.v
# | 
# |    ./latency_aware_read_master.v syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# | 
package require -exact sopc 11.0
# | 
# +-----------------------------------

# +-----------------------------------
# | module avalon_read_master
# | 
set_module_property NAME avalon_read_master
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Templates
set_module_property AUTHOR "Han Wang"
set_module_property DISPLAY_NAME avalon_read_master
set_module_property TOP_LEVEL_HDL_FILE latency_aware_read_master.v
set_module_property TOP_LEVEL_HDL_MODULE latency_aware_read_master
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
set_module_property STATIC_TOP_LEVEL_MODULE_NAME latency_aware_read_master
set_module_property FIX_110_VIP_PATH false
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file latency_aware_read_master.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
add_parameter DATAWIDTH INTEGER 32
set_parameter_property DATAWIDTH DEFAULT_VALUE 32
set_parameter_property DATAWIDTH DISPLAY_NAME DATAWIDTH
set_parameter_property DATAWIDTH TYPE INTEGER
set_parameter_property DATAWIDTH UNITS None
set_parameter_property DATAWIDTH ALLOWED_RANGES {8 16 32 64 128 256 512 1024}
set_parameter_property DATAWIDTH AFFECTS_GENERATION false
set_parameter_property DATAWIDTH HDL_PARAMETER true
add_parameter BYTEENABLEWIDTH INTEGER 4
set_parameter_property BYTEENABLEWIDTH DEFAULT_VALUE 4
set_parameter_property BYTEENABLEWIDTH DISPLAY_NAME BYTEENABLEWIDTH
set_parameter_property BYTEENABLEWIDTH TYPE INTEGER
set_parameter_property BYTEENABLEWIDTH UNITS None
set_parameter_property BYTEENABLEWIDTH ALLOWED_RANGES 4
set_parameter_property BYTEENABLEWIDTH AFFECTS_GENERATION false
set_parameter_property BYTEENABLEWIDTH HDL_PARAMETER true
add_parameter ADDRESSWIDTH INTEGER 32
set_parameter_property ADDRESSWIDTH DEFAULT_VALUE 32
set_parameter_property ADDRESSWIDTH DISPLAY_NAME ADDRESSWIDTH
set_parameter_property ADDRESSWIDTH TYPE INTEGER
set_parameter_property ADDRESSWIDTH UNITS None
set_parameter_property ADDRESSWIDTH ALLOWED_RANGES {32 31 30 29 28 27 26 25 24 23 22 21 20 19 18 17 16 14 13 12 11 10 9 8 7 6 5 4}
set_parameter_property ADDRESSWIDTH AFFECTS_GENERATION false
set_parameter_property ADDRESSWIDTH HDL_PARAMETER true
add_parameter FIFODEPTH INTEGER 32
set_parameter_property FIFODEPTH DEFAULT_VALUE 32
set_parameter_property FIFODEPTH DISPLAY_NAME FIFODEPTH
set_parameter_property FIFODEPTH TYPE INTEGER
set_parameter_property FIFODEPTH UNITS None
set_parameter_property FIFODEPTH ALLOWED_RANGES {4 8 16 32 64 128 256}
set_parameter_property FIFODEPTH AFFECTS_GENERATION false
set_parameter_property FIFODEPTH HDL_PARAMETER true
add_parameter FIFODEPTH_LOG2 INTEGER 5
set_parameter_property FIFODEPTH_LOG2 DEFAULT_VALUE 5
set_parameter_property FIFODEPTH_LOG2 DISPLAY_NAME FIFODEPTH_LOG2
set_parameter_property FIFODEPTH_LOG2 TYPE INTEGER
set_parameter_property FIFODEPTH_LOG2 UNITS None
set_parameter_property FIFODEPTH_LOG2 ALLOWED_RANGES 2:8
set_parameter_property FIFODEPTH_LOG2 AFFECTS_GENERATION false
set_parameter_property FIFODEPTH_LOG2 HDL_PARAMETER true
add_parameter FIFOUSEMEMORY INTEGER 1 "Select false if you want register based (0) FIFO instead of memory (1)"
set_parameter_property FIFOUSEMEMORY DEFAULT_VALUE 1
set_parameter_property FIFOUSEMEMORY DISPLAY_NAME FIFOUSEMEMORY
set_parameter_property FIFOUSEMEMORY TYPE INTEGER
set_parameter_property FIFOUSEMEMORY UNITS None
set_parameter_property FIFOUSEMEMORY ALLOWED_RANGES {1:Memory 0:Logic}
set_parameter_property FIFOUSEMEMORY DESCRIPTION "Select false if you want register based (0) FIFO instead of memory (1)"
set_parameter_property FIFOUSEMEMORY AFFECTS_GENERATION false
set_parameter_property FIFOUSEMEMORY HDL_PARAMETER true
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clock
# | 
add_interface clock clock end
set_interface_property clock clockRate 50000000

set_interface_property clock ENABLED true

add_interface_port clock clk clk Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point reset
# | 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT

set_interface_property reset ENABLED true

add_interface_port reset reset reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point csr
# | 
add_interface csr avalon end
set_interface_property csr addressUnits WORDS
set_interface_property csr associatedClock clock
set_interface_property csr associatedReset reset
set_interface_property csr bitsPerSymbol 8
set_interface_property csr burstOnBurstBoundariesOnly false
set_interface_property csr burstcountUnits WORDS
set_interface_property csr explicitAddressSpan 0
set_interface_property csr holdTime 0
set_interface_property csr linewrapBursts false
set_interface_property csr maximumPendingReadTransactions 0
set_interface_property csr readLatency 0
set_interface_property csr readWaitTime 1
set_interface_property csr setupTime 0
set_interface_property csr timingUnits Cycles
set_interface_property csr writeWaitTime 0

set_interface_property csr ENABLED true

add_interface_port csr avs_csr_address address Input 4
add_interface_port csr avs_csr_readdata readdata Output 32
add_interface_port csr avs_csr_write write Input 1
add_interface_port csr avs_csr_writedata writedata Input 32
add_interface_port csr avs_csr_read read Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_master
# | 
add_interface avalon_master avalon start
set_interface_property avalon_master addressUnits SYMBOLS
set_interface_property avalon_master associatedClock clock
set_interface_property avalon_master associatedReset reset
set_interface_property avalon_master bitsPerSymbol 8
set_interface_property avalon_master burstOnBurstBoundariesOnly false
set_interface_property avalon_master burstcountUnits WORDS
set_interface_property avalon_master doStreamReads false
set_interface_property avalon_master doStreamWrites false
set_interface_property avalon_master holdTime 0
set_interface_property avalon_master linewrapBursts false
set_interface_property avalon_master maximumPendingReadTransactions 1
set_interface_property avalon_master readLatency 0
set_interface_property avalon_master readWaitTime 1
set_interface_property avalon_master setupTime 0
set_interface_property avalon_master timingUnits Cycles
set_interface_property avalon_master writeWaitTime 0

set_interface_property avalon_master ENABLED true

add_interface_port avalon_master master_address address Output ADDRESSWIDTH
add_interface_port avalon_master master_read read Output 1
add_interface_port avalon_master master_byteenable byteenable Output BYTEENABLEWIDTH
add_interface_port avalon_master master_readdata readdata Input DATAWIDTH
add_interface_port avalon_master master_readdatavalid readdatavalid Input 1
add_interface_port avalon_master master_waitrequest waitrequest Input 1
# | 
# +-----------------------------------
