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
source pma.tcl

open_jtag

puts "=============================================================================="
puts "                      AEL2006 limiting interface initialization			    "
puts "==============================================================================\n\n"

# issue a hardware reset upon PHY power up

ext_xcvr_reset

wait_on_reset

set reg_value [access_mdio 0x0000]
puts "PMA/PMD control register 1 is [format "%#x" $reg_value]"

#API:
# access_mdio 0xC000
# write_mdio 0xC000 $value
#Write the Mode Selection Register

# write 1.C000.5 = 0
set	reg_value [access_mdio 0xC000]
set reg_value [clear_bit $reg_value 5]
write_mdio 0xC000 $reg_value
puts "Mode selection register 0xC000 is [format "%#x" [access_mdio 0xC000]]"

after 100

# write 1.C000.5 = 1
set reg_value [access_mdio 0xC000]
set reg_value [set_bit $reg_value 5]
write_mdio 0xC000 $reg_value
puts "Mode selection register 0xC000 is [format "%#x" [access_mdio 0xC000]]"

after 100
# XFI receive
#set reg_value [access_mdio 0xCC40]
#set reg_value [clear_bit $reg_value 7]
#write_mdio 0xCC40 $reg_value
#puts "Limiting E2O Rx Calibration register is [format "%#x" [access_mdio 0xCC40]]"

# write 1.CC41.6:0 = 0x7
set reg_value [access_mdio 0xCC41]
set reg_value [set_bit $reg_value 0]
set reg_value [set_bit $reg_value 1]
set reg_value [set_bit $reg_value 2]
set reg_value [clear_bit $reg_value 3]	
set reg_value [clear_bit $reg_value 4]
set reg_value [clear_bit $reg_value 5]
set reg_value [clear_bit $reg_value 6]
write_mdio 0xCC41 $reg_value
puts "XFI receive register 0xCC41 is [format "%#x" [access_mdio 0xCC41]]"

after 100
# write 1.CC46.8:5 = 0x7
set reg_value [access_mdio 0xCC46]
set reg_value [set_bit $reg_value 5]
set reg_value [set_bit $reg_value 6]
set reg_value [set_bit $reg_value 7]
set reg_value [clear_bit $reg_value 8]
write_mdio 0xCC46 $reg_value
puts "XFI receive register 0xCC46 is [format "%#x" [access_mdio 0xCC46]]"

after 100
# write 1.CB01.11:8 = 0xa
set reg_value [access_mdio 0xCB01]
set reg_value [clear_bit $reg_value 8]
set reg_value [set_bit $reg_value 9]
set reg_value [clear_bit $reg_value 10]
set reg_value [set_bit $reg_value 11]
write_mdio 0xCB01 $reg_value
puts "XFI receive register 0xCB01 is [format "%#x" [access_mdio 0xCB01]]"

after 100
# write 1.CC44.3:0 = 0xF
set reg_value [access_mdio 0xCC44]
set reg_value [set_bit $reg_value 0]
set reg_value [set_bit $reg_value 1]
set reg_value [set_bit $reg_value 2]
set reg_value [set_bit $reg_value 3]
write_mdio 0xCC44 $reg_value
puts "XFI receive register 0xCC44 is [format "%#x" [access_mdio 0xCC44]]"

after 100
# SFI limiting receive
# turn off receive offset calibration loop
set reg_value [access_mdio 0xCC00]
set reg_value [clear_bit $reg_value 7]
write_mdio 0xCC00 $reg_value
puts "Limiting O2E Rx Calibration register is [format "%#x" [access_mdio 0xCC00]]"

after 100
# write 1.CC01.6:0 = 0x7
set reg_value [access_mdio 0xCC01]
set reg_value [set_bit $reg_value 0]
set reg_value [set_bit $reg_value 1]
set reg_value [set_bit $reg_value 2]
set reg_value [clear_bit $reg_value 3]
set reg_value [clear_bit $reg_value 4]
set reg_value [clear_bit $reg_value 5]
set reg_value [clear_bit $reg_value 6]
write_mdio 0xCC01 $reg_value
puts "SFI receive register 0xCC01 is [format "%#x" [access_mdio 0xCC01]]"

after 100
# write 1.CC06.8:5 = 0x7
set reg_value [access_mdio 0xCC06]
set reg_value [set_bit $reg_value 5]
set reg_value [set_bit $reg_value 6]
set reg_value [set_bit $reg_value 7]
set reg_value [clear_bit $reg_value 8]
write_mdio 0xCC06 $reg_value
puts "SFI receive register 0xCC06 is [format "%#x" [access_mdio 0xCC06]]"

after 100
# write 1.CB1B.11:8 = 0xa
set reg_value [access_mdio 0xCB1B]
set reg_value [clear_bit $reg_value 0]
set reg_value [set_bit $reg_value 1]
set reg_value [clear_bit $reg_value 2]
set reg_value [set_bit $reg_value 3]
#set reg_value [clear_bit $reg_value 8]
#set reg_value [set_bit $reg_value 9]
#set reg_value [clear_bit $reg_value 10]
#set reg_value [set_bit $reg_value 11]
write_mdio 0xCB1B $reg_value
puts "SFI receive register 0xCB1B is [format "%#x" [access_mdio 0xCB1B]]"

after 100
# write 1.CC04.3:0 = 0xF
set reg_value [access_mdio 0xCC04]
set reg_value [set_bit $reg_value 0]
set reg_value [set_bit $reg_value 1]
set reg_value [set_bit $reg_value 2]
set reg_value [set_bit $reg_value 3]
write_mdio 0xCC04 $reg_value
puts "SFI receive register 0xCC04 is [format "%#x" [access_mdio 0xCC04]]"

after 100
# write 1.CC8E.1 = 0x1
#set reg_value [access_mdio 0xCC8E]
#set reg_value [set_bit $reg_value 1]
#write_mdio 0xCC8E $reg_value
#puts "Enable O2E transmit preemphasis [format "%#x" [access_mdio 0xCC8E]]"


# Following Netlogic Programming Appnote
after 100
set reg_value [access_mdio 0xCCD0]
#3:0 = 0
set reg_value [clear_bit $reg_value 0]
set reg_value [clear_bit $reg_value 1]
set reg_value [clear_bit $reg_value 2]
set reg_value [clear_bit $reg_value 3]
#7:4 = E
set reg_value [clear_bit $reg_value 4]
set reg_value [set_bit $reg_value 5]
set reg_value [set_bit $reg_value 6]
set reg_value [set_bit $reg_value 7]
#11:8 = F
set reg_value [set_bit $reg_value 8]
set reg_value [set_bit $reg_value 9]
set reg_value [set_bit $reg_value 10]
set reg_value [set_bit $reg_value 11]
#15:12 = 5
set reg_value [set_bit $reg_value 12]
set reg_value [clear_bit $reg_value 13]
set reg_value [set_bit $reg_value 14]
set reg_value [clear_bit $reg_value 15]
write_mdio 0xCCD0 $reg_value
puts "Set Transmit Preemphasis [format "%#x" [access_mdio 0xCCD0]]"

after 100
# write 1.CCCE.1 = 0x1
set reg_value [access_mdio 0xCCCE]
set reg_value [set_bit $reg_value 1]
write_mdio 0xCCCE $reg_value
puts "Enable E2O transmit preemphasis [format "%#x" [access_mdio 0xCCCE]]"

after 100
close_jtag
