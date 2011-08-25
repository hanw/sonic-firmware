# (C) 2001-2011 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


# (C) 2001-2010 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and other 
# software and tools, and its AMPP partner logic functions, and any output 
# files any of the foregoing (including device programming or simulation 
# files), and any associated documentation or information are expressly subject 
# to the terms and conditions of the Altera Program License Subscription 
# Agreement, Altera MegaCore Function License Agreement, or other applicable 
# license agreement, including, without limitation, that your use is for the 
# sole purpose of programming logic devices manufactured by Altera and sold by 
# Altera or its authorized distributors.  Please refer to the applicable 
# agreement for further details.


## Generated SDC file "test.out.sdc"

## Copyright (C) 1991-2009 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 9.1 Internal Build 208 09/15/2009 SJ Full Version"

## DATE    "Tue Sep 29 14:52:00 2009"

##
## DEVICE  "EP4S40G5H40I1"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************
create_clock -name {xgmii_tx_clk} -period 6.400 -waveform { 0.000 3.200 } [get_ports {xgmii_tx_clk}]
create_clock -name {phy_mgmt_clk}   -period 20.00 -waveform { 0.000 10.000 } [get_ports {phy_mgmt_clk}]
create_clock -name {pll_ref_clk} -period 1.552 -waveform { 0.000 0.776  } [get_ports {ref_clk}]
#derive_pll_clocks

derive_pll_clocks -create_base_clocks
#derive_clocks -period "1.0"

#**************************************************************
# Create Generated Clock
#**************************************************************
create_generated_clock -name pll_mac_clk -source [get_pins -compatibility_mode {*altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name pma_tx_clk -source [get_pins -compatibility_mode {*siv_alt_pma|pma_direct|auto_generated|transmit_pcs0|clkout}] 
#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

derive_clock_uncertainty
set_clock_uncertainty -from [get_clocks {*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout}] -to pll_ref_clk -setup 0.1
set_clock_uncertainty -from [get_clocks {*siv_alt_pma|pma_direct|auto_generated|transmit_pcs0|clkout}] -to pll_ref_clk -setup 0.08
set_clock_uncertainty -from [get_clocks {*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout}] -to pll_ref_clk -hold 0.1
set_clock_uncertainty -from [get_clocks {*siv_alt_pma|pma_direct|auto_generated|transmit_pcs0|clkout}] -to pll_ref_clk -hold 0.08
#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************
set_clock_groups -exclusive -group phy_mgmt_clk -group xgmii_tx_clk -group [get_clocks {*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout}] -group [get_clocks {*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout}] -group [get_clocks {*pll_siv_xgmii_clk|altpll_component|auto_generated|pll1|clk[0]}] 
#**************************************************************
# Set False Path
#**************************************************************
set_false_path -from {*siv_10gbaser_xcvr*clk_reset_ctrl|rx_pma_rstn} -to [get_clocks {{*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout} {*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout} {*pll_siv_xgmii_clk|altpll_component|auto_generated|pll1|clk[0]} mgmt_clk xgmii_tx_clk}]
set_false_path -from {*siv_10gbaser_xcvr*clk_reset_ctrl|rx_usr_rstn} -to [get_clocks {{*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout} {*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout}  {*pll_siv_xgmii_clk|altpll_component|auto_generated|pll1|clk[0]} mgmt_clk xgmii_tx_clk}]
set_false_path -from {*siv_10gbaser_xcvr*clk_reset_ctrl|tx_pma_rstn} -to [get_clocks {{*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout} {*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout}  {*pll_siv_xgmii_clk|altpll_component|auto_generated|pll1|clk[0]} mgmt_clk xgmii_tx_clk}]
set_false_path -from {*siv_10gbaser_xcvr*clk_reset_ctrl|tx_usr_rstn} -to [get_clocks {{*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout} {*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout}  {*pll_siv_xgmii_clk|altpll_component|auto_generated|pll1|clk[0]} mgmt_clk xgmii_tx_clk}]
set_false_path -from {*siv_10gbaser_xcvr*rx_analog_rst_lego|rinit} -to [get_clocks {{*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout} {*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout}  {*pll_siv_xgmii_clk|altpll_component|auto_generated|pll1|clk[0]} mgmt_clk xgmii_tx_clk}]
set_false_path -from {*siv_10gbaser_xcvr*rx_digital_rst_lego|rinit} -to [get_clocks {{*siv_alt_pma|pma_ch*.pma_direct|receive_pcs*|clkout} {*siv_alt_pma|pma_ch*.pma_direct|transmit_pcs*|clkout}  {*pll_siv_xgmii_clk|altpll_component|auto_generated|pll1|clk[0]} mgmt_clk xgmii_tx_clk}]

#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

