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
puts "                      Accessing Ethernet 10G MAC CSR			    "
puts "==============================================================================\n\n"

#==============================================================================
#                       Configuring RX fifo to                
#============================================================================
set_fifo_drop_on_error1 1
set_fifo_drop_on_error2 1

#==============================================================================
#                       Configuring MAC Source Address               
#==============================================================================
read_address_inserter1
set_address_inserter1 1
# Note: that the write MAC src address must be little endian!
# The proper src MAC address is 20-10-00-C2-80-01
write_MAC_src_address1 0x0180C2001020
read_address_inserter1

read_address_inserter2
set_address_inserter2 1
write_MAC_src_address2 0xFFAACC88CCEE
read_address_inserter2

close_jtag
