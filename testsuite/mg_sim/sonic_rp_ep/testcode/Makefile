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

DESIGN_OBJS := 	sonic_application_core_logic.sv \
		sonic_application_streaming_port.sv \
		sonic_application_top.sv \
		sonic_single_port_logic.sv \
		sonic_top.sv \
		sonic_top_wrapper.sv \
		altpcierd_cdma_app_icm.v \
		altpcierd_cdma_ast_msi.v \
		altpcierd_cdma_ast_rx_128.v \
		altpcierd_cdma_ast_rx_64.v \
		altpcierd_cdma_ast_rx.v \
		altpcierd_cdma_ast_tx_128.v \
		altpcierd_cdma_ast_tx_64.v \
		altpcierd_cdma_ast_tx.v \
		top_example_chaining_pipen1b.v \
		top_plus.v \
		top_rs_hip.v \
		altpcierd_cpld_rx_buffer.v

		#../lib/altpcietb_bfm_ep_example_chaining_pipen1b.vo \
		../lib/altpcietb_bfm_driver_rp.v 
SIM_OBJS := \
		../lib/altpcietb_bfm_driver_chaining.v \
		../lib/altpcietb_bfm_vc_intf_128.v \
		../lib/altpcietb_bfm_vc_intf_ast.v \
		../lib/altpcietb_bfm_rp_gen2_x8.v \
		../lib/sonic_hard_ip_custom.sv \
		sonic_rp_top.sv \
		sonic_fast_sim_top.sv \

SHARED_PATH := ../../../../lib/shared
SONIC_PATH := ../../../../lib/sonic
DESIGN_PATH := ../../../../designs/sonic_xg_blocksync
SIM_PATH := ..
QSYS_SIMDIR := ../sonic_rp_ep_sim/testbench

INCLUDE_PATH := ../../../../lib/shared+$(SIM_PATH)/../lib/

TLM_SRC := pci_tlm
TB_SRC := test_program.sv top.sv

VLOG_OPTIONS := +define+SYNTHESIS=1 +define+DISABLE_ALTERA_AVALON_SIM_SVA +incdir+$(INCLUDE_PATH) #-dpiheader dpiheader.h
VLOG := /home/hwang/altera/11.0/modelsim_ae/linuxaloem/vlog
VSIM := /home/hwang/altera/11.0/modelsim_ae/linuxaloem/vsim
MODELSIM_INC := /home/hwang/altera/11.0/modelsim_ae/include/

.PHONY: all clean VLIB TLM TESTBENCH

all: VLIB $(SHARED_OBJS) $(SONIC_OBJS) $(DESIGN_OBJS) $(SIM_OBJS)
	vsim -sv_lib pci_tlm -do "source $(QSYS_SIMDIR)/msim_setup.tcl; \
				  set QSYS_SIMDIR $(QSYS_SIMDIR); \
				  dev_com; \
				  com; \
				  $(VLOG) $(VLOG_OPTIONS) -sv $(TB_SRC); \
				  source msim.tcl; \
				  mon_com; \
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
