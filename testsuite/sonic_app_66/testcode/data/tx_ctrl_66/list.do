onerror {resume}
add list -width 125 /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_tx_buf/data_out
add list /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/data_valid
add list /top/tb/sonic_application_top_testbench_inst/sonic_application_top_0/app/chaining_dma_arb/sonic_port0/sonic_rx_buf/gearbox/data_out
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
