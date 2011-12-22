#
# SoNIC System Console Monitor
# NOTE: display SoNIC control register settings.
# 
#

#=======================================================
# source common.tcl
# source pma.tcl
#=======================================================
source common.tcl
source pma.tcl

#=======================================================
# port register map:
#  system registers are read-only.
# data_in_2: 0x20, monitor_out_0 [127:96]
# data_in_3: 0x30, monitor_out_0 [95:64]
# data_in_4: 0x40, monitor_out_0 [63:32]
# data_in_5: 0x50, monitor_out_0 [31:0]
# data_in_6: 0x60, monitor_out_1 [127:96]
# data_in_7: 0x70, monitor_out_1 [95:64]
# data_in_8: 0x80, monitor_out_1 [63:32]
# data_in_9: 0x90, monitor_out_1 [31:0]
#=======================================================

# ======================================================
# Bit Assignment:
# enable_sfp:   monitor_out_0[127]
# tx_ring_wptr: monitor_out_0[125:112]
# pma_tx_ready: monitor_out_0[111]
# pma_rx_ready: monitor_out_0[110]
# rx_ring_rptr: monitor_out_0[109:96]
# ======================================================

# ======================================================
# Monitor, much better than master_read_memory.
# Create a new monitor, 
# -- 
# set its callback, interval,
# -- monitor_set_callback (service-path, tcl-expression)
# -- monitor_set_interval (service-path, interval)
# -- monitor_get_interval (service-path)
# add ranges,
# -- monitor_add_range (service-path, target-path, address, size)
# set it to enabled.
# -- monitor_set_enabled (service-path, enabled/disabled)
# 
# -- monitor_read_data (service-path, target-path, address, size)
# -- monitor_read_all_data (service-path, target-path, address, size)
# -- monitor_get_read_interval (service-path, target-path, address, size)
# -- monitor_get_all_read_intervals (service-path, target-path, address, size)
# -- monitor_get_missing_event_count (service-path)
# within the callback, use read_data to get the data out
# ======================================================

global monitor_path

proc test {} {
    global monitor_path
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

    monitor_set_callback $monitor_path [list example_callback_proc $monitor_path $master_path]

    monitor_add_range $monitor_path $master_path 0x20 4
    monitor_add_range $monitor_path $master_path 0x60 4

    #TCL callback procedure for the monitor service
    proc example_callback_proc {monitor_path master_path} {
	set w1 [monitor_read_data $monitor_path $master_path 0x20 4]
	set w2 [monitor_read_data $monitor_path $master_path 0x60 4]
	set i1 [monitor_get_read_interval $monitor_path $master_path 0x20 4]
	set i2 [monitor_get_read_interval $monitor_path $master_path 0x60 4]
	set m1 [monitor_get_missing_event_count $monitor_path]
	puts "0x20-0x23: $w1 ($i1 ms)"
	puts "0x60-0x63: $w2 ($i2 ms) missed, $m1."
    }

    #
    # Activate the monitor service
    #

    monitor_set_enabled $monitor_path 1

}

proc exit_test {} {
    global monitor_path

    monitor_set_enabled $monitor_path 0
}


