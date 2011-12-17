
# -----------------------------------------
# Auto-generated simulation script

# -----------------------------------------
# Initialize the variable
if ![info exist SYSTEM_INSTANCE_NAME] { 
   set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
   set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
} 

if ![info exist TOP_LEVEL_NAME] { 
   set TOP_LEVEL_NAME "sonic_monitor_tb"
} elseif { ![ string match "" $TOP_LEVEL_NAME ] } { 
   set TOP_LEVEL_NAME "$TOP_LEVEL_NAME"
} 

if ![info exist QSYS_SIMDIR] { 
   set QSYS_SIMDIR "."
} elseif { ![ string match "" $QSYS_SIMDIR ] } { 
   set QSYS_SIMDIR "$QSYS_SIMDIR"
} 


# -----------------------------------------
# Copy ROM/RAM files to simulation directory

# -----------------------------------------
# Create compilation libraries
vlib work
vmap work work
if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
vlib altera_ver
vmap altera_ver altera_ver
vlib lpm_ver
vmap lpm_ver lpm_ver
vlib sgate_ver
vmap sgate_ver sgate_ver
vlib altera_mf_ver
vmap altera_mf_ver altera_mf_ver
vlib altera_lnsim_ver
vmap altera_lnsim_ver altera_lnsim_ver
vlib stratixiv_hssi_ver
vmap stratixiv_hssi_ver stratixiv_hssi_ver
vlib stratixiv_pcie_hip_ver
vmap stratixiv_pcie_hip_ver stratixiv_pcie_hip_ver
vlib stratixiv_ver
vmap stratixiv_ver stratixiv_ver

}

# -----------------------------------------
# Compile device library files
alias dev_com {
if { ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] } {
   vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/altera_primitives.v" -work altera_ver
   vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/220model.v" -work lpm_ver
   vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/sgate.v" -work sgate_ver
   vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/altera_mf.v" -work altera_mf_ver
   vlog -sv "/home/hwang/altera/11.0/quartus/eda/sim_lib/altera_lnsim.sv" -work altera_lnsim_ver
   vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/stratixiv_hssi_atoms.v" -work stratixiv_hssi_ver
   vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/stratixiv_pcie_hip_atoms.v" -work stratixiv_pcie_hip_ver
   vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/stratixiv_atoms.v" -work stratixiv_ver
}

}

# -----------------------------------------
# Compile the design files in correct order
alias com {
   vlog "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_reset_controller.v"
   vlog "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_reset_synchronizer.v"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/verbosity_pkg.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_st_monitor_assertion.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_st_monitor_coverage.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_st_monitor_transactions.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_st_monitor.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/avalon_utilities_pkg.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/verbosity_pkg.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_st_source_bfm.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/avalon_utilities_pkg.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/verbosity_pkg.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_st_sink_bfm.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/verbosity_pkg.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_reset_source.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/verbosity_pkg.sv"
   vlog -sv "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/altera_avalon_clock_source.sv"
   vlog "$QSYS_SIMDIR/sonic_monitor_tb/simulation/submodules/sonic_monitor_tb_sonic_monitor_inst.v"
   vlog "$QSYS_SIMDIR/sonic_monitor_tb/simulation/sonic_monitor_tb.v"
}

# -----------------------------------------
# Elaborate top level design
alias elab "
vsim -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver $TOP_LEVEL_NAME
"

# -----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug "
vsim -novopt -t ps -L work -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver -L stratixiv_ver $TOP_LEVEL_NAME
"

# -----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
dev_com
com
elab
"

# -----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
dev_com
com
elab_debug
"

# -----------------------------------------
# Print out user commmand line aliases
alias h {
echo "List Of Command Line Aliases"
echo 
echo "dev_com                       -- Compile device library files"
echo 
echo "com                           -- Compile the design files in correct order"
echo 
echo "elab                          -- Elaborate top level design"
echo 
echo "elab_debug                    -- Elaborate the top level design with novopt option"
echo 
echo "ld                            -- Compile all the design files and elaborate the top level design"
echo 
echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
echo 
echo 
echo 
echo "List Of Variables"
echo 
echo "TOP_LEVEL_NAME                -- Top level module name."
echo 
echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
echo 
echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
}
h
