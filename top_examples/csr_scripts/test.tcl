# (C) 2001-2010 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


source common.tcl
source csr_pkg.tcl

open_jtag

puts "=============================================================================="
puts "                      Start Ethernet 10G packet loopback test			    "
puts "==============================================================================\n\n"


# External PHY Status and Control Signals
# Bit 11-8: 0, SFP2_MOD, SFP1_MOD, SFP1_TX_FAULT
# Bit 7-4: SFP2_TX_FAULT, L2_PWRDN, L1_PWRDN, S2_TX_DISABLE
# Bit 3-0: S1_TX_DISABLE, SFP2_RSEL, SFP1_RSEL, PHY_RESET_N
read_stats1 tx
read_stats2 rx
read_mac_control

#set_pma_loopback

config_pkt_gen1
config_pkt_mon2

start_netlogic_loopback_test

read_stats1 tx
read_stats2 rx

close_jtag
