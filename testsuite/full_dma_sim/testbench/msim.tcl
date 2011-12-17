set MON_SIMDIR ../sonic_monitor/sonic_monitor/simulation

# alias mon_com {
#    vlog +define+DISABLE_ALTERA_AVALON_SIM_SVA +define+ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING "$MON_SIMDIR/submodules/altera_reset_controller.v"
#    vlog +define+DISABLE_ALTERA_AVALON_SIM_SVA +define+ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING "$MON_SIMDIR/submodules/altera_reset_synchronizer.v"
#    vlog +define+DISABLE_ALTERA_AVALON_SIM_SVA +define+ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor_assertion.sv"
#    vlog +define+DISABLE_ALTERA_AVALON_SIM_SVA +define+ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor_coverage.sv"
#    vlog +define+DISABLE_ALTERA_AVALON_SIM_SVA +define+ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor_transactions.sv"
#    vlog +define+DISABLE_ALTERA_AVALON_SIM_SVA +define+ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor.sv"
#    vlog +define+DISABLE_ALTERA_AVALON_SIM_SVA +define+ENABLE_ALTERA_AVALON_TRANSACTION_RECORDING "$MON_SIMDIR/sonic_monitor.v"
# }

alias mon_com {
   vlog "$MON_SIMDIR/submodules/altera_reset_controller.v"
   vlog "$MON_SIMDIR/submodules/altera_reset_synchronizer.v"
   vlog -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor_assertion.sv"
   vlog -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor_coverage.sv"
   vlog -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor_transactions.sv"
   vlog -sv "$MON_SIMDIR/submodules/altera_avalon_st_monitor.sv"
   vlog "$MON_SIMDIR/sonic_monitor.v"
}


alias elab_top "
vsim -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver -novopt sonic_chaining_testbench
"

alias elab_top_sv_lib "
vsim -sv_lib pci_tlm -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver -novopt sonic_chaining_testbench
"

