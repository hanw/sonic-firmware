proc get_service_path_by_instance_name { service_type instance_name } {
	set service_path ""
	foreach path [get_service_paths $service_type] {
		if { [regexp .*$instance_name $path] } {
			set service_path $path
		}
	}
	if { [string length $service_path] == 0 } {
		error "Specified $service_type instance, $instance_name is not found"
	}
	return $service_path
}

proc xcvr_reconfig_tx_value_print { xcvr_reconfig_path logical_channel } {
	transceiver_reconfig_analog_set_logical_channel_address $xcvr_reconfig_path $logical_channel
	puts "Transceiver Reconfig TX: Path = $xcvr_reconfig_path"
	puts "Transceiver Reconfig TX: Logical channel = $logical_channel"
	puts "Transceiver Reconfig TX: VOD control = [transceiver_reconfig_analog_get_tx_vodctrl $xcvr_reconfig_path]"
	puts "Transceiver Reconfig TX: Pre-emphasis 1st post-tap = [transceiver_reconfig_analog_get_tx_preemph1t $xcvr_reconfig_path]"
	puts "Transceiver Reconfig TX: Pre-emphasis pre-tap = [transceiver_reconfig_analog_get_tx_preemph0t $xcvr_reconfig_path]"
	puts "Transceiver Reconfig TX: Pre-emphasis 2nd post-tap = [transceiver_reconfig_analog_get_tx_preemph2t $xcvr_reconfig_path]"
	puts ""
}

proc xcvr_reconfig_tx_value_set { xcvr_reconfig_path logical_channel vodctrl preemph1t preemph0t preemph2t  } {
	transceiver_reconfig_analog_set_logical_channel_address $xcvr_reconfig_path $logical_channel
	transceiver_reconfig_analog_set_tx_vodctrl   $xcvr_reconfig_path $vodctrl
	transceiver_reconfig_analog_set_tx_preemph1t $xcvr_reconfig_path $preemph1t
	transceiver_reconfig_analog_set_tx_preemph0t $xcvr_reconfig_path $preemph0t
	transceiver_reconfig_analog_set_tx_preemph2t $xcvr_reconfig_path $preemph2t
}

proc xcvr_reconfig_rx_value_print { xcvr_reconfig_path logical_channel} {
	transceiver_reconfig_analog_set_logical_channel_address $xcvr_reconfig_path $logical_channel
	puts "Transceiver Reconfig RX: Path = $xcvr_reconfig_path"
	puts "Transceiver Reconfig RX: Logical channel = $logical_channel"
	puts "Transceiver Reconfig RX: DC gain = [transceiver_reconfig_analog_get_rx_dcgain $xcvr_reconfig_path]"
	puts "Transceiver Reconfig RX: Equalization control = [transceiver_reconfig_analog_get_rx_eqctrl $xcvr_reconfig_path]"
	puts ""
}

proc xcvr_reconfig_rx_value_set { xcvr_reconfig_path logical_channel dcgain eqctrl } {
	transceiver_reconfig_analog_set_logical_channel_address $xcvr_reconfig_path $logical_channel
	transceiver_reconfig_analog_set_rx_dcgain $xcvr_reconfig_path $dcgain
	transceiver_reconfig_analog_set_rx_eqctrl $xcvr_reconfig_path $eqctrl
}

proc transceiver_channel_tx_analog_value_print { transceiver_channel_tx_path } {
	puts "Transceiver Channel TX: Path = $transceiver_channel_tx_path"
	puts "Transceiver Channel TX: VOD control = [transceiver_channel_tx_get_vodctrl $transceiver_channel_tx_path]"
	puts "Transceiver Channel TX: Pre-emphasis 1st post-tap = [transceiver_channel_tx_get_preemph1t $transceiver_channel_tx_path]"
	puts "Transceiver Channel TX: Pre-emphasis pre-tap = [transceiver_channel_tx_get_preemph0t $transceiver_channel_tx_path]"
	puts "Transceiver Channel TX: Pre-emphasis 2nd post-tap = [transceiver_channel_tx_get_preemph2t $transceiver_channel_tx_path]"
	puts ""
}

proc transceiver_channel_tx_analog_value_set { transceiver_channel_tx_path vodctrl preemph1t preemph0t preemph2t  } {
	transceiver_channel_tx_set_vodctrl   $transceiver_channel_tx_path $vodctrl
	transceiver_channel_tx_set_preemph1t $transceiver_channel_tx_path $preemph1t
	transceiver_channel_tx_set_preemph0t $transceiver_channel_tx_path $preemph0t
	transceiver_channel_tx_set_preemph2t $transceiver_channel_tx_path $preemph2t
}

proc transceiver_channel_rx_analog_value_print { transceiver_channel_rx_path } {
	puts "Transceiver Channel RX: Path = $transceiver_channel_rx_path"
	puts "Transceiver Channel RX: DC gain = [transceiver_channel_rx_get_dcgain $transceiver_channel_rx_path]"
	puts "Transceiver Channel RX: Equalization control = [transceiver_channel_rx_get_eqctrl $transceiver_channel_rx_path]"
	puts ""
}

proc transceiver_channel_rx_analog_value_set { transceiver_channel_rx_path dcgain eqctrl } {
	transceiver_channel_rx_set_dcgain $transceiver_channel_rx_path $dcgain
	transceiver_channel_rx_set_eqctrl $transceiver_channel_rx_path $eqctrl
}

proc transceiver_channel_tx_config_print { transceiver_channel_tx_path } {
	puts "Transceiver Channel TX: Path = $transceiver_channel_tx_path"
	puts "Transceiver Channel TX: Pattern = [transceiver_channel_tx_get_pattern $transceiver_channel_tx_path]"
	if { [transceiver_channel_tx_is_preamble_enabled $transceiver_channel_tx_path] == 1 } {
		puts "Transceiver Channel TX: Preamble enabled"
		puts "Transceiver Channel TX: Preamble word = [transceiver_channel_tx_get_preamble_word $transceiver_channel_tx_path]"
	} else {
		puts "Transceiver Channel TX: Preamble disabled"
	}
	puts ""
}

proc transceiver_channel_rx_config_print { transceiver_channel_rx_path } {
	puts "Transceiver Channel RX: Path = $transceiver_channel_rx_path"
	puts "Transceiver Channel RX: Pattern = [transceiver_channel_rx_get_pattern $transceiver_channel_rx_path]"
	
	# GT device with High Speed Low Latency design (40bits data width, 10.312Gbps)
	# Word Alignment is not supported
	
	#if { [transceiver_channel_rx_is_word_aligner_enabled $transceiver_channel_rx_path] == 1 } {
	#	puts "Transceiver Channel RX: Word aligner enabled"
	#} else {		
		puts "Transceiver Channel RX: Word aligner disabled"
	#}

        # exclude Arria II for EyeQ check
        set device_path [get_service_paths device]

        if {[regexp {EP2AGX125} $device_path]} {
               puts "Transceiver Channel RX: EyeQ disabled by default for Arria II Device"
        } else {
                if { [transceiver_channel_rx_is_eyeq_enabled $transceiver_channel_rx_path] == 1 } {
        		puts "Transceiver Channel RX: EyeQ enabled"
        		puts "Transceiver Channel RX: EyeQ phase step = [transceiver_channel_rx_get_eyeq_phase_step $transceiver_channel_rx_path]"
        	} else {
        		puts "Transceiver Channel RX: EyeQ disabled"
        	}
	}
}

proc alt_xcvr_custom_config_print { xcvr_custom_path } {
	puts "Transceiver: Path = $xcvr_custom_path"
	if { [alt_xcvr_custom_is_word_aligner_enabled $xcvr_custom_path] == 1 } {
		puts "Transceiver: Word aligner enabled"
	} else {
		puts "Transceiver: Word aligner disabled"
	}
	puts ""
}

proc transceiver_debug_link_config_print { transceiver_debug_link_path } {
	puts "Transceiver Debug Link: Path = $transceiver_debug_link_path"
	puts "Transceiver Debug Link: Pattern = [transceiver_debug_link_get_pattern $transceiver_debug_link_path]"
	puts ""
}

proc alt_xcvr_custom_config_set { xcvr_custom_path logical_channel enable_word_aligner} {
	alt_xcvr_custom_set_logic_channel_address $xcvr_custom_path $logical_channel
	alt_xcvr_custom_set_word_aligner_enabled $xcvr_custom_path $enable_word_aligner
}

proc eye_viewer_report_print { eye_viewer_path checker_path} {
	set counters [data_pattern_checker_get_data $checker_path]
	set bit_error_rate [lindex $counters 2]
	puts "Phase step = [alt_xcvr_reconfig_eye_viewer_get_phase_step $eye_viewer_path]  Bit error rate = $bit_error_rate"
}

proc eye_viewer_config_print { eye_viewer_path } {
	puts "EyeQ: Path = $eye_viewer_path"
	puts "EyeQ: Logical channel = [alt_xcvr_reconfig_eye_viewer_get_logical_channel_address $eye_viewer_path]"
	if { [alt_xcvr_reconfig_eye_viewer_is_enabled $eye_viewer_path] == 1 } {
		puts "EyeQ: Enabled"
		puts "EyeQ: Phase step = [alt_xcvr_reconfig_eye_viewer_get_phase_step $eye_viewer_path]"
	} else {
		puts "EyeQ: Disabled"
	}
	puts ""
}

proc eye_viewer_config_set { eye_viewer_path logical_channel enable phase_step} {
	alt_xcvr_reconfig_eye_viewer_set_logical_channel_address $eye_viewer_path $logical_channel
	alt_xcvr_reconfig_eye_viewer_set_enabled $eye_viewer_path $enable
	alt_xcvr_reconfig_eye_viewer_set_phase_step $eye_viewer_path $phase_step
}

proc data_pattern_generator_config_print { generator_path } {
	puts "Generator: Path = $generator_path"
	puts "Generator: Pattern = [data_pattern_generator_get_pattern $generator_path]"
	if { [data_pattern_generator_is_preamble_enabled $generator_path] == 1 } {
		puts "Generator: Preamble enabled"
		puts "Generator: Preamble beats = [data_pattern_generator_get_preamble_beats $generator_path]"
		puts "Generator: Preamble word = [data_pattern_generator_get_preamble_word $generator_path]\n"
	} else {
		puts "Generator: Preamble disabled"
	}
	puts ""
}

proc data_pattern_generator_config_set { generator_path pattern enable_preamble preamble_word } {
	if { [data_pattern_generator_is_generating $generator_path] } {
		data_pattern_generator_stop $generator_path
	}
	data_pattern_generator_set_pattern $generator_path $pattern
	if { $enable_preamble == 1 } {
		data_pattern_generator_enable_preamble $generator_path
		data_pattern_generator_set_preamble_word $generator_path $preamble_word
		data_pattern_generator_set_preamble_beats $generator_path 0xFF
	} else {
		data_pattern_generator_disable_preamble $generator_path
	}
}

proc data_pattern_checker_config_print { checker_path } {
	puts "Checker: Path = $checker_path"
	puts "Checker: Pattern = [data_pattern_checker_get_pattern $checker_path]"
	puts ""
}

proc data_pattern_checker_config_set { checker_path pattern } {
	if { [data_pattern_checker_is_checking $checker_path] } {
		data_pattern_checker_stop $checker_path
	}

	data_pattern_checker_set_pattern $checker_path $pattern
}

# Returns the first master in the system
proc get_default_master {} {
	return [ lindex [ get_service_paths master ] 0 ]
}

# Enable/disable internal loopback of specific transceiver channels
proc enable_internal_loopback_by_channels { enable_channels } {
	set master_path [get_default_master]
	open_service master $master_path
	master_write_32 $master_path 0x184 $enable_channels
	close_service master $master_path
}

# Enable internal loopback of all transceiver channels
proc enable_internal_loopback {} {
	enable_internal_loopback_by_channels 0xFFFFFFFF
}

# Disable internal loopback of all transceiver channels
proc disable_internal_loopback {} {
	enable_internal_loopback_by_channels 0x0
}

# Enable or Disable Rx Channel DFE
proc transceiver_channel_rx_enable_dfe { transceiver_channel_rx_path enable_dfe } {

        set rx_has_dfe [transceiver_channel_rx_has_dfe $transceiver_channel_rx_path]

        if { $rx_has_dfe == 1} {
        	transceiver_channel_rx_set_dfe_enabled $transceiver_channel_rx_path $enable_dfe
       	}

        set rx_is_dfe_enabled [transceiver_channel_rx_is_dfe_enabled $transceiver_channel_rx_path]
        if { $rx_is_dfe_enabled == 1} {
               	puts "Transceiver Channel RX: DFE Enabled\n"
       	} else {
               	puts "Transceiver Channel RX: DFE Disabled\n"
       	}

       	return $rx_is_dfe_enabled
}

proc calc_ber_link { transceiver_channel_path_list user_run_time_in_seconds} {
        # Setup link run length
        set max_error_bits 10000
        set max_run_time_in_seconds $user_run_time_in_seconds
        if { $max_run_time_in_seconds == 0 } {
           set max_run_time_in_seconds 10
        }
        set checker_status_polling_interval_in_seconds 2
        
        set transceiver_channel_tx_path [lindex $transceiver_channel_path_list 0]
        set transceiver_channel_rx_path [lindex $transceiver_channel_path_list 1]
        set transceiver_debug_link_path [lindex $transceiver_channel_path_list 2]

	# Reset counters, start generator and checker
	transceiver_debug_link_start_running $transceiver_debug_link_path

	set start_time [clock seconds]
	set elapsed_time 0
	set error_bits 0
	set bit_error_rate 1
	set total_bits 0
	set locked [transceiver_channel_rx_is_locked $transceiver_channel_rx_path]

        	while { $elapsed_time < $max_run_time_in_seconds && $error_bits < $max_error_bits && $locked == 1 } {
        		after [expr $checker_status_polling_interval_in_seconds * 1000]
        		set elapsed_time [expr [clock seconds] - $start_time]
        		if { [transceiver_channel_rx_is_locked $transceiver_channel_rx_path] } {
        			# Snapshot the counters
        			set counters [transceiver_channel_rx_get_data $transceiver_channel_rx_path]

                                #This is to inject 1 bit error to test the DFE Sweep Algorithm
                                #transceiver_channel_tx_inject_error $transceiver_channel_tx_path

        			set total_bits [lindex $counters 0]
        			set error_bits [lindex $counters 1]
        			set bit_error_rate [lindex $counters 2]

                                puts [format "%17s %14s %12s %14s" $elapsed_time $total_bits $error_bits $bit_error_rate]

        		} else {
        			puts [format "%17s %14s %12s %14s" $elapsed_time " \[Not locked\]" " \[Not locked\]" " \[Not locked\]"]
        			set locked 0
                                set bit_error_rate 1
        		}
        	}

        set return_list [list $bit_error_rate $total_bits $error_bits $locked]

        # Stop generator and checker
        transceiver_debug_link_stop_running $transceiver_debug_link_path

        return $return_list
}

proc calc_ber_sweep { transceiver_channel_path_list user_run_time_in_seconds} {
        # Setup link run length
        set max_error_bits 10000
        set max_run_time_in_seconds $user_run_time_in_seconds
        if { $max_run_time_in_seconds == 0 } {
           set max_run_time_in_seconds 10
        }
        set checker_status_polling_interval_in_seconds 2

        set transceiver_channel_tx_path [lindex $transceiver_channel_path_list 0]
        set transceiver_channel_rx_path [lindex $transceiver_channel_path_list 1]
        set transceiver_debug_link_path [lindex $transceiver_channel_path_list 2]

        # Reset counters, start generator and checker
        transceiver_debug_link_start_running $transceiver_debug_link_path

        set start_time [clock seconds]
        set bit_error_rate 1
        set total_bits 0
        set error_bits 0
        set rx_locked 0
        set locked [transceiver_channel_rx_is_locked $transceiver_channel_rx_path]
        after [expr $max_run_time_in_seconds * 1000]
        if { [transceiver_channel_rx_is_locked $transceiver_channel_rx_path] } {
            
            #This is to inject 1 bit error to test the DFE Sweep Algorithm
            #transceiver_channel_tx_inject_error $transceiver_channel_tx_path

            # Snapshot the counters
            set counters [transceiver_channel_rx_get_data $transceiver_channel_rx_path]

            set total_bits [lindex $counters 0]
            set error_bits [lindex $counters 1]
            set bit_error_rate [lindex $counters 2]

            set rx_locked 1
        }

        # Stop generator and checker
        transceiver_channel_rx_stop_checking $transceiver_channel_rx_path
        transceiver_channel_tx_stop_generation $transceiver_channel_tx_path

        set return_list [list $bit_error_rate $total_bits $error_bits $rx_locked]

        return $return_list
}

proc transceiver_channel_analog_link_test { transceiver_channel_path_list user_run_time_in_seconds} {

     calc_ber_link $transceiver_channel_path_list $user_run_time_in_seconds
}

proc transceiver_channel_dfe_sweep_test { transceiver_channel_path_list eq_ctrl_list dfe_tap_list lowest_rx_analog_value_list lowest_tx_analog_value_list user_run_time_in_seconds} {

     set transceiver_channel_tx_path [lindex $transceiver_channel_path_list 0]
     set transceiver_channel_rx_path [lindex $transceiver_channel_path_list 1]
     set transceiver_debug_link_path [lindex $transceiver_channel_path_list 2]

     set dfe_tap1_list [lindex $dfe_tap_list 0]
     set dfe_tap2_list [lindex $dfe_tap_list 1]
     set dfe_tap3_list [lindex $dfe_tap_list 2]
     
     set dcgain_lowest    [lindex $lowest_rx_analog_value_list 0]
     set vodctrl_lowest   [lindex $lowest_tx_analog_value_list 0]
     set preemph1t_lowest [lindex $lowest_tx_analog_value_list 1]
     set preemph0t_lowest [lindex $lowest_tx_analog_value_list 2]
     set preemph2t_lowest [lindex $lowest_tx_analog_value_list 3]

     set dfe_returned [dfe_tap1_proc $transceiver_channel_path_list $eq_ctrl_list $dfe_tap_list $user_run_time_in_seconds]
     set lowest_ber   [lindex $dfe_returned 0]
     set dfe_tap1     [lindex $dfe_returned 1]
     set dfe_tap2     [lindex $dfe_returned 2]
     set dfe_tap3     [lindex $dfe_returned 3]
     set total_bits   [lindex $dfe_returned 4]
     set error_bits   [lindex $dfe_returned 5]
     set rx_locked    [lindex $dfe_returned 6]
     set eq_ctrl_val  [lindex $dfe_returned 7]

     puts ""
     puts " ================================================================================================="
     puts "  Lowest BER with DFE Setting  : $lowest_ber "
     puts "  VOD control                  : $vodctrl_lowest"
     puts "  Pre-emphasis 1st post-tap    : $preemph1t_lowest"
     puts "  Pre-emphasis pre-tap         : $preemph0t_lowest"
     puts "  Pre-emphasis 2nd post-tap    : $preemph2t_lowest"
     puts "  DC gain                      : $dcgain_lowest"
     puts "  Rx Equalizer Setting         : $eq_ctrl_val"
     puts "  Rx Channel DFE Tap 1         : $dfe_tap1"
     puts "  Rx Channel DFE Tap 2         : $dfe_tap2"
     puts "  Rx Channel DFE Tap 3         : $dfe_tap3"

}

proc transceiver_channel_analog_sweep_test { transceiver_channel_path_list rx_analog_value_list tx_analog_value_list rx_dfe_enabled user_run_time_in_seconds} {
     set transceiver_channel_tx_path [lindex $transceiver_channel_path_list 0]
     set transceiver_channel_rx_path [lindex $transceiver_channel_path_list 1]
     set transceiver_debug_link_path [lindex $transceiver_channel_path_list 2]

     set dcgain [lindex $rx_analog_value_list 0]
     set eqctrl [lindex $rx_analog_value_list 1]

     set vodctrl   [lindex $tx_analog_value_list 0]
     set preemph1t [lindex $tx_analog_value_list 1]
     set preemph0t [lindex $tx_analog_value_list 2]
     set preemph2t [lindex $tx_analog_value_list 3]

     set calc_ber_returned [calc_ber_sweep $transceiver_channel_path_list $user_run_time_in_seconds]
     set bit_error_rate [lindex $calc_ber_returned 0]
     set total_bits     [lindex $calc_ber_returned 1]
     set error_bits     [lindex $calc_ber_returned 2]
     set rx_locked      [lindex $calc_ber_returned 3]

     # 2 dirrent way of display 
     # Normaly display and DFE Sweep display
     if {$rx_dfe_enabled == 1} {
        if { $rx_locked == 1 } {
	      puts [format "%7s %9s %9s %9s %7s %14s %12s %14s" \
		"$vodctrl" \
		"$preemph1t" \
		"$preemph0t" \
		"$preemph2t" \
		"$dcgain" \
		$total_bits $error_bits $bit_error_rate]
        }
     } else {
        if { $rx_locked == 1 } {
	      puts [format "%7s %9s %9s %9s %7s %12s %14s %12s %14s" \
		"$vodctrl" \
		"$preemph1t" \
		"$preemph0t" \
		"$preemph2t" \
		"$dcgain" \
		"$eqctrl" \
		$total_bits $error_bits $bit_error_rate]
        }
    }
    
     set return_list [list $bit_error_rate $rx_locked]

     return $return_list
}

proc dfe_tap1_proc { transceiver_channel_path_list eq_ctrl_list dfe_tap_list user_run_time_in_seconds} {
     # Procedure to run for DFE Tap1 value
     set final_dfe_tap1 0
     set final_dfe_tap2 0
     set final_dfe_tap3 0
     set ber_lowest     1
     set ber_lower_tap1 1
     set ber_lower_tap2 1
     set ber_lower_tap3 1
     set eq_ctrl_best   0
     set locked 0
     set break_eq_loop 0

        set transceiver_channel_tx_path [lindex $transceiver_channel_path_list 0]
        set transceiver_channel_rx_path [lindex $transceiver_channel_path_list 1]
        set transceiver_debug_link_path [lindex $transceiver_channel_path_list 2]

        set dfe_tap1_list [lindex $dfe_tap_list 0]
        set dfe_tap2_list [lindex $dfe_tap_list 1]
        set dfe_tap3_list [lindex $dfe_tap_list 2]

        foreach eq_ctrl $eq_ctrl_list {
          #reset DFE Tap Value
          set dfe_tap2_val 0
          set dfe_tap3_val 0
          transceiver_channel_rx_set_dfe_tap_value $transceiver_channel_rx_path 2 $dfe_tap2_val
          transceiver_channel_rx_set_dfe_tap_value $transceiver_channel_rx_path 3 $dfe_tap3_val

          # Set Rx Equalizer value
          transceiver_channel_rx_set_eqctrl $transceiver_channel_rx_path $eq_ctrl

          foreach dfe_tap1 $dfe_tap1_list {
                 # Set DFE Tap Value 1
                 transceiver_channel_rx_set_dfe_tap_value $transceiver_channel_rx_path 1 $dfe_tap1
                     # call proc for Link Test BER Calculation
                     set calc_ber_returned [calc_ber_sweep $transceiver_channel_path_list $user_run_time_in_seconds]
                     set ber_calced [lindex $calc_ber_returned 0]
                     set total_bits [lindex $calc_ber_returned 1]
                     set error_bits [lindex $calc_ber_returned 2]

                   if { $ber_calced == 0 } {
                      set ber_lower_tap1 $ber_calced
                      set ber_lowest $ber_lower_tap1
                      set eq_ctrl_best $eq_ctrl
                      set final_dfe_tap1 $dfe_tap1
                      set dfe_tap2_val 0
                      set dfe_tap3_val 0
                      set locked 1
                      set break_eq_loop 1

                      # Print output before found BER=0.000 for and break                      
                      puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $final_dfe_tap1 $dfe_tap2_val $dfe_tap3_val $total_bits $error_bits $ber_lowest]

                      break
                   } else {

                     if { $ber_lowest > $ber_calced } {
                        set ber_lower_tap1 $ber_calced
                        set final_dfe_tap1 $dfe_tap1
                        set locked 1
                        set ber_lowest $ber_calced
                        set eq_ctrl_best $eq_ctrl
                     }
                   }

                   puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $dfe_tap1 $dfe_tap2_val $dfe_tap3_val $total_bits $error_bits $ber_calced]
              }

              if { $ber_lower_tap1 > 0 } {
                 # Set Lowest DFE Tap Value 1
                 transceiver_channel_rx_set_dfe_tap_value $transceiver_channel_rx_path 1 $final_dfe_tap1

                     # BER is not equal to 0, run DFE Tap2 experiment
                     set dfe_tap2_returned [dfe_tap2_proc $transceiver_channel_path_list $dfe_tap_list $final_dfe_tap1 $eq_ctrl $user_run_time_in_seconds]
                     set dfe_tap2_ber [lindex $dfe_tap2_returned 0]
                     set dfe_tap2_val [lindex $dfe_tap2_returned 1]
                     set dfe_tap2_bit [lindex $dfe_tap2_returned 2]
                     set dfe_tap2_err [lindex $dfe_tap2_returned 3]
                     set dfe_tap3_ber [lindex $dfe_tap2_returned 4]
                     set dfe_tap3_val [lindex $dfe_tap2_returned 5]
                     set dfe_tap3_bit [lindex $dfe_tap2_returned 6]
                     set dfe_tap3_err [lindex $dfe_tap2_returned 7]

                 if { $dfe_tap3_ber > $dfe_tap2_ber  } {
                    if { $dfe_tap2_ber > $ber_lower_tap1 } {
                         if { $ber_lowest > $ber_lower_tap1 } {
                           set ber_lowest $ber_lower_tap1
                           set eq_ctrl_best $eq_ctrl
                           set final_dfe_tap2 0
                           set final_dfe_tap3 0
                           set locked 1
                         }
                    } else {
                      if { $ber_lowest > $dfe_tap2_ber } {
                         #set ber_lower_tap2 $dfe_tap2_ber
                         set ber_lowest $dfe_tap2_ber
                         set eq_ctrl_best $eq_ctrl
                         set final_dfe_tap2 $dfe_tap2_val
                         set final_dfe_tap3 0
                         set total_bits $dfe_tap2_bit
                         set error_bits $dfe_tap2_err
                         set locked 1

                         if {$dfe_tap2_ber == 0} {
                             set break_eq_loop 1
                         }
                      }
                    }
                 } else {
                    if { $ber_lowest > $dfe_tap3_ber } {
                      #set ber_lower_tap3 $dfe_tap3_ber
                      set ber_lowest $dfe_tap3_ber
                      set eq_ctrl_best $eq_ctrl
                      set final_dfe_tap2 $dfe_tap2_val
                      set final_dfe_tap3 $dfe_tap3_val
                      set total_bits $dfe_tap3_bit
                      set error_bits $dfe_tap3_err
                      set locked 1
  
                      if {$dfe_tap3_ber == 0} {
                           set break_eq_loop 1
                      }
                   }
                 }
              }


           # if BER found inside DFE Tap loop 1,2,3 then break this loop
           if { $break_eq_loop == 1 } {
              break
           }
        }
        
        set return_list [list $ber_lowest $final_dfe_tap1 $final_dfe_tap2 $final_dfe_tap3 $total_bits $error_bits $locked $eq_ctrl_best]

        return $return_list
}

proc dfe_tap2_proc { transceiver_channel_path_list dfe_tap_list final_dfe_tap1 eq_ctrl user_run_time_in_seconds} {
     set final_dfe_tap2 0                            
     set ber_lower_tap2 1
     set dfe_tap3_ber 1
     set dfe_tap3_val 0
     set error_bit_lower 0

        set transceiver_channel_tx_path [lindex $transceiver_channel_path_list 0]
        set transceiver_channel_rx_path [lindex $transceiver_channel_path_list 1]
        set transceiver_debug_link_path [lindex $transceiver_channel_path_list 2]
        
        set dfe_tap1_list [lindex $dfe_tap_list 0]
        set dfe_tap2_list [lindex $dfe_tap_list 1]
        set dfe_tap3_list [lindex $dfe_tap_list 2]

          foreach dfe_tap2 $dfe_tap2_list {
                 # Set DFE Tap Value 2
                 transceiver_channel_rx_set_dfe_tap_value $transceiver_channel_rx_path 2 $dfe_tap2

                       # call proc for Link Test BER Calculation
                       set calc_ber_returned [calc_ber_sweep $transceiver_channel_path_list $user_run_time_in_seconds]
                       set ber_calced [lindex $calc_ber_returned 0]
                       set total_bits [lindex $calc_ber_returned 1]
                       set error_bits [lindex $calc_ber_returned 2]

                   if { $ber_calced == 0 } {
                        set ber_lower_tap2 $ber_calced
                        set final_dfe_tap2 $dfe_tap2
                        
                        puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $final_dfe_tap1 $final_dfe_tap2 $dfe_tap3_val $total_bits $error_bits $ber_lower_tap2]

                        break
                   } elseif { $ber_calced < $ber_lower_tap2 } {
                        set ber_lower_tap2 $ber_calced
                        set final_dfe_tap2 $dfe_tap2
                   }

                   #puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $final_dfe_tap1 $dfe_tap2 $dfe_tap3_val $total_bits $error_bits $ber_calced]
                   puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $final_dfe_tap1 $dfe_tap2 $dfe_tap3_val $total_bits $error_bits $ber_calced]
              }

              if { $ber_lower_tap2 > 0 } {
                 # Set Lowest DFE Tap Value 2
                 transceiver_channel_rx_set_dfe_tap_value $transceiver_channel_rx_path 2 $final_dfe_tap2

                 # BER is not equal to 0, run DFE Tap2 experiment
                 set dfe_tap3_returned [dfe_tap3_proc $transceiver_channel_path_list $dfe_tap_list $final_dfe_tap1 $final_dfe_tap2 $eq_ctrl $user_run_time_in_seconds]

                       set dfe_tap3_ber [lindex $dfe_tap3_returned 0]
                       set dfe_tap3_val [lindex $dfe_tap3_returned 1]
                       set dfe_tap3_bit [lindex $dfe_tap3_returned 2]
                       set dfe_tap3_err [lindex $dfe_tap3_returned 3]
              }
        
        set return_list [ list $ber_lower_tap2 $final_dfe_tap2 $total_bits $error_bits $dfe_tap3_ber $dfe_tap3_val $dfe_tap3_bit $dfe_tap3_err]

        return $return_list
}

proc dfe_tap3_proc { transceiver_channel_path_list dfe_tap_list final_dfe_tap1 final_dfe_tap2 eq_ctrl user_run_time_in_seconds} {
     set final_dfe_tap3 0
     set ber_lower_tap3 1
     set error_bit_lower 0

        set transceiver_channel_tx_path [lindex $transceiver_channel_path_list 0]
        set transceiver_channel_rx_path [lindex $transceiver_channel_path_list 1]
        set transceiver_debug_link_path [lindex $transceiver_channel_path_list 2]

        set dfe_tap1_list [lindex $dfe_tap_list 0]
        set dfe_tap2_list [lindex $dfe_tap_list 1]
        set dfe_tap3_list [lindex $dfe_tap_list 2]

          foreach dfe_tap3 $dfe_tap3_list {
                 # Set DFE Tap Value 3
                 transceiver_channel_rx_set_dfe_tap_value $transceiver_channel_rx_path 3 $dfe_tap3

                       #puts "  Rx DFE Tap3 = [transceiver_channel_rx_get_dfe_tap_value $transceiver_channel_rx_path 3]"
                       # call proc for Link Test BER Calculation
                       set calc_ber_returned [calc_ber_sweep $transceiver_channel_path_list $user_run_time_in_seconds]
                       set ber_calced [lindex $calc_ber_returned 0]
                       set total_bits [lindex $calc_ber_returned 1]
                       set error_bits [lindex $calc_ber_returned 2]

                   if { $ber_calced == 0 } {
                      set final_dfe_tap3 $dfe_tap3
                      set ber_lower_tap3 0
                      
                      puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $final_dfe_tap1 $final_dfe_tap2 $final_dfe_tap3 $total_bits $error_bits $ber_lower_tap3]

                      break
                   } elseif { $ber_calced < $ber_lower_tap3 } {
                      set final_dfe_tap3 $dfe_tap3
                      set ber_lower_tap3 $ber_calced
                   }
                   
                   #puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $final_dfe_tap1 $final_dfe_tap2 $dfe_tap3 $total_bits $error_bits $ber_calced]
                   puts [format "%14s %12s %12s %12s %14s %12s %14s" $eq_ctrl $final_dfe_tap1 $final_dfe_tap2 $dfe_tap3 $total_bits $error_bits $ber_calced]
              }

               set return_list [ list $ber_lower_tap3 $final_dfe_tap3 $total_bits $error_bits ]

        return $return_list
}
