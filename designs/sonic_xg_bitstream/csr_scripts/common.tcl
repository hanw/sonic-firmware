#(C) 2001-2010 Altera Corporation. All rights reserved.
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


global jtag_master
#==============================================================================
#                       Open JTAG               
#==============================================================================
proc open_jtag {} {
    global jtag_master
    
    set jtag_master [lindex [get_service_paths master] 0];
    open_service master $jtag_master;
    puts "\nInfo: Opened JTAG Master Service\n"
}

#==============================================================================
#                       Close JTAG               
#==============================================================================
proc close_jtag {} {
    global jtag_master

    close_service master $jtag_master;
    puts "\nInfo: Closed JTAG Master Service\n\n";
}

#==============================================================================
# Write 32                
#==============================================================================
proc wr32 {base_address sub_base_address offset value} {
    global jtag_master
	
    set address [expr $base_address + $sub_base_address + $offset];
    set address_hex [format "%#x" $address];
    master_write_32 $jtag_master $address_hex $value;
}

#==============================================================================
# Read 32                
#==============================================================================
proc rd32 {base_address sub_base_address offset} {
    global jtag_master
	
    set address [expr $base_address + $sub_base_address + $offset];
    set address_hex [format "%#x" $address];
    set data [master_read_32 $jtag_master $address_hex 1] 
    return $data
}

#==============================================================================
# Read 64                
#==============================================================================
proc rd64 {base_address sub_base_address offset} {
    global jtag_master

    set address [expr $base_address + $sub_base_address + $offset];
    set address_hex [format "%#x" $address];
    set data1 [master_read_32 $jtag_master $address_hex 1]
    set data2 [master_read_32 $jtag_master [expr $address_hex + 0x04] 1]
    regsub {0x} $data1 {} data1  
    return $data2$data1
}

