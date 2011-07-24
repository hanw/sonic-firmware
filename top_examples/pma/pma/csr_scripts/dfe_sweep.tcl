# This example script demonstrates the way to perform DFE Sweeping
# for Tap 1,2,3 value. The final DFE Tap value selected is with
# Lowest BER returned based on DFE Algorithm.
# If DFE flow is disabled, this script will only perform simple link test
# to show how the link is running for each interval elapsed time
# *****************************************************************
# Steps:
# 1. Take XCVR design's PMA setting and calculate BER
#    PMA settings included :
#                       Tx : VOD Control
#                            preemph1t
#                            preemph0t
#                            preemph2t
#                       Rx : DC Gain
# 2. Perform DFE Sweep based on the above PMA settings,
#    sweeping value included Equalizer, DFE Tap 1,2,3
# 3. Determine the lowest BER after enhancement from Equalizer and DFE
#
# Steps: without DFE sweeep [set enable_dfe 0]
# 1. Take XCVR design's PMA setting and calculate BER
# 2. print intermediate data to show how the link is perform

source link_test_lib.tcl

####################################################
# Customize the test variables
####################################################

# Device name to match the correct device in case of multiple devices
set device_die_name "EP4S.100"

# Relationship between transceiver channel RX and TX:
#   index 0 - Transceiver debug link service name: Loopback_Link_<$xcvr_instance_name>_address_<number>
#   index 1 - Transceiver channel TX service name: TX_<$xcvr_instance_name>_address_<number>
#   index 2 - Transceiver channel RX service name: RX_<$xcvr_instance_name>_address_<number>
set logical_link_pairs {{ "Loopback_Link_xcvr_low_latency_phy_0_address_0" "TX_xcvr_low_latency_phy_0_address_0" "RX_xcvr_low_latency_phy_0_address_0" 0} \
						{ "Loopback_Link_xcvr_low_latency_phy_0_address_1" "TX_xcvr_low_latency_phy_0_address_1" "RX_xcvr_low_latency_phy_0_address_1" 1} \
						{ "Loopback_Link_xcvr_low_latency_phy_0_address_2" "TX_xcvr_low_latency_phy_0_address_2" "RX_xcvr_low_latency_phy_0_address_2" 2} \
						{ "Loopback_Link_xcvr_low_latency_phy_0_address_3" "TX_xcvr_low_latency_phy_0_address_3" "RX_xcvr_low_latency_phy_0_address_3" 3} }

set xcvr_instance_name "xcvr"

# Generator preamble mode: 0 to disable, 1 to enable
set enable_preamble 0

# Generator preamble word, not used if preamble is disabled
set preamble_word 0x0

# Transceiver RX word aligner: 0 to disable, 1 to enable
set enable_word_aligner 0

# Set Transceiver's PRBS pattern for IP : Avalon-ST Data Pattern Generator
# Data pattern type: prbs7, prbs15, prbs23, prbs31
set data_pattern "prbs23"

# Transmitter and Receiver side analog value setting, by default based on design's Custom PHY block (link_test_sopc_sys.xcvr)
# SET user_define_analog_value to 1 if you would like to change manually Rx side analog setting
# Transceiver reconfig analog values
# VOD Control               (vodctrl)      - Valid Value = {0 1 2 3 4 5 6 7}
# Pre-emphasis 1st post-tap (preemph1t)    - Valid Value = {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31}
# Pre-emphasis Pre post-tap (preemph0t)    - Valid Value = {-15 -14 -13 -12 -11 -10 -9 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
# Pre-emphasis 2nd post-tap (preemph2t)    - Valid Value = {-15 -14 -13 -12 -11 -10 -9 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
# DC Gain                   (dc_gain)      - Valid Value = {0 1 2 3 4}
# Equalizer Control         (eq_ctrl_list) - Valid Value = {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
set user_define_analog_value 1
set vodctrl 4
set preemph1t 2
set preemph0t 1
set preemph2t 3
set dc_gain 1
set eq_ctrl_list {1 3}

# Enable Rx Channel DFE Sweeping
# For GT device, DFE is enabled for Data rate < 6.375Gbps, 
# DFE is disabled for this design because Data rate is 10.312Gbps
set enable_dfe 1

# DFE Tap 1, 2 & 3 Valid Value
# dfe_tap1_list - Valid Value = {0 1 2 3 4 5 6 7}
# dfe_tap2_list - Valid Value = {0 1 2 3 4 5 6 7}
# dfe_tap3_list - Valid Value = {0 1 2 3 4 5 6 7}
set dfe_tap1_list  {1 5}
set dfe_tap2_list  {2 3}
set dfe_tap3_list  {4 7}

set dfe_tap_list [list $dfe_tap1_list $dfe_tap2_list $dfe_tap3_list]
         
# Setup link run length
set max_run_time_in_seconds 10

# Use the current path as the QII project path
set design_filepath .


####################################################
# Initialize the design and device environment
####################################################

puts "\n\n--- Initialization ---\n\n"


# Setup design
design_load $design_filepath

# Assumes single design entry
if { [llength [get_service_paths design]] != 1 } {
	error "Incorrect number of designs available: expect only one, but found [llength [get_service_paths designs]]"
} else {
	set design_path [lindex [get_service_paths design] 0]
}

# Setup device
foreach device_name [get_service_paths device] {
	if { [regexp .*$device_die_name.* $device_name] } {
		set device_path $device_name
		break
	}
}

# Link design to the device
puts "Design: Path = $design_path"
puts "Device: Path = $device_path"
design_link $design_path $device_path


####################################################
# Link test
####################################################

# Not using internal loopback
disable_internal_loopback

# Loop every transceiver link
foreach logical_link_pair $logical_link_pairs {

	set debug_link         [lindex $logical_link_pair 0]
	set tx_logical_channel [lindex $logical_link_pair 1]
	set rx_logical_channel [lindex $logical_link_pair 2]
	set link_pair_count    [lindex $logical_link_pair 3]
	

	puts "\n\n--- DFE Sweep test for $debug_link between $tx_logical_channel and $rx_logical_channel ---\n\n"

	# Obtain the services path
	set transceiver_debug_link_path [lindex [get_service_paths "transceiver_debug_link"] $link_pair_count]
	set transceiver_channel_tx_path [lindex [get_service_paths "transceiver_channel_tx"] $link_pair_count]
	set transceiver_channel_rx_path [lindex [get_service_paths "transceiver_channel_rx"] $link_pair_count]
	set alt_xcvr_path               [get_service_path_by_instance_name "alt_xcvr_custom" $xcvr_instance_name]
        set transceiver_channel_path_list [ list $transceiver_channel_tx_path $transceiver_channel_rx_path $transceiver_debug_link_path ]

        # To enable serial loopback
	open_service alt_xcvr_custom $alt_xcvr_path
        alt_xcvr_custom_set_serial_loopback_enabled $alt_xcvr_path enabled

	# Open services and setup components
	open_service transceiver_debug_link $transceiver_debug_link_path
	open_service transceiver_channel_tx $transceiver_channel_tx_path
	open_service transceiver_channel_rx $transceiver_channel_rx_path

        # set PRBS Data Pattern
	transceiver_debug_link_set_pattern $transceiver_debug_link_path $data_pattern
	transceiver_debug_link_config_print $transceiver_debug_link_path

        # Tx PMA Setting
	if { $enable_preamble == 1 } {
		transceiver_channel_tx_enable_preamble $transceiver_channel_tx_path
		transceiver_channel_tx_set_preamble_word $transceiver_channel_tx_path $preamble_word
	} else {
		transceiver_channel_tx_disable_preamble $transceiver_channel_tx_path
	}
	
	# Based on user define setting, this will overwrite original XCVR DUT's analog setting
        if { $user_define_analog_value == 1} {
           transceiver_channel_tx_set_vodctrl $transceiver_channel_tx_path $vodctrl
           transceiver_channel_tx_set_preemph1t $transceiver_channel_tx_path $preemph1t
           transceiver_channel_tx_set_preemph0t $transceiver_channel_tx_path $preemph0t
           transceiver_channel_tx_set_preemph2t $transceiver_channel_tx_path $preemph2t
        }
	transceiver_channel_tx_config_print $transceiver_channel_tx_path

        # Rx PMA Setting 
        # User can define themselve by set user_define_analog_value to 1
	# Based on user define setting, this will overwrite original XCVR DUT's analog setting
        if { $user_define_analog_value == 1} {
           transceiver_channel_rx_set_dcgain $transceiver_channel_rx_path $dc_gain
           transceiver_channel_rx_set_eqctrl $transceiver_channel_rx_path [lindex $eq_ctrl_list 0]
        }
        transceiver_channel_rx_config_print $transceiver_channel_rx_path

        transceiver_channel_rx_set_dfe_enabled $transceiver_channel_rx_path 0
        set rx_dfe_enabled [transceiver_channel_rx_enable_dfe $transceiver_channel_rx_path $enable_dfe]

	puts "Running test with the following transceiver analog settings:"
	puts "  Data pattern generator    : [transceiver_channel_tx_get_pattern $transceiver_channel_tx_path]"
	puts "  Data pattern checker      : [transceiver_channel_rx_get_pattern $transceiver_channel_rx_path]"
	puts "  VOD control               : [set vodctrl [transceiver_channel_tx_get_vodctrl $transceiver_channel_tx_path]]"
	puts "  Pre-emphasis 1st post-tap : [set preemph1t [transceiver_channel_tx_get_preemph1t $transceiver_channel_tx_path]]"
	puts "  Pre-emphasis pre-tap      : [set preemph0t [transceiver_channel_tx_get_preemph0t $transceiver_channel_tx_path]]"
	puts "  Pre-emphasis 2nd post-tap : [set preemph2t [transceiver_channel_tx_get_preemph2t $transceiver_channel_tx_path]]"
	puts "  DC gain                   : [set dcgain [transceiver_channel_rx_get_dcgain $transceiver_channel_rx_path]]"
	if { $rx_dfe_enabled } {
	   puts "  Rx Equalizer List         : $eq_ctrl_list"
           puts "  Rx DFE 1st Tap List       : $dfe_tap1_list"
	   puts "  Rx DFE 2nd Tap List       : $dfe_tap2_list"
	   puts "  Rx DFE 3rd Tap List       : $dfe_tap3_list"

           puts ""
           puts "  Start DFE Sweeping process..."
           puts " =============================================================================================="
           puts [format "%14s %12s %12s %12s %14s %12s %14s" "  Rx Equalizer " "  DFE Tap 1 " " DFE Tap 2 " " DFE Tap 3 " "  Total bits  " " Error bits " "Bit error rate"]
           puts [format "%14s %12s %12s %12s %14s %12s %14s" " ==============" " ===========" "===========" "===========" "==============" "============" "=============="]
        } else {
                puts "  Equalization control      : [transceiver_channel_rx_get_eqctrl $transceiver_channel_rx_path]"
                puts ""
        	puts [format "%18s %14s %12s %14s" "Elapsed time(sec)" "  Total bits  " " Error bits " "Bit error rate"]
        	puts [format "%18s %14s %12s %14s" "=================" " =============" "============" "=============="]
       	}

        set rx_analog_value_list [list $dcgain]
        set tx_analog_value_list [list $vodctrl $preemph1t $preemph0t $preemph2t]

        # Variable enable_dfe is to control if user want to run DFE flow
        # Enable Rx Channel DFE [set enable_dfe 1]
        if { $rx_dfe_enabled } {
            transceiver_channel_dfe_sweep_test $transceiver_channel_path_list $eq_ctrl_list $dfe_tap_list $rx_analog_value_list $tx_analog_value_list $max_run_time_in_seconds
        } else {
            transceiver_channel_analog_link_test $transceiver_channel_path_list $max_run_time_in_seconds
        }

	# Close services
	close_service alt_xcvr_custom $alt_xcvr_path
	close_service transceiver_debug_link $transceiver_debug_link_path
	close_service transceiver_channel_rx $transceiver_channel_rx_path
	close_service transceiver_channel_tx $transceiver_channel_tx_path

	puts "\n\n--- End of link test for $debug_link between $tx_logical_channel and $rx_logical_channel ---\n\n"

}
