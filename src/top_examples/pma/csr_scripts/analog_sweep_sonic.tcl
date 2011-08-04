# This example script demonstrates the way to obtain optimum analog
# settings of the transceiver by sweeping across different analog
# values. This is achieved by reconfiguring the transceiver at
# runtime and controlling the data pattern generator and checker
# to obtain bit error rate of the link across different settings.
# This script shows how to use generator.driver and checker.driver in transceiver toolkit

source link_test_lib.tcl

####################################################
# Customize the test variables
####################################################

# Device name to match the correct device in case of multiple devices
set device_die_name "EP4S100G2"

# Relationship between TX, RX, generators and checkers:
#   index 0 - TX logical channel
#   index 1 - RX logical channel
#   index 2 - Data pattern generator instance name
#   index 3 - Data pattern checker instance name
#set logical_link_pairs {{ 0 0 "generator_0" "checker_0"}\
#						{ 1 1 "generator_1" "checker_1"} \
#						{ 2 2 "generator_2" "checker_2"} \
#						{ 3 3 "generator_3" "checker_3"} }

set logical_link_pairs {{ 0 0 "generator_0" "checker_0"} \
						{ 1 1 "generator_1" "checker_1"} }

set xcvr_instance_name "xcvr_low_latency_phy_0"

# Generator preamble mode: 0 to disable, 1 to enable
set enable_preamble 0

# Generator preamble word, not used if preamble is disabled
set preamble_word 0x0

# Transceiver RX word aligner: 0 to disable, 1 to enable
set enable_word_aligner 0

# Set Transceiver's PRBS pattern for IP : Avalon-ST Data Pattern Generator
# Data pattern type: prbs7, prbs15, prbs23, prbs31
set data_pattern "prbs23"

# EyeQ: 0 to disable, 1 to enable
set enable_eye_viewer 0

# Transceiver reconfig analog values
#set vodctrl_list   {0 1 2 3 4 5 6 7}
#set preemph1t_list {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31}
#set preemph0t_list {-15 -14 -13 -12 -11 -10 -9 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
#set preemph2t_list {-15 -14 -13 -12 -11 -10 -9 -7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
#set dcgain_list    {0 1 2 3}
#set eqctrl_list    {0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15}
set vodctrl_list   {3 4}
set preemph1t_list {2}
set preemph0t_list {1}
set preemph2t_list {3}
set dcgain_list    {1 2}
set eqctrl_list    {1 3}

# Logical channel is used as the array index
foreach logical_link_pair $logical_link_pairs {

	set tx_logical_channel [lindex $logical_link_pair 0]
	set rx_logical_channel [lindex $logical_link_pair 1]
	set generator_name     [lindex $logical_link_pair 2]
	set checker_name       [lindex $logical_link_pair 3]

	# Generators Setup
	set generator_instance_name($tx_logical_channel) $generator_name
	set generator_data_pattern($tx_logical_channel) $data_pattern
	set generator_preamble_word($tx_logical_channel) $preamble_word

	# Checkers Setup
	set checker_instance_name($rx_logical_channel) $checker_name
	set checker_data_pattern($rx_logical_channel) $data_pattern
}

# Setup link run length
set max_run_time_in_seconds 2

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
# Transceiver reconfig analog sweep
####################################################

# Not using internal loopback
#disable_internal_loopback
enable_internal_loopback

# Loop every transceiver link
foreach logical_link_pair $logical_link_pairs {

        set ber_lowest 1
        set dcgain_lowest 0
        set eqctrl_lowest 0
        set vodctrl_lowest 0
        set preemph1t_lowest 0
        set preemph0t_lowest 0
        set preemph2t_lowest 0

	set tx_logical_channel [lindex $logical_link_pair 0]
	set rx_logical_channel [lindex $logical_link_pair 1]

	puts "\n\n--- Transceiver reconfig analog settings sweep between TX @ logical channel $tx_logical_channel and RX @ logical channel $rx_logical_channel ---\n\n"

	# Obtain the services path
	set xcvr_reconfig_path [get_service_path_by_instance_name "transceiver_reconfig_analog"  $xcvr_instance_name]
	set eye_viewer_path    [get_service_path_by_instance_name "alt_xcvr_reconfig_eye_viewer" $xcvr_instance_name]
	set generator_path     [get_service_path_by_instance_name "data_pattern_generator"       $generator_instance_name($tx_logical_channel)]
	set checker_path       [get_service_path_by_instance_name "data_pattern_checker"         $checker_instance_name($rx_logical_channel)]
	set alt_xcvr_path      [get_service_path_by_instance_name "alt_xcvr_custom"              $xcvr_instance_name]

        # To enable serial loopback
	open_service alt_xcvr_custom $alt_xcvr_path
        alt_xcvr_custom_set_serial_loopback_enabled $alt_xcvr_path enabled

	# Open services and setup components
	open_service transceiver_reconfig_analog $xcvr_reconfig_path
	xcvr_reconfig_tx_value_print $xcvr_reconfig_path $tx_logical_channel
	xcvr_reconfig_rx_value_print $xcvr_reconfig_path $rx_logical_channel

	open_service alt_xcvr_reconfig_eye_viewer $eye_viewer_path
	eye_viewer_config_set $eye_viewer_path $rx_logical_channel $enable_eye_viewer 0
	eye_viewer_config_print $eye_viewer_path

	open_service data_pattern_generator $generator_path
	data_pattern_generator_config_set $generator_path $generator_data_pattern($tx_logical_channel) $enable_preamble $generator_preamble_word($tx_logical_channel)
	data_pattern_generator_config_print $generator_path

	open_service data_pattern_checker $checker_path
	data_pattern_checker_config_set $checker_path $checker_data_pattern($rx_logical_channel)
	data_pattern_checker_config_print $checker_path 

	puts "Running test with the following settings:"
	puts "  Data pattern generator    : [data_pattern_generator_get_pattern $generator_path]"
	puts "  Data pattern checker      : [data_pattern_checker_get_pattern $checker_path]"
	puts "  VOD control               : $vodctrl_list"
	puts "  Pre-emphasis 1st post-tap : $preemph1t_list"
	puts "  Pre-emphasis pre-tap      : $preemph0t_list"
	puts "  Pre-emphasis 2nd post-tap : $preemph2t_list"
	puts "  DC gain                   : $dcgain_list"
	puts "  Equalization control      : $eqctrl_list"
	puts ""

	puts [format "%7s %9s %9s %9s %7s %12s %14s %12s %14s" "  VOD  " "Preemph1t" "Preemph0t" "Preemph2t" "DC gain" "Equalization" "  Total bits  " " Error bits " "Bit error rate"]
	puts [format "%7s %9s %9s %9s %7s %12s %14s %12s %14s" "=======" "=========" "=========" "=========" "=======" "============" "==============" "============" "=============="]

	# Loop every analog settings
	foreach vodctrl $vodctrl_list {
		foreach preemph2t $preemph2t_list {
			foreach preemph0t $preemph0t_list {
				foreach preemph1t $preemph1t_list {
					foreach dcgain $dcgain_list {
						foreach eqctrl $eqctrl_list {

							xcvr_reconfig_rx_value_set $xcvr_reconfig_path $rx_logical_channel $dcgain $eqctrl
							xcvr_reconfig_tx_value_set $xcvr_reconfig_path $tx_logical_channel $vodctrl $preemph1t $preemph0t $preemph2t

                                                  	# SPR:364973
                                                  	enable_internal_loopback

							# Reset counters, start generator and checker
							data_pattern_generator_start $generator_path
							data_pattern_checker_reset_counters $checker_path
							data_pattern_checker_start $checker_path

							set start_time [clock seconds]
							set bit_error_rate 0
							set locked 1
							after [expr $max_run_time_in_seconds * 1000]
							if { [data_pattern_checker_is_locked $checker_path] } {
                                                                #This is to inject bit error to show this service
								#data_pattern_generator_inject_error $generator_path

                                                                # Snapshot the counters
								set counters [data_pattern_checker_get_data $checker_path]
								set total_bits [lindex $counters 0]
								set error_bits [lindex $counters 1]
								set bit_error_rate [lindex $counters 2]
								puts [format "%7s %9s %9s %9s %7s %12s %14s %12s %14s" \
									"$vodctrl" \
									"$preemph1t" \
									"$preemph0t" \
									"$preemph2t" \
									"$dcgain" \
									"$eqctrl" \
									$total_bits $error_bits $bit_error_rate]

                                                              		if { $ber_lowest > $bit_error_rate } {
                                                                           set ber_lowest $bit_error_rate

                                                                           set vodctrl_lowest $vodctrl
                                                                           set preemph1t_lowest $preemph1t
                                                                           set preemph0t_lowest $preemph0t
                                                                           set preemph2t_lowest $preemph2t
                                                                           set dcgain_lowest $dcgain
                                                                           set eqctrl_lowest $eqctrl
                                                        		}
							} else {
								puts [format "%7s %9s %9s %9s %7s %12s %14s %12s %14s" \
									"$vodctrl" \
									"$preemph1t" \
									"$preemph0t" \
									"$preemph2t" \
									"$dcgain" \
									"$eqctrl" \
									"\[Not locked\]" "\[Not locked\]" "\[Not locked\]"]
								set locked 0
							}

							# Stop generator and checker
							data_pattern_checker_stop $checker_path
							data_pattern_generator_stop $generator_path
						}
					}
				}
			}
		}
	}

        puts " =========================================================================================="
        puts "  Found lowest BER : $ber_lowest with below analog settings"
      	puts "  VOD control               : $vodctrl_lowest"
      	puts "  Pre-emphasis 1st post-tap : $preemph1t_lowest"
      	puts "  Pre-emphasis pre-tap      : $preemph0t_lowest"
      	puts "  Pre-emphasis 2nd post-tap : $preemph2t_lowest"
      	puts "  DC gain                   : $dcgain_lowest"
        puts "  Equalization control      : $eqctrl_lowest"
	puts ""
	puts "Test stopped after sweeping through each combination of analog values for $max_run_time_in_seconds seconds"

	# Close services
	close_service alt_xcvr_custom $alt_xcvr_path
	close_service transceiver_reconfig_analog $xcvr_reconfig_path
	close_service alt_xcvr_reconfig_eye_viewer $eye_viewer_path
	close_service data_pattern_generator $generator_path
	close_service data_pattern_checker $checker_path
	
	puts "\n\n--- End of transceiver reconfig analog settings sweep TX @ logical channel $tx_logical_channel and RX @ logical channel $rx_logical_channel ---\n\n"

}
