#============================================================
# Design Address Map
# Avalon MM mapping for sonic_v1_11
#============================================================
set MDIO_BASE_ADDR		0x00000800
set EXT_XCVR_BASE_ADDR		0x00001000
set PMA_BASE_ADDR		0x00050000

#==============================================================================
#                       PMA Address Map                
#==============================================================================
set ALT_PMA_CONTROLLER_BASE_ADDR    0x00000080
set ALT_PMA_RESET_BASE_ADDR  	    0x00000100
set ALT_PMA_CH_CONTROLLER_BASE_ADDR 0x00000180

proc usage {} {
    puts "################################################################"
    puts "Usage: "
    puts "  0. Type 'usage' to repeat this message"
    puts "  1. Type 'source init' to load all debug routines"
    puts "  2. Type 'config' to set Netlogic to operating mode"
    puts "  3. Type 'lpbk 1' to set Netlogic PMA into loopback mode"
    puts "  4. Type 'lpbk 0' to unset Netlogic PMA from loopback mode"
    puts "  5. Type 'stats' to list the current status of the system"
    puts "################################################################"
}

proc config {} {
    source init_xcvr.tcl
}

proc lpbk {value} {

    open_jtag	
    if {$value == 1} {
	puts "Setting Netlogic PMA to loopback mode..."
	set_pma_loopback
	puts "Done!"
    } elseif {$value == 0} {
	puts "Unset Netlogic PMA loopback..."
	unset_pma_loopback
	puts "Done!"
    } else {
	puts "lpbk 0 or lpbk 1"
    }
    close_jtag
}

proc stats {} {
    global MDIO_BASE_ADDR
    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80
    open_jtag
    
    access_mdio 0
    access_mdio 1
    access_mdio 2

    close_jtag
}


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

proc unset_pma_loopback {} {
    global MDIO_BASE_ADDR

    set mdio_csr_addr_cl45 0x84
    set mdio_rw_addr 0x80

    set mdio_reg_value 0x00000001
    set mdio_write_value 0x00002040
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

#-----------------------------------------
# We have 16 custom ctrl port in total
# API
# IOWRITE32 
# E.g.: Write to a 32-bit user_datain_0 port
#   IOWR_32DIRECT(BASE, DATA_IN_0 * 4, 0XFFFFFFFF)
#  Another example: Read a 16-bit edge capture reg
#   IORD_16DIRECT(BASE, EDGE_CAPTURE_0 * 2)
# These are all word address
#  DATA_IN_0 = 0x00, DATA_OUT_0 = 0x01
#  DATA_IN_1 = 0x10, DATA_OUT_1 = 0x11
#
# To write to DATA_OUT_1:
# wr32 $BASE 0x0 0x44 $value
#-----------------------------------------
proc port_write {port_num value} {
    global EXT_XCVR_BASE_ADDR
    #Port data_out_1 is at 0x11, word address
    set addr [expr (((($port_num) << 4) + 1) * 4)]
    wr32 $EXT_XCVR_BASE_ADDR 0x0 $addr $value
    puts "port $port_num is 0x[format "%X" [port_read $port_num]]"
}

proc port_read {port_num} {
    global EXT_XCVR_BASE_ADDR
    
    #Port data_in_1 is at 0x10, word address
    set addr [expr (($port_num << 4) * 4)]
    set val [expr [rd32 $EXT_XCVR_BASE_ADDR 0x0 $addr]]
    return [expr $val]
}

proc set_pcie_operational {} {
    #set all compliance test control to zero
    port_write 1 0

    puts "test_out_icm read 0x[format "%X" [expr ([port_read 1] >> 2)]]"
}

proc compliance_test {} {
    global EXT_XCVR_BASE_ADDR
    
    puts "======================================================"
    puts "            PCI Express Compliance Test               "
    puts "======================================================"
    
    # cycle through test
    #set compliance mode
    port_write 1 0x3
    
    after 100
    #push req_compliance_push_button_n low
    port_write 1 0x1
    #wait for 100
    #push req_compliance_push_button_n high
    port_write 1 0x3
    after 500
    #read test_out
    set output [port_read 1]
    puts "Test output $output"
    
    after 100
    #push req_compliance_push_button_n low
    port_write 1 0x1
    #wait for 100
    #push req_compliance_push_button_n high
    port_write 1 0x3
    
    #read test_out
    set output [port_read 1]
    puts "Test output $output"
    
    #reset to normal mode
    port_write 1 0
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


