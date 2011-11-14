VLOG    = /home/hwang/altera/10.1sp1/modelsim_ase/linuxaloem/vlog 
VLOGOPS = -source -sv +incdir+../../common/testbench/+../../common/incremental_compile_module+../../pcie_altera/top_examples/chaining_dma/+..+.
HDL_DIR = ../../../../xcvr_10g/
SONIC_DIR = ../

##
# sonic hdl files
##
SONIC_SRC = $(HDL_DIR)custom_avalon_master.v \
			$(HDL_DIR)sonic_eth_mdio.v\
			$(HDL_DIR)prbs_checker.v\
			$(HDL_DIR)prbs_generator.v\
			$(HDL_DIR)prbs_poly.v\
			$(HDL_DIR)xcvr.v\
			$(HDL_DIR)xcvr_pll.v \
			$(HDL_DIR)stp_pll.v\
			$(HDL_DIR)DataGenerator_40bit.sv \
			$(HDL_DIR)ALTGXReset.sv \
			$(HDL_DIR)reconfig.v\
			$(HDL_DIR)transceiver_top.sv\
			$(SONIC_DIR)sonic_upstream_gearbox.sv\
			$(SONIC_DIR)sonic_downstream_gearbox.sv\
			$(SONIC_DIR)sonic_constants.sv\
			$(SONIC_DIR)sonic_dpram_async_64_128.v\
			$(SONIC_DIR)sonic_dpram_async_128_64.v\
			$(SONIC_DIR)sonic_common_gray_clock_crosser.sv\
			$(SONIC_DIR)sonic_common_logic_vector_delay.sv\
			$(SONIC_DIR)sonic_common_fifo_usedw_calculator.sv\
			$(SONIC_DIR)sonic_rx_circular_buffer.sv\
			$(SONIC_DIR)sonic_irq_generator.sv\
			$(SONIC_DIR)sonic_irq_prg_reg.sv\
			$(SONIC_DIR)sonic_rx_ctl.sv\
			$(SONIC_DIR)sonic_cmd_ctl.sv\
			$(SONIC_DIR)sonic_cmd_prg_reg.sv\
			$(SONIC_DIR)sonic_rc_update.sv\
			$(SONIC_DIR)sonic_common_signal_clock_crosser.sv\
			$(SONIC_DIR)sonic_tx_circular_buffer.sv\
			$(SONIC_DIR)sonic_tx_ctl.sv\
			../sonic_top_wrapper.sv\
			../../../top.v\
			../top_plus.v\
			../top_rs_hip.v\
			../../../top_core.vo\
			./sonictb_bfm_driver_chaining.v\
			./altpcietb_bfm_driver_chaining.v\
			../../../top_serdes.v\
			../../common/testbench/altpcietb_bfm_rpvar_64b_x8_gen2_pipen1b.vo\
			./sonic_chaining_testbench.v\
			../sonic_top.sv\
			../sonic_dma_descriptor.sv\
			../altpcierd_cpld_rx_buffer.v\
			../sonic_dma_dt.sv\
			../sonic_dma_prg_reg.sv\
			../sonic_application_wrapper.sv\
			../sonic_read_dma_requester_128.sv\
			../sonic_write_dma_requester_128.sv\
			../sonic_rc_slave.sv\
			../altpcierd_reconfig_clk_pll.v\
			../sonic_application_logic.sv\
			../altpcierd_rx_ecrc_64.vo\
			../altpcierd_rx_ecrc_128.vo\
			../altpcierd_tx_ecrc_64.vo\
			../altpcierd_tx_ecrc_128.vo\
			../altpcierd_cdma_ecrc_gen_calc.v\
			../altpcierd_cdma_ecrc_check_128.v\
			../altpcierd_cdma_ecrc_check_64.v\
			../altpcierd_cdma_ecrc_gen_ctl_128.v\
			../altpcierd_cdma_ecrc_gen_ctl_64.v\
			../altpcierd_cdma_ecrc_gen_datapath.v\
			../altpcierd_cdma_ecrc_gen.v\
			../altpcierd_cdma_ast_rx_64.v\
			../altpcierd_cdma_ast_tx_64.v\
			../altpcierd_cdma_ast_tx_128.v\
			../altpcierd_cdma_ast_rx_128.v\
			../altpcierd_cdma_ast_msi.v\
			../altpcierd_cdma_ast_tx.v\
			../altpcierd_cdma_ast_rx.v\
			../altpcierd_compliance_test.v\
			../altpcierd_tx_ecrc_ctl_fifo.v\
			../altpcierd_tx_ecrc_data_fifo.v\
			../altpcierd_tx_ecrc_fifo.v\
			../altpcierd_cplerr_lmi.v\
			../sonic_rxtx_downstream_intf.sv\
			../altpcierd_ast256_downstream.v\
			../sonic_reg_access.sv\
			../altpcierd_tl_cfg_sample.v\
			../altpcierd_pcie_reconfig_initiator.v\
			../altpcierd_npcred_monitor.v\
			../../common/testbench/altpcie_phasefifo.v\
			../../common/testbench/altpcie_pll_125_250.v\
			../../common/testbench/altpcie_pll_100_250.v\
			../../common/testbench/altpcie_pll_100_125.v\
			../../common/testbench/altpcie_pll_phy0.v\
			../../common/testbench/altpcie_pll_phy1_62p5.v\
			../../common/testbench/altpcie_pll_phy2.v\
			../../common/testbench/altpcie_pll_phy3_62p5.v\
			../../common/testbench/altpcie_pll_phy4_62p5.v\
			../../common/testbench/altpcie_pll_phy5_62p5.v\
			../../common/testbench/altpcie_pclk_align.v\
			../../common/testbench/altpcie_pclk_pll.v\
			../../common/testbench/altpcie_rs_serdes.v\
			../../common/testbench/altpcietb_bfm_log_common.v\
			../../common/testbench/altpcietb_bfm_req_intf_common.v\
			../../common/testbench/altpcietb_bfm_rp_top_x8_pipen1b.v\
			../../common/testbench/altpcietb_bfm_shmem_common.v\
			../../common/testbench/altpcietb_bfm_vc_intf.v\
			../../common/testbench/altpcietb_pipe_phy.v\
			../../common/testbench/altpcietb_rst_clk.v\
			../../common/testbench/altpcietb_ltssm_mon.v\
			../../common/testbench/altpcietb_pipe_xtx2yrx.v\
			../../common/testbench/altpcie_reconfig_4sgx.v\
			../../common/testbench/altpcie_reconfig_3cgx.v\
	##
# Testbench HDL file
##
TB_SRC_DIR = ./
SONIC_TB_SRC =  $(TB_SRC_DIR)sonic_chaining_testbench.v\
#				$(TB_SRC_DIR)test_netlogic_reconfig.sv \
#				$(TB_SRC_DIR) test_transceiver_top.sv\
#				$(TB_SRC_DIR)top.sv \

SIM_LIBS = -L altera_mf_ver -L lpm_ver -L sgate_ver -L stratixiv_hssi_ver -L stratixiv_pcie_hip_ver

#
SIMULATE_TARGET = sonic_chaining_testbench

#######################################
all: simsonic

clean:
	rm -rf .deps
	rm -rf *_lib
	rm -rf work
.deps: 
	mkdir .deps > /dev/null 2>&1

work:
	vlib work

libs: work

sonic: .deps work .deps/sonic
.deps/sonic: $(SONIC_SRC)  
	@echo --
	@echo building SONIC
	@echo --
	$(VLOG) $(VLOGOPS) -work work $^
	touch .deps/sonic

sonic_tb: .deps work .deps/sonic .deps/sonic_tb
.deps/sonic_tb: $(SONIC_TB_SRC)
	@echo --
	@echo building SONIC Testbench
	@echo --
	$(VLOG) $(VLOGOPS) -work work  $^
	touch .deps/sonic_tb

simsonic: sonic sonic_tb
	vsim -title "SoNIC Test" $(SIM_LIBS) -do wave.do -lib work $(SIMULATE_TARGET)
