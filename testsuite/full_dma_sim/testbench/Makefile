SHARED_OBJS := 	dma/sonic_write_dma_requester_128.sv \
		dma/sonic_dma_dt.sv \
		dma/sonic_dma_descriptor.sv \
		dma/sonic_dma_prg_reg.sv \
		dma/sonic_read_dma_requester_128.sv \
		eth/sonic_gearbox_66_40.sv \
		eth/sonic_gearbox_40_66.sv \
		circbuf/sonic_sync_ring_128_2.sv \
		circbuf/sonic_sync_ring_2_128.sv \
		circbuf/sonic_ring_mmap.sv \
		circbuf/sonic_translate_address.sv \
		circbuf/sonic_rx_circular_buffer.sv \
		circbuf/sonic_rx_ctl_66.sv \
		circbuf/sonic_tx_circular_buffer.sv \
		circbuf/sonic_tx_circular_buffer_66.sv \
		circbuf/sonic_rx_circular_buffer_66.sv \
		circbuf/sonic_tx_ctl_66.sv \
		circbuf/sonic_calc_address.sv \
		sonic_arbiter_one.sv \
		sonic_blocksync_xg.sv \
		sonic_cmd_ctl.sv \
		sonic_cmd_prg_reg.sv \
		sonic_common_fifo_usedw_calculator.sv \
		sonic_common_gray_clock_crosser.sv \
		sonic_common_logic_vector_delay.sv \
		sonic_common_package.sv \
		sonic_common_signal_clock_crosser.sv \
		sonic_constants.sv \
		sonic_irq_ctl.sv \
		sonic_irq_generator.sv \
		sonic_irq_prg_reg.sv \
		sonic_rc_slave.sv \
		sonic_rc_update.sv \
		sonic_reg_access.sv \
		sonic_rx_chan_66.sv \
		sonic_rx_ctl.sv \
		sonic_rxtx_downstream_intf.sv \
		sonic_rxtx_loopback.sv \
		sonic_tx_chan_66.sv \
		sonic_tx_ctl.sv 

SONIC_OBJS := 	ram/sonic_dpram_async_128_64.v \
		ram/sonic_dpram_async_2_64.v \
		ram/sonic_dpram_async_64_128.v \
		ram/sonic_dpram_async_64_2.v \
		pcie/top_core.v \
		pcie/top_serdes.v \
		pcie/top.v \
		multadd/sonic_mult_add.v

DESIGN_OBJS := sonic_application_streaming_port.sv \
		sonic_application_top.sv \
		sonic_single_port_logic.sv \
		sonic_top.sv \
		sonic_top_wrapper.sv \
		altpcierd_cdma_ast_msi.v \
		altpcierd_cdma_ast_rx_128.v \
		altpcierd_cdma_ast_rx_64.v \
		altpcierd_cdma_ast_rx.v \
		altpcierd_cdma_ast_tx_128.v \
		altpcierd_cdma_ast_tx_64.v \
		altpcierd_cdma_ast_tx.v \
		altpcierd_cpld_rx_buffer.v \
		top_plus.v \
		top_rs_hip.v

SIM_OBJS := altpcietb_bfm_rp_top_x8_pipen1b.v \
			altpcietb_bfm_vc_intf.v \
			altpcietb_pipe_phy.v \
			altpcietb_bfm_rpvar_64b_x8_gen2_pipen1b.vo \
	        altpcietb_rst_clk.v \
			altpcietb_bfm_shmem_common.v \
			altpcietb_bfm_log_common.v \
			altpcietb_ltssm_mon.v \
			altpcietb_pipe_xtx2yrx.v \
			altpcierd_reconfig_clk_pll.v \
			altpcietb_bfm_req_intf_common.v

EXTRA_OBJS := altpcierd_cplerr_lmi.v \
			altpcierd_tl_cfg_sample.v \

IP_OBJS := altpcie_pll_100_250.v \
			altpcie_pll_125_250.v \
			altpcie_reconfig_4sgx.v \
			altpcie_rs_serdes.v \
			../top_core.vo

VC_OBJS := 	sonic_vc.v \
		submodules/sonic_vc_multiplexer_0.v \
		submodules/sonic_vc_demultiplexer_0.v \
		submodules/altera_reset_controller.v \
		submodules/altera_reset_synchronizer.v \
		submodules/sonic_vc_tx_fifo_p0.v \
		submodules/sonic_vc_tx_fifo_p1.v \
		submodules/sonic_vc_timing_adapter_fifo.v \
		submodules/sonic_vc_timing_adapter.v \
		submodules/sonic_vc_multiplexer_adapter.v \
		submodules/sonic_vc_tx_fifo_p0_adapter_fifo.v \
		submodules/sonic_vc_tx_fifo_p0_adapter.v \
		submodules/sonic_vc_rx_fifo_in_adapter_fifo.v \
		submodules/sonic_vc_rx_fifo_in_adapter.v \
		submodules/sonic_vc_rx_fifo_p0_adapter.v \
		submodules/sonic_vc_rx_fifo_p0.v \
		submodules/sonic_vc_rx_fifo_p1_adapter.v 


SHARED_PATH := ../../../lib/shared
SONIC_PATH := ../../../lib/sonic
DESIGN_PATH := ../../../designs/sonic_xg_blocksync
SIM_PATH := ../../../lib/sonic/common/testbench
EXTRA_PATH := ../../../lib/sonic/pcie/examples/sonic_chaining_dma
IP_PATH := ../../../lib/sonic/pcie/ip_compiler_for_pci_express-library
QSYS_SIMDIR := ../sonic_rp_ep_sim/testbench
VC_PATH := ../../../lib/sonic/vc/sonic_vc/synthesis/

INCLUDE_PATH := ../../../lib/shared/+../../../lib/sonic/common/testbench/+../../../lib/sonic/ram/

TLM_SRC := pci_tlm
TB_SRC := sonictb_bfm_driver_chaining.sv sonic_chaining_testbench.v 

VLOG_OPTIONS := +define+SYNTHESIS=1 +incdir+$(INCLUDE_PATH) -novopt -work work #-dpiheader dpiheader.h
#VLOG := /home/hwang/altera/11.0/modelsim_ae/linuxaloem/vlog
#VSIM := /home/hwang/altera/11.0/modelsim_ae/linuxaloem/vsim
VLOG := /home/hwang/questasim/install/questa_sim/linux/vlog
VSIM := /home/hwang/questasim/install/questa_sim/linux/vsim
#MODELSIM_INC := /home/hwang/altera/11.0/modelsim_ae/include/
MODELSIM_INC := /home/hwang/questasim/install/questa_sim/include/

.PHONY: all clean VLIB TLM TESTBENCH

				  #mon_com;
all: VLIB $(SHARED_OBJS) $(SONIC_OBJS) $(DESIGN_OBJS) $(SIM_OBJS) $(EXTRA_OBJS) $(IP_OBJS) $(VC_OBJS)
	vsim -sv_lib pci_tlm -do " \
				  $(VLOG) $(VLOG_OPTIONS) -sv $(TB_SRC); \
				  source msim.tcl; \
				  elab_top; \
				  do wave.do; \
				  "
clean:
	rm -r work altera_ver altera_lnsim_ver lpm_ver sgate_ver altera_mf_ver stratixiv_hssi_ver stratixiv_pcie_hip_ver stratixiv_ver *.o *.so

$(SHARED_OBJS): 
	$(VLOG) $(VLOG_OPTIONS) -sv $(SHARED_PATH)/$@

$(SONIC_OBJS): 
	$(VLOG) $(VLOG_OPTIONS) -sv $(SONIC_PATH)/$@

$(DESIGN_OBJS):
	$(VLOG) $(VLOG_OPTIONS) -sv $(DESIGN_PATH)/$@

$(SIM_OBJS):
	$(VLOG) $(VLOG_OPTIONS) -sv $(SIM_PATH)/$@

$(EXTRA_OBJS):
	$(VLOG) $(VLOG_OPTIONS) -sv $(EXTRA_PATH)/$@

$(IP_OBJS):
	$(VLOG) $(VLOG_OPTIONS) -sv $(IP_PATH)/$@

$(VC_OBJS):
	$(VLOG) $(VLOG_OPTIONS) -sv $(VC_PATH)/$@

TLM: 
	gcc -m32 -c -I$(MODELSIM_INC) $(TLM_SRC).c
	ld -melf_i386 -shared -E -Bsymbolic --allow-shlib-undefined -o $(TLM_SRC).so $(TLM_SRC).o

VLIB:
	vlib work
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
	vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/altera_primitives.v" -work altera_ver
	vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/220model.v" -work lpm_ver
	vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/sgate.v" -work sgate_ver
	vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/altera_mf.v" -work altera_mf_ver
	vlog -sv "/home/hwang/altera/11.0/quartus/eda/sim_lib/altera_lnsim.sv" -work altera_lnsim_ver
	vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/stratixiv_hssi_atoms.v" -work stratixiv_hssi_ver
	vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/stratixiv_pcie_hip_atoms.v" -work stratixiv_pcie_hip_ver
	vlog "/home/hwang/altera/11.0/quartus/eda/sim_lib/stratixiv_atoms.v" -work stratixiv_ver
