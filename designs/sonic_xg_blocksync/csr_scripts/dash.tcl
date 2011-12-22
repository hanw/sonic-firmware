namespace eval dashboard_channel {
    # Create dashboard 
    variable dash [ add_service dashboard sonic_gui "Channel 0" "Tools/Channel 0"]
    variable monitor_path

    # Set dashboard properties
    dashboard_set_property $dash self visible true
    
    # Group0
    dashboard_add $dash my_grp0 group self
    dashboard_set_property $dash my_grp0 itemsPerRow 2
    dashboard_set_property $dash my_grp0 expandableX true
    dashboard_set_property $dash my_grp0 expandableY true
    dashboard_set_property $dash my_grp0 title "Channel 0"

    # Group1
    dashboard_add $dash my_grp1 group self
    dashboard_set_property $dash my_grp1 visible true
    dashboard_set_property $dash my_grp1 expandableX true
    dashboard_set_property $dash my_grp1 expandableY true
    dashboard_set_property $dash my_grp1 itemsPerRow 2
    dashboard_set_property $dash my_grp1 title "Channel 1"

    # Add widgets
    proc create_group { } {
	variable dash
	dashboard_add          $dash chan0_enable_sfp label my_grp0
	dashboard_set_property $dash chan0_enable_sfp text "Chan0 Enable SFP+"
	dashboard_add          $dash chan0_ena_sfp_val label my_grp0
	dashboard_set_property $dash chan0_ena_sfp_val text "0"
	
	dashboard_add          $dash chan0_pma_tx_rdy label my_grp0
	dashboard_set_property $dash chan0_pma_tx_rdy text "Chan0 PMA Tx Ready"
	dashboard_add          $dash chan0_pma_tx_rdy_val label my_grp0
	dashboard_set_property $dash chan0_pma_tx_rdy_val text "0"

	dashboard_add          $dash chan0_pma_rx_rdy label my_grp0
	dashboard_set_property $dash chan0_pma_rx_rdy text "Chan0 PMA Rx Ready"
	dashboard_add          $dash chan0_pma_rx_rdy_val label my_grp0
	dashboard_set_property $dash chan0_pma_rx_rdy_val text "0"

	dashboard_add          $dash chan0_tx_ring_wptr label my_grp0
	dashboard_set_property $dash chan0_tx_ring_wptr text "Chan0 Tx Ring Wptr"
	dashboard_add          $dash chan0_tx_ring_wptr_val label my_grp0
	dashboard_set_property $dash chan0_tx_ring_wptr_val text "0"

	dashboard_add          $dash chan0_rx_ring_rptr label my_grp0
	dashboard_set_property $dash chan0_rx_ring_rptr text "Chan0 Rx Ring Rptr"
	dashboard_add          $dash chan0_rx_ring_rptr_val label my_grp0
	dashboard_set_property $dash chan0_rx_ring_rptr_val text "0"
    }

    # Callback for channel 0 update
    proc chan0_update { ena_sfp pma_tx_rdy pma_rx_rdy tx_wptr rx_rptr  } {
	variable dash
	dashboard_set_property $dash chan0_ena_sfp_val text $ena_sfp
	dashboard_set_property $dash chan0_pma_tx_rdy_val text $pma_tx_rdy
	dashboard_set_property $dash chan0_pma_rx_rdy_val text $pma_rx_rdy
	dashboard_set_property $dash chan0_tx_ring_wptr_val text $tx_wptr
	dashboard_set_property $dash chan0_rx_ring_rptr_val text $rx_rptr
    } 

    # construct GUI
    create_group

}

#TCL callback procedure for the monitor service
proc chan0_callback_proc {monitor_path master_path} {
    set w1 [monitor_read_data $monitor_path $master_path 0x20 4]
    set w2 [monitor_read_data $monitor_path $master_path 0x60 4]
    set i1 [monitor_get_read_interval $monitor_path $master_path 0x20 4]
    set i2 [monitor_get_read_interval $monitor_path $master_path 0x60 4]
    set m1 [monitor_get_missing_event_count $monitor_path]

    #puts "0x20-0x23: $w1 ($i1 ms)"
    #puts "0x60-0x63: $w2 ($i2 ms) missed, $m1."
    set ena_sfp [expr ([lindex $w1 0] >> 7)]
    set tx_wptr [expr (([lindex $w1 0] << 8) & 0x3F) | ([lindex $w1 1])]
    set pma_tx_rdy [expr ([lindex $w1 2] >> 7)]
    set pma_rx_rdy [expr (([lindex $w1 2] >> 6) & 0x40)]
    set rx_rptr [expr (([lindex $w1 2] << 8) & 0x3F) | ([lindex $w1 3])]

    ::dashboard_channel::chan0_update $ena_sfp $pma_tx_rdy $pma_rx_rdy $tx_wptr $rx_rptr
}

# 
proc start_monitor { } {
    variable monitor_path
    #
    # Get monitor service
    #
    set service_path [get_service_paths monitor]

    #
    # Claim a monitor service
    #
    set monitor_path [claim_service monitor $service_path "my_lib" ""]

    # Assume there is one device and one master
    set master_path [lindex [get_service_paths master] 0]

    #
    # Define monitor service properties
    #
    monitor_set_interval $monitor_path 100

    monitor_set_callback $monitor_path [list chan0_callback_proc $monitor_path $master_path]

    monitor_add_range $monitor_path $master_path 0x20 4
    monitor_add_range $monitor_path $master_path 0x60 4

    #
    # Activate the monitor service
    #
    monitor_set_enabled $monitor_path 1
}

proc stop_monitor { } {
    variable monitor_path
    monitor_set_enabled $monitor_path 0
}
