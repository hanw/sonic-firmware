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


#==============================================================================
#                       Example Design Address Map
#  Avalon memory mapping for sonic_v1_00
#==============================================================================
set MDIO_BASE_ADDR			0x00000800
set RX_SC_FIFO_BASE_ADDR 	0x00000900
set PCS_BASE_ADDR			0x00040000
set PMA_BASE_ADDR			0x00050000

set MAC_BASE_ADDR			0x00010000
set LB_BASE_ADDR			0x00000940
set PKT_GEN_BASE_ADDR		0x00000980
set PKT_MON_BASE_ADDR		0x000009C0

set EXT_XCVR_BASE_ADDR		0x00001000

set MAC_BASE_ADDR2			0x00020000
set RX_SC_FIFO_BASE_ADDR2 	0x00002900
set TX_SC_FIFO_BASE_ADDR2    0x00002920
set LB_BASE_ADDR2			0x00002940
set PKT_GEN_BASE_ADDR2		0x00002980
set PKT_MON_BASE_ADDR2		0x000029C0
#==============================================================================
#                       PMA Address Map                
#==============================================================================
set ALT_PMA_CONTROLLER_BASE_ADDR    0x00000080
set ALT_PMA_RESET_BASE_ADDR			0x00000100
set ALT_PMA_CH_CONTROLLER_BASE_ADDR 0x00000180
#==============================================================================
#                       PCS Address Map                
#==============================================================================
set ALT_PCS_BASE_ADDR          0x00000200

#==============================================================================
#                       MAC Address Map                
#==============================================================================
# RX path
set RX_BACKPRESSURE_BASE_ADDR 	0x00000000
set CRC_PAD_REMOVER_BASE_ADDR 	0x00000100
set CRC_CHECKER_BASE_ADDR		0x00000200 
set RX_FRAME_DECODER_BASE_ADDR 	0x00002000
set OVERFLOW_CTRL_BASE_ADDR 	0x00000300
set RX_STATISTICS_BASE_ADDR 	0x00003000

# TX path
set TX_BACKPRESSURE_BASE_ADDR 	0x00004000
set CRC_INSERTER_BASE_ADDR		0x00004200
set PAD_INSERTER_BASE_ADDR		0x00004100
set PAUSE_GEN_CTRL_BASE_ADDR 	0x00004500
set ADDRESS_INSERTER_BASE_ADDR 	0x00004800
set TX_FRAME_DECODER_BASE_ADDR 	0x00006000
set UNDERFLOW_CTRL_BASE_ADDR 	0x00006300
set TX_STATISTICS_BASE_ADDR 	0x00007000

#==============================================================================
#                       APIs              
#==============================================================================

#==============================================================================
#                       APIs for loopback features              
#==============================================================================

# Read line loopback register
proc read_loopback {} {
    global LB_BASE_ADDR
    global LB_BASE_ADDR2
 
    puts "Reading Line Loopback 1: [rd32 $LB_BASE_ADDR 0x0 0x0]\n"
    puts "Reading Local Loopback 1: [rd32 $LB_BASE_ADDR 0x8 0x0]\n"

    puts "Reading Line Loopback 2: [rd32 $LB_BASE_ADDR2 0x0 0x0]\n"
    puts "Reading Local Loopback 2: [rd32 $LB_BASE_ADDR2 0x8 0x0]\n"
}

# Write to line loopback back register with the given value
# value = 0 or 1
proc write_line_loopback1 {value} {
    global LB_BASE_ADDR

    puts "Writing $value to Line Loopback 1\n"
    wr32 $LB_BASE_ADDR 0x0 0x0 $value
}

proc write_line_loopback2 {value} {
    global LB_BASE_ADDR2

    puts "Writing $value to Line Loopback 2\n"
    wr32 $LB_BASE_ADDR2 0x0 0x0 $value
}

proc write_local_loopback1 {value} {
    global LB_BASE_ADDR

    puts "Writing $value to Local Loopback 1\n"
    wr32 $LB_BASE_ADDR 0x8 0x0 $value
}

proc write_local_loopback2 {value} {
    global LB_BASE_ADDR2

    puts "Writing $value to Local Loopback 2\n"
    wr32 $LB_BASE_ADDR2 0x8 0x0 $value
}

proc write_10gbaser_loopback {value} {
	global PMA_BASE_ADDR
	global ALT_PMA_CH_CONTROLLER_BASE_ADDR

	puts "set 10Gbase_r loopback"
	wr32 $PMA_BASE_ADDR $ALT_PMA_CH_CONTROLLER_BASE_ADDR 0x04 $value

	read_xaui_pcs
	read_xaui_reset_controller
	read_xaui_pma_controller
	read_xaui_pma_ch_controller
}

#==============================================================================
#                       APIs for PCS              
#==============================================================================

# Accessing PMA Controller
proc read_xaui_pma_controller {} {
    global PMA_BASE_ADDR
    global ALT_PMA_CONTROLLER_BASE_ADDR
    
    puts "Reading all registers of PMA Common Controller\n"
    for {set AddressOffset $ALT_PMA_CONTROLLER_BASE_ADDR} {$AddressOffset <= [expr $ALT_PMA_CONTROLLER_BASE_ADDR + 0x24]} {incr AddressOffset 0x4} {
        set address_hex [format "%#x" $AddressOffset];
        puts "Read Address Offset $address_hex : [rd32 $PMA_BASE_ADDR $address_hex 0x0]\n"
    }
}

# Accessing PMA Controller
proc read_xaui_reset_controller {} {
    global PMA_BASE_ADDR
    global ALT_PMA_RESET_BASE_ADDR
    
    puts "Reading all registers of PMA reset Controller\n"
    for {set AddressOffset $ALT_PMA_RESET_BASE_ADDR} {$AddressOffset <= [expr $ALT_PMA_RESET_BASE_ADDR + 0x24]} {incr AddressOffset 0x4} {
        set address_hex [format "%#x" $AddressOffset];
        puts "Read Address Offset $address_hex : [rd32 $PMA_BASE_ADDR $address_hex 0x0]\n"
	}
}

# Accessing PMA Channel Controller
proc read_xaui_pma_ch_controller {} {
    global PMA_BASE_ADDR
    global ALT_PMA_CH_CONTROLLER_BASE_ADDR
    
    puts "Reading all registers of PMA Channel Controller\n"
    for {set AddressOffset $ALT_PMA_CH_CONTROLLER_BASE_ADDR} {$AddressOffset <= [expr $ALT_PMA_CH_CONTROLLER_BASE_ADDR + 0x24]} {incr AddressOffset 0x4} {
        set address_hex [format "%#x" $AddressOffset];
        puts "Read Address Offset $address_hex : [rd32 $PMA_BASE_ADDR $address_hex 0x0]\n"
    }
}

# Accessing PCS                
proc read_xaui_pcs {} {
    global PCS_BASE_ADDR
    global ALT_PCS_BASE_ADDR

    puts "Reading from PCS\n"
    for {set AddressOffset $ALT_PCS_BASE_ADDR} {$AddressOffset <= [expr $ALT_PCS_BASE_ADDR + 0x24]} {incr AddressOffset 0x4} {
        set address_hex [format "%#x" $AddressOffset];
        puts "Read Address Offset $address_hex : [rd32 $PCS_BASE_ADDR $address_hex 0x0]\n"
    }
}

#==============================================================================
#                       APIs for MDIO              
#==============================================================================

# Example: Accessing PHY XS control register as specified in Clause45
proc access_mdio {address} {
    global MDIO_BASE_ADDR

    # Clause45 = csr_address[5] 
    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80

    #==============================================================================
    # Writing to dev_prt_phy_address register (16 bits) of address 0x80 (0x20 on the slave)
    #    Bit [4:0] : phydev_address = clause 22 PHYAD / clause 45 DEVAD (device address)
    #    Bit [12:8] : prt_address = clause 45 PRTAD (for HSMC X2 daughter card, the value is define by the dip switch on the board) 
    #    Bit [31:16] : c1ause 45 register address (refer to IEEE 802.1 clause 45 for description)
    #==============================================================================
    set mdio_reg_value [expr ($address << 16)|0x0001]
	#puts "new value = [format "%#x" $mdio_reg_value]\n"
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing [format "%#x" $mdio_reg_value] to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    #puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"

	set ret_val [rd32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0]
    puts "Read PMA/PMD control register $mdio_rw_addr = [format "%#x" $ret_val]\n"
	return $ret_val
	puts "----------------------------------------"
}

proc write_mdio {address value} {
    global MDIO_BASE_ADDR

    # Clause45 = csr_address[5] 
    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80

    #==============================================================================
    # Writing to dev_prt_phy_address register (16 bits) of address 0x80 (0x20 on the slave)
    #    Bit [4:0] : phydev_address = clause 22 PHYAD / clause 45 DEVAD (device address)
    #    Bit [12:8] : prt_address = clause 45 PRTAD (for HSMC X2 daughter card, the value is define by the dip switch on the board) 
    #    Bit [31:16] : c1ause 45 register address (refer to IEEE 802.1 clause 45 for description)
    #==============================================================================

    # Example : Read from PHY XS control register (device address 1, cl45 register address 0) 
    set mdio_reg_value [expr ($address << 16)|0x0001]
	set mdio_write_value $value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing [format "%#x" $mdio_reg_value] to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing [format "%#x" $mdio_write_value] to $mdio_rw_addr\n"
    wr32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0 $mdio_write_value

	puts "----------------------------------------"
}

proc wait_on_reset {} {
	global MDIO_BASE_ADDR
	
    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80
	
    set mdio_reg_value 0x00000001
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing [format "%#x" $mdio_reg_value] to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
	while {[expr ([expr [rd32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0]|0x8000]) >> 16] > 0} {
		after 50
	}
	puts "------------------------------------------"
}

proc set_pma_loopback {} {
    global MDIO_BASE_ADDR

    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80

    set mdio_reg_value 0x00000001
	set mdio_write_value 0x00002041
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing $mdio_reg_value to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing $mdio_write_value to $mdio_rw_addr\n"
    wr32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0 $mdio_write_value

}

proc check_pma_status {} {
    global MDIO_BASE_ADDR

    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80

    # Example : Read from PMA/PMD control register (device address 1, cl45 register address 0) 
    set mdio_reg_value 0x00010001
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing $mdio_reg_value to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Read PMA/PMD control register $mdio_rw_addr = [rd32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0]\n"
}

proc access_rx_los {} {
    global MDIO_BASE_ADDR

    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80

    # Write 1.D160.3:0 --> 0101 
    set mdio_reg_value 0xD1600001
	set mdio_write_value 0x0000101
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing $mdio_reg_value to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Read PMA/PMD control register $mdio_rw_addr = [rd32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0]\n"
    puts "Writing $mdio_write_value to $mdio_rw_addr\n"
    wr32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0 $mdio_write_value

	puts "------------------"

	# Write 1.C002.13:12 --> 0 , unmask RX1_LOS_L and RX2_LOS_L
    set mdio_reg_value 0xC0020001
	set mdio_write_value 0x0000CFFF
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing $mdio_reg_value to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Read PMA/PMD control register $mdio_rw_addr = [rd32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0]\n"
    puts "Writing $mdio_write_value to $mdio_rw_addr\n"
    wr32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0 $mdio_write_value

	puts "------------------"
	# Read RX1_LOS_L
    set mdio_reg_value 0xC0010001
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing $mdio_reg_value to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Read PMA/PMD control register $mdio_rw_addr = [rd32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0]\n"

	puts "------------------"
	# Read RX2_LOS_L
    set mdio_reg_value 0xC0010001
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Writing $mdio_reg_value to $mdio_csr_addr_cl45\n"
    wr32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0 $mdio_reg_value
    puts "Read dev_prt_phy_add register $mdio_csr_addr_cl45 = [rd32 $MDIO_BASE_ADDR $mdio_csr_addr_cl45 0x0]\n"
    puts "Read PMA/PMD control register $mdio_rw_addr = [rd32 $MDIO_BASE_ADDR $mdio_rw_addr 0x0]\n"
	puts "------------------"
}

proc BIT {shift} {
	set val 1<<($shift)
	return [expr $val]
}

proc set_bit {value shift} {
	set new_val [expr $value|[BIT $shift]]
	#puts "new value = [format "%#x" $new_val]\n"
	return [expr $new_val]
}

proc clear_bit {value shift} {
	set new_val [expr $value&~[BIT $shift]] 
	#puts "new value = [format "%#x" $new_val]\n"
	return [expr $new_val]
}

#==============================================================================
#                       APIs for RX FIFO              
#==============================================================================
proc set_fifo_drop_on_error1 {value} {
    global RX_SC_FIFO_BASE_ADDR

    puts "Writing $value to drop on error register of RX FIFO 1\n"
    wr32 $RX_SC_FIFO_BASE_ADDR 0x14 0x0 $value
}

proc set_fifo_drop_on_error2 {value} {
    global RX_SC_FIFO_BASE_ADDR2

    puts "Writing $value to drop on error register of RX FIFO 2\n"
    wr32 $RX_SC_FIFO_BASE_ADDR2 0x14 0x0 $value
}

#==============================================================================
#                       APIs for MAC              
#==============================================================================
# Read all registers of address inserter
proc read_address_inserter1 {} {
    global MAC_BASE_ADDR
    global ADDRESS_INSERTER_BASE_ADDR
    global add_inserter

    puts "=============================================================================="
    puts "                      Reading Address Inserter CSR			        "
    puts "==============================================================================\n\n"
    puts "control status : [rd32 $MAC_BASE_ADDR $ADDRESS_INSERTER_BASE_ADDR 0x0]\n"
    puts "MAC1 src addr 0 : [rd32 $MAC_BASE_ADDR $ADDRESS_INSERTER_BASE_ADDR 0x4]\n"
    puts "MAC1 src addr 1 : [rd32 $MAC_BASE_ADDR $ADDRESS_INSERTER_BASE_ADDR 0x8]\n"
}

proc read_address_inserter2 {} {
    global MAC_BASE_ADDR2
    global ADDRESS_INSERTER_BASE_ADDR
    global add_inserter

    puts "=============================================================================="
    puts "                      Reading Address Inserter CSR			        "
    puts "==============================================================================\n\n"
    puts "control status : [rd32 $MAC_BASE_ADDR2 $ADDRESS_INSERTER_BASE_ADDR 0x0]\n"
    puts "MAC2 src addr 0 : [rd32 $MAC_BASE_ADDR2 $ADDRESS_INSERTER_BASE_ADDR 0x4]\n"
    puts "MAC2 src addr 1 : [rd32 $MAC_BASE_ADDR2 $ADDRESS_INSERTER_BASE_ADDR 0x8]\n"
}

# Write to MAC source address register with the given value
proc write_MAC_src_address1 {value} {
    global MAC_BASE_ADDR
    global ADDRESS_INSERTER_BASE_ADDR

    puts "=============================================================================="
    puts "                      Write MAC Source Address 1 to Address Inserter 		"
    puts "==============================================================================\n\n"
    set offset 0x4
    set lowerMAC 0x[string range $value 6 13]
    puts "Write to offset $offset of Address Inserter with value of $lowerMAC\n"
    wr32 $MAC_BASE_ADDR $ADDRESS_INSERTER_BASE_ADDR $offset $lowerMAC

    set offset 0x8
    set higherMAC [string range $value 0 5]
    puts "Write to offset $offset of Address Inserter with value of $higherMAC\n"
    wr32 $MAC_BASE_ADDR $ADDRESS_INSERTER_BASE_ADDR $offset $higherMAC
}

# Write to MAC source address register with the given value
proc write_MAC_src_address2 {value} {
    global MAC_BASE_ADDR2
    global ADDRESS_INSERTER_BASE_ADDR

    puts "=============================================================================="
    puts "                      Write MAC Source Address 2 to Address Inserter 		"
    puts "==============================================================================\n\n"
    set offset 0x4
    set lowerMAC 0x[string range $value 6 13]
    puts "Write to offset $offset of Address Inserter with value of $lowerMAC\n"
    wr32 $MAC_BASE_ADDR2 $ADDRESS_INSERTER_BASE_ADDR $offset $lowerMAC

    set offset 0x8
    set higherMAC [string range $value 0 5]
    puts "Write to offset $offset of Address Inserter with value of $higherMAC\n"
    wr32 $MAC_BASE_ADDR2 $ADDRESS_INSERTER_BASE_ADDR $offset $higherMAC
}

proc set_address_inserter1 {value} {
    global MAC_BASE_ADDR
    global ADDRESS_INSERTER_BASE_ADDR
    set offset 0x0

    puts "=============================================================================="
    puts "                      Write to Control register of Address Inserter 1 	        "
    puts "==============================================================================\n\n"
    puts "Write to offset $offset of Address inserter with value of $value\n"
    wr32 $MAC_BASE_ADDR $ADDRESS_INSERTER_BASE_ADDR $offset $value
}

proc set_address_inserter2 {value} {
	global MAC_BASE_ADDR2
	global ADDRESS_INSERTER_BASE_ADDR
	set offset 0x0

	puts "=============================================================================="
	puts "                      Write to Control register of Address Inserter 2 	        "
	puts "==============================================================================\n\n"
	puts "Write to offset $offset of Address inserter with value of $value\n"
	wr32 $MAC_BASE_ADDR2 $ADDRESS_INSERTER_BASE_ADDR $offset $value
}

proc read_mac_control {} {
	global MAC_BASE_ADDR
	
    set base_address 0x0
    set read_error 0x0

	puts "=============================================================================="
	puts "                      Read MAC control register					            "
	puts "==============================================================================\n\n"
	
	puts "rx_transfer_control: [rd32 $MAC_BASE_ADDR $base_address 0x00]\n"	
	puts "rx_transfer_status: [rd32 $MAC_BASE_ADDR $base_address 0x04]\n"	
	puts "rx_padcrc_control: [rd32 $MAC_BASE_ADDR $base_address 0x10]\n"	
	puts "rx_padcrc_control: [rd32 $MAC_BASE_ADDR $base_address 0x10]\n"	
	puts "rx_crccheck_control: [rd32 $MAC_BASE_ADDR $base_address 0x20]\n"	
	puts "rx_frame_control: [rd32 $MAC_BASE_ADDR $base_address 0x100]\n"	
	puts "rx_frame_maxlen: [rd32 $MAC_BASE_ADDR $base_address 0x104]\n"	
	puts "rx_frame_addr0: [rd32 $MAC_BASE_ADDR $base_address 0x108]\n"	
	puts "rx_frame_addr1: [rd32 $MAC_BASE_ADDR $base_address 0x10C]\n"	

}

# Read all statistics registers of the given path (rx or tx)
proc read_stats1 {path} {
    global MAC_BASE_ADDR
    global TX_STATISTICS_BASE_ADDR
    global RX_STATISTICS_BASE_ADDR

    set base_address 0x0
    set read_error 0x0
    
    if {$path ==  "tx"} {
        puts "=============================================================================="
        puts "                      Reading TX Statistics			            "
        puts "==============================================================================\n\n"
        set base_address $TX_STATISTICS_BASE_ADDR
    } elseif {$path == "rx"} {
        puts "=============================================================================="
        puts "                      Reading RX Statistics			            "
        puts "==============================================================================\n\n"
        set base_address $RX_STATISTICS_BASE_ADDR
    } else {
        puts "Wrong argument for read_stats\n"
        set read_error 0x1
    }

    if {$read_error == 0x0} {
        puts "clr : [rd32 $MAC_BASE_ADDR $base_address 0x00]\n"
        puts "framesOK : [rd64 $MAC_BASE_ADDR $base_address 0x08]\n"
        puts "framesErr : [rd64 $MAC_BASE_ADDR $base_address 0x10]\n"
        puts "framesCRCErr : [rd64 $MAC_BASE_ADDR $base_address 0x18]\n"
        puts "octetsOK : [rd64 $MAC_BASE_ADDR $base_address 0x20]\n"
        puts "pauseMACCtrlFrames : [rd64 $MAC_BASE_ADDR $base_address 0x28]\n"
        puts "ifErrors : [rd64 $MAC_BASE_ADDR $base_address 0x30]\n"
        puts "unicastFramesOK : [rd64 $MAC_BASE_ADDR $base_address 0x38]\n"
        puts "unicastFramesErr : [rd64 $MAC_BASE_ADDR $base_address 0x40]\n"
        puts "multicastFramesOK : [rd64 $MAC_BASE_ADDR $base_address 0x48]\n"
        puts "multicastFramesErr : [rd64 $MAC_BASE_ADDR $base_address 0x50]\n"
        puts "broadcastFramesOK : [rd64 $MAC_BASE_ADDR $base_address 0x58]\n"
        puts "broadcastFramesErr : [rd64 $MAC_BASE_ADDR $base_address 0x60]\n"
        puts "etherStatsOctets : [rd64 $MAC_BASE_ADDR $base_address 0x68]\n"
        puts "etherStatsPkts : [rd64 $MAC_BASE_ADDR $base_address 0x70]\n"
        puts "etherStatsUnderSizePkts : [rd64 $MAC_BASE_ADDR $base_address 0x78]\n"
        puts "etherStatsOversizePkts : [rd64 $MAC_BASE_ADDR $base_address 0x80]\n"
        puts "etherStatsPkts64Octets : [rd64 $MAC_BASE_ADDR $base_address 0x88]\n"
        puts "etherStatsPkts65to127Octets : [rd64 $MAC_BASE_ADDR $base_address 0x90]\n"
        puts "etherStatsPkts128to255Octets : [rd64 $MAC_BASE_ADDR $base_address 0x98]\n"
        puts "etherStatsPkts256to511Octet : [rd64 $MAC_BASE_ADDR $base_address 0xA0]\n"
        puts "etherStatsPkts512to1023Octets : [rd64 $MAC_BASE_ADDR $base_address 0xA8]\n"
        puts "etherStatsPkts1024to1518Octets : [rd64 $MAC_BASE_ADDR $base_address 0xB0]\n"
        puts "etherStatsPkts1518toXOctets : [rd64 $MAC_BASE_ADDR $base_address 0xB8]\n"
        puts "etherStatsFragments : [rd64 $MAC_BASE_ADDR $base_address 0xC0]\n"
        puts "etherStatsJabbers : [rd64 $MAC_BASE_ADDR $base_address 0xC8]\n"
        puts "etherStatsCRCErr : [rd64 $MAC_BASE_ADDR $base_address 0xD0]\n"
        puts "unicastMACCtrlFrames : [rd64 $MAC_BASE_ADDR $base_address 0xD8]\n"
        puts "multicastMACCtrlFrames : [rd64 $MAC_BASE_ADDR $base_address 0xE0]\n"
        puts "broadcastMACCtrlFrames : [rd64 $MAC_BASE_ADDR $base_address 0xE8]\n" 
   }      
}

# Read all statistics registers of the given path (rx or tx)
proc read_stats2 {path} {
    global MAC_BASE_ADDR2
    global TX_STATISTICS_BASE_ADDR
    global RX_STATISTICS_BASE_ADDR

    set base_address 0x0
    set read_error 0x0
    
    if {$path ==  "tx"} {
        puts "=============================================================================="
        puts "                      Reading TX Statistics 2			            "
        puts "==============================================================================\n\n"
        set base_address $TX_STATISTICS_BASE_ADDR
    } elseif {$path == "rx"} {
        puts "=============================================================================="
        puts "                      Reading RX Statistics 2			            "
        puts "==============================================================================\n\n"
        set base_address $RX_STATISTICS_BASE_ADDR
    } else {
        puts "Wrong argument for read_stats\n"
        set read_error 0x1
    }

    if {$read_error == 0x0} {
        puts "clr : [rd32 $MAC_BASE_ADDR2 $base_address 0x00]\n"
        puts "framesOK : [rd64 $MAC_BASE_ADDR2 $base_address 0x08]\n"
        puts "framesErr : [rd64 $MAC_BASE_ADDR2 $base_address 0x10]\n"
        puts "framesCRCErr : [rd64 $MAC_BASE_ADDR2 $base_address 0x18]\n"
        puts "octetsOK : [rd64 $MAC_BASE_ADDR2 $base_address 0x20]\n"
        puts "pauseMACCtrlFrames : [rd64 $MAC_BASE_ADDR2 $base_address 0x28]\n"
        puts "ifErrors : [rd64 $MAC_BASE_ADDR2 $base_address 0x30]\n"
        puts "unicastFramesOK : [rd64 $MAC_BASE_ADDR2 $base_address 0x38]\n"
        puts "unicastFramesErr : [rd64 $MAC_BASE_ADDR2 $base_address 0x40]\n"
        puts "multicastFramesOK : [rd64 $MAC_BASE_ADDR2 $base_address 0x48]\n"
        puts "multicastFramesErr : [rd64 $MAC_BASE_ADDR2 $base_address 0x50]\n"
        puts "broadcastFramesOK : [rd64 $MAC_BASE_ADDR2 $base_address 0x58]\n"
        puts "broadcastFramesErr : [rd64 $MAC_BASE_ADDR2 $base_address 0x60]\n"
        puts "etherStatsOctets : [rd64 $MAC_BASE_ADDR2 $base_address 0x68]\n"
        puts "etherStatsPkts : [rd64 $MAC_BASE_ADDR2 $base_address 0x70]\n"
        puts "etherStatsUnderSizePkts : [rd64 $MAC_BASE_ADDR2 $base_address 0x78]\n"
        puts "etherStatsOversizePkts : [rd64 $MAC_BASE_ADDR2 $base_address 0x80]\n"
        puts "etherStatsPkts64Octets : [rd64 $MAC_BASE_ADDR2 $base_address 0x88]\n"
        puts "etherStatsPkts65to127Octets : [rd64 $MAC_BASE_ADDR2 $base_address 0x90]\n"
        puts "etherStatsPkts128to255Octets : [rd64 $MAC_BASE_ADDR2 $base_address 0x98]\n"
        puts "etherStatsPkts256to511Octet : [rd64 $MAC_BASE_ADDR2 $base_address 0xA0]\n"
        puts "etherStatsPkts512to1023Octets : [rd64 $MAC_BASE_ADDR2 $base_address 0xA8]\n"
        puts "etherStatsPkts1024to1518Octets : [rd64 $MAC_BASE_ADDR2 $base_address 0xB0]\n"
        puts "etherStatsPkts1518toXOctets : [rd64 $MAC_BASE_ADDR2 $base_address 0xB8]\n"
        puts "etherStatsFragments : [rd64 $MAC_BASE_ADDR2 $base_address 0xC0]\n"
        puts "etherStatsJabbers : [rd64 $MAC_BASE_ADDR2 $base_address 0xC8]\n"
        puts "etherStatsCRCErr : [rd64 $MAC_BASE_ADDR2 $base_address 0xD0]\n"
        puts "unicastMACCtrlFrames : [rd64 $MAC_BASE_ADDR2 $base_address 0xD8]\n"
        puts "multicastMACCtrlFrames : [rd64 $MAC_BASE_ADDR2 $base_address 0xE0]\n"
        puts "broadcastMACCtrlFrames : [rd64 $MAC_BASE_ADDR2 $base_address 0xE8]\n" 
   }      
}

# Clear all statistics registers both on the TX and on the RX path
proc clear_stats {} {
    global MAC_BASE_ADDR
    global MAC_BASE_ADDR2
    global MacStatistics
    global RX_STATISTICS_BASE_ADDR
    global TX_STATISTICS_BASE_ADDR

    puts "Clear RX statistics registers\n"
    wr32 $MAC_BASE_ADDR $RX_STATISTICS_BASE_ADDR 0x0 0x1
    wr32 $MAC_BASE_ADDR2 $RX_STATISTICS_BASE_ADDR 0x0 0x1
    
    puts "Clear TX statistics registers\n"
    wr32 $MAC_BASE_ADDR $TX_STATISTICS_BASE_ADDR 0x0 0x1
    wr32 $MAC_BASE_ADDR2 $TX_STATISTICS_BASE_ADDR 0x0 0x1

}
    
#  Configure Packet Generator 
proc config_pkt_gen1 {} {
	global PKT_GEN_BASE_ADDR

    puts "=============================================================================="
    puts "                      Write to Control register of Packet Generator  	        "
    puts "==============================================================================\n\n"
	
	puts "Write Seed A, B, C"
	wr32 $PKT_GEN_BASE_ADDR 0x30 0x0 0x8912C983
	wr32 $PKT_GEN_BASE_ADDR 0x34 0x0 0x3B97DA93
	wr32 $PKT_GEN_BASE_ADDR 0x38 0x0 0x091E5894

	puts "Write Number of Packet to transmit"
	#mod size
	wr32 $PKT_GEN_BASE_ADDR 0x0 0x0 0xFFFF
	
	puts "Config (packet size, payload type)"
	wr32 $PKT_GEN_BASE_ADDR 0x4 0x0 0x00008080

	puts "Source Address"
	wr32 $PKT_GEN_BASE_ADDR 0x10 0x0 0x00C28001
	wr32 $PKT_GEN_BASE_ADDR 0x14 0x0 0x00002010

	puts "Dest Address"
	wr32 $PKT_GEN_BASE_ADDR 0x18 0x0 0x88CCAAFF
	wr32 $PKT_GEN_BASE_ADDR 0x1C 0x0 0x0000EECC

	#mod MAC
	#wr32 $PKT_GEN_BASE_ADDR 0x18 0x0 0xdd459b1D
	#wr32 $PKT_GEN_BASE_ADDR 0x1C 0x0 0x00000060
}

#  Configure Packet Generator 
proc config_pkt_gen2 {} {
	global PKT_GEN_BASE_ADDR2

    puts "=============================================================================="
    puts "                      Write to Control register of Packet Generator  	        "
    puts "==============================================================================\n\n"
	
	puts "Write Seed A, B, C"
	wr32 $PKT_GEN_BASE_ADDR2 0x30 0x0 0x8912C983
	wr32 $PKT_GEN_BASE_ADDR2 0x34 0x0 0x3B97DA93
	wr32 $PKT_GEN_BASE_ADDR2 0x38 0x0 0x091E5894

	puts "Write Number of Packet to transmit"
	wr32 $PKT_GEN_BASE_ADDR2 0x0 0x0 0xFF
	
	puts "Config (packet size, payload type)"
	#wr32 $PKT_GEN_BASE_ADDR 0x4 0x0 0x00008080
	wr32 $PKT_GEN_BASE_ADDR2 0x4 0x0 0x00000223

	puts "Source Address"
	wr32 $PKT_GEN_BASE_ADDR2 0x10 0x0 0x88CCAAFF
	wr32 $PKT_GEN_BASE_ADDR2 0x14 0x0 0x0000EECC

	puts "Dest Address"
	wr32 $PKT_GEN_BASE_ADDR2 0x18 0x0 0x88CCAAFF
	wr32 $PKT_GEN_BASE_ADDR2 0x1C 0x0 0x0000EECC
}

# configure packet monitor
proc config_pkt_mon1 {} {
	global PKT_MON_BASE_ADDR

    puts "=============================================================================="
    puts "                      Write to Control register of Packet Monitor  	        "
    puts "==============================================================================\n\n"

	puts "Expected RX count"
	wr32 $PKT_MON_BASE_ADDR 0x0 0x0 0xFFFF
}

# configure packet monitor
proc config_pkt_mon2 {} {
	global PKT_MON_BASE_ADDR2

    puts "=============================================================================="
    puts "                      Write to Control register of Packet Monitor  	        "
    puts "==============================================================================\n\n"

	puts "Expected RX count"
	wr32 $PKT_MON_BASE_ADDR2 0x0 0x0 0xFF
}

proc pkt_mon_test {} {

	global PKT_MON_BASE_ADDR

    puts "=============================================================================="
    puts "                      Start pakcet generator and monitor  	        "
    puts "==============================================================================\n\n"

	puts "\n - Number of Received Correct Frames : [rd32 $PKT_MON_BASE_ADDR 0x4 0x0]"
	puts "\n - Number of Received Frames with Error: [rd32 $PKT_MON_BASE_ADDR 0x8 0x0]"
	puts "\n - number of packet: [rd32 $PKT_MON_BASE_ADDR 0x00 0x0]"
	puts "\n - packet rx ok: [rd32 $PKT_MON_BASE_ADDR 0x04 0x0]"
	puts "\n - packet rx error: [rd32 $PKT_MON_BASE_ADDR 0x08 0x0]"
	puts "\n - byte rx count0: [rd32 $PKT_MON_BASE_ADDR 0x0C 0x0]"
	puts "\n - byte rx count1: [rd32 $PKT_MON_BASE_ADDR 0x10 0x0]"
	puts "\n - cycle rx count0: [rd32 $PKT_MON_BASE_ADDR 0x14 0x0]"
	puts "\n - cycle rx count1: [rd32 $PKT_MON_BASE_ADDR 0x18 0x0]"
	puts "\n - Received status: [rd32 $PKT_MON_BASE_ADDR 0x1C 0x0]"
}

proc pkt_mon_test2 {} {

	global PKT_MON_BASE_ADDR2

    puts "=============================================================================="
    puts "                      Start pakcet generator and monitor  	        "
    puts "==============================================================================\n\n"

	puts "\n - Number of Received Correct Frames : [rd32 $PKT_MON_BASE_ADDR2 0x4 0x0]"
	puts "\n - Number of Received Frames with Error: [rd32 $PKT_MON_BASE_ADDR2 0x8 0x0]"
	puts "\n - number of packet: [rd32 $PKT_MON_BASE_ADDR2 0x00 0x0]"
	puts "\n - packet rx ok: [rd32 $PKT_MON_BASE_ADDR2 0x04 0x0]"
	puts "\n - packet rx error: [rd32 $PKT_MON_BASE_ADDR2 0x08 0x0]"
	puts "\n - byte rx count0: [rd32 $PKT_MON_BASE_ADDR2 0x0C 0x0]"
	puts "\n - byte rx count1: [rd32 $PKT_MON_BASE_ADDR2 0x10 0x0]"
	puts "\n - cycle rx count0: [rd32 $PKT_MON_BASE_ADDR2 0x14 0x0]"
	puts "\n - cycle rx count1: [rd32 $PKT_MON_BASE_ADDR2 0x18 0x0]"
	puts "\n - Received status: [rd32 $PKT_MON_BASE_ADDR2 0x1C 0x0]"
	
}

proc start_10gbaser_loopback_test {} {
	global PKT_MON_BASE_ADDR
	global PKT_GEN_BASE_ADDR

    puts "=============================================================================="
    puts "                      Start pakcet generator and monitor  	        "
    puts "==============================================================================\n\n"

	write_10gbaser_loopback 1

	wr32 $PKT_MON_BASE_ADDR 0x1C 0x0 1
	wr32 $PKT_GEN_BASE_ADDR 0x08 0x0 1

	puts "Polling Packet Monitor Status until done or error ..." 
	puts "\n This will take some time ... \n"
	
	set regvalue [rd32 $PKT_MON_BASE_ADDR 0x1C 0x0]

#	while {$regvalue&0x04 == 0} {
#		after 100
#		set regvalue [rd32 $PKT_MON_BASE_ADDR 0x1C 0x0]
#	}

	after 2000	

	puts "\n - Number of Transmitted Correct Frames : [rd32 $PKT_GEN_BASE_ADDR 0x24 0x0]"
	puts "\n - Number of Received Correct Frames : [rd32 $PKT_MON_BASE_ADDR 0x4 0x0]"
	puts "\n - Number of Received Frames with Error: [rd32 $PKT_MON_BASE_ADDR 0x8 0x0]"
	puts "\n - Received status: [rd32 $PKT_MON_BASE_ADDR 0x1C 0x0]"
	
	pkt_mon_test
	write_10gbaser_loopback 0
	after 100
}

proc start_netlogic_loopback_test {} {
	global PKT_MON_BASE_ADDR2
	global PKT_GEN_BASE_ADDR

    puts "=============================================================================="
    puts "                      Start pakcet generator and monitor  	        "
    puts "==============================================================================\n\n"

	wr32 $PKT_MON_BASE_ADDR2 0x1C 0x0 1
	wr32 $PKT_GEN_BASE_ADDR 0x08 0x0 1

	puts "Polling Packet Monitor Status until done or error ..." 
	puts "\n This will take some time ... \n"
	
	after 2000	
	set regvalue [rd32 $PKT_MON_BASE_ADDR2 0x1C 0x0]

	puts "\n - Number of Transmitted Correct Frames : [rd32 $PKT_GEN_BASE_ADDR 0x24 0x0]"
	puts "\n - Number of Received Correct Frames : [rd32 $PKT_MON_BASE_ADDR2 0x4 0x0]"
	puts "\n - Number of Received Frames with Error: [rd32 $PKT_MON_BASE_ADDR2 0x8 0x0]"
	puts "\n - Received status: [rd32 $PKT_MON_BASE_ADDR2 0x1C 0x0]"
	
	pkt_mon_test2
	after 100
}


proc ext_xcvr_off {} {
	global EXT_XCVR_BASE_ADDR
	
    puts "=============================================================================="
    puts "                      External XCVR control registers write 	        "
    puts "==============================================================================\n\n"
	
	set regvalue 0x0000007E
	wr32 $EXT_XCVR_BASE_ADDR 0x0 0x4 $regvalue
	puts "Set xcvr control register to: [rd32 $EXT_XCVR_BASE_ADDR 0x0 0x4]"
}

proc ext_xcvr_on {} {
	global EXT_XCVR_BASE_ADDR
	
    puts "=============================================================================="
    puts "                      External XCVR control registers write 	        "
    puts "==============================================================================\n\n"
	
	set regvalue 0x00000007
	wr32 $EXT_XCVR_BASE_ADDR 0x0 0x4 $regvalue
	puts "Set xcvr control register to: [rd32 $EXT_XCVR_BASE_ADDR 0x0 0x4]"
}

proc ext_xcvr_reset {} {
	global EXT_XCVR_BASE_ADDR
	
    puts "=============================================================================="
    puts "                      External XCVR control registers write 	        "
    puts "==============================================================================\n\n"
	
	#Set SFP2_RSEL, SFP1_RSEL, and PHY_RESET_N
	set regvalue 0x0000007E
	wr32 $EXT_XCVR_BASE_ADDR 0x0 0x4 $regvalue
	ext_xcvr_read

	after 400

	set regvalue 0x00000007
	wr32 $EXT_XCVR_BASE_ADDR 0x0 0x4 $regvalue
#	puts "Set xcvr control register to: [rd32 $EXT_CTRL_BASE_ADDR 0x0 0x0]"
	ext_xcvr_read
	after 400
}

proc ext_xcvr_read {} {
	global EXT_XCVR_BASE_ADDR
	
    puts "=============================================================================="
    puts "                      External XCVR control registers read 	        "
    puts "==============================================================================\n\n"
	
	puts "Set xcvr control register to: [rd32 $EXT_XCVR_BASE_ADDR 0x0 0x4]"
}


