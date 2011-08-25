// (C) 2001-2011 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


//
// Top-level definitions for transceiver reconfig IP
//
// $Header$
//
// PACKAGE DECLARATION
package alt_xcvr_reconfig_h;

	////////////////////////////////////////////////////////
	// Top-level register map for transceiver reconfig IP
	////////////////////////////////////////////////////////
	localparam W_XR_ADDR = 7;		// address width on mgmt interface
	localparam W_XR_FEATURE_LADDR = 3; // address width of standard feature block, and basic logical interface
	typedef bit [W_XR_ADDR         -1:0] t_xreconf_addr;
	typedef bit [W_XR_FEATURE_LADDR-1:0] t_xr_feature_addr;

	// Each feature block is allocated an 8-word address range
	localparam [W_XR_ADDR-1:0] ADDR_XR_OFFSET_BASE = t_xreconf_addr'(0 << W_XR_FEATURE_LADDR);
	localparam [W_XR_ADDR-1:0] ADDR_XR_ANALOG_BASE = t_xreconf_addr'(1 << W_XR_FEATURE_LADDR);
	localparam [W_XR_ADDR-1:0] ADDR_XR_EYEMON_BASE = t_xreconf_addr'(2 << W_XR_FEATURE_LADDR);
	localparam [W_XR_ADDR-1:0] ADDR_XR_DFE_BASE    = t_xreconf_addr'(3 << W_XR_FEATURE_LADDR);
	localparam [W_XR_ADDR-1:0] ADDR_XR_DIRECT_BASE = t_xreconf_addr'(4 << W_XR_FEATURE_LADDR);
	localparam [W_XR_ADDR-1:0] ADDR_XR_END_BASE    = t_xreconf_addr'(5 << W_XR_FEATURE_LADDR);	// must always mark end of address space


	////////////////////////////////////////////////////////
	// Offset Cancellation block addresses
	////////////////////////////////////////////////////////
	localparam [W_XR_ADDR-1:0] ADDR_XR_OFFSET_STATUS = t_xreconf_addr'(ADDR_XR_OFFSET_BASE + 0);


	////////////////////////////////////////////////////////
	// Analog block addresses
	////////////////////////////////////////////////////////
	localparam [W_XR_ADDR-1:0] ADDR_XR_ANALOG_LCH    = t_xreconf_addr'(ADDR_XR_ANALOG_BASE + 0);
	localparam [W_XR_ADDR-1:0] ADDR_XR_ANALOG_PCH    = t_xreconf_addr'(ADDR_XR_ANALOG_BASE + 1);
	localparam [W_XR_ADDR-1:0] ADDR_XR_ANALOG_STATUS = t_xreconf_addr'(ADDR_XR_ANALOG_BASE + 2);
	localparam [W_XR_ADDR-1:0] ADDR_XR_ANALOG_OFFSET = t_xreconf_addr'(ADDR_XR_ANALOG_BASE + 3);
	localparam [W_XR_ADDR-1:0] ADDR_XR_ANALOG_DATA   = t_xreconf_addr'(ADDR_XR_ANALOG_BASE + 4);

	// Analog internal register offsets
	// These are to be written to the analog offset address register, ADDR_XR_ANALOG_OFFSET
	localparam XR_ANALOG_OFFSET_VOD = 0;
	localparam XR_ANALOG_OFFSET_PREEMPH0T = 1;
	localparam XR_ANALOG_OFFSET_PREEMPH1T = 2;
	localparam XR_ANALOG_OFFSET_PREEMPH2T = 3;
	localparam XR_ANALOG_OFFSET_RXDCGAIN = 16;
	localparam XR_ANALOG_OFFSET_RXEQCTRL = 17;
   	localparam XR_ANALOG_OFFSET_PRECDRLPBK = 32;
   	localparam XR_ANALOG_OFFSET_POSTCDRLPBK = 33;   

	////////////////////////////////////////////////////////
	// Eyemon block addresses
	////////////////////////////////////////////////////////
	localparam [W_XR_ADDR-1:0] ADDR_XR_EYEMON_LCH     = t_xreconf_addr'(ADDR_XR_ANALOG_LCH    + (ADDR_XR_EYEMON_BASE - ADDR_XR_ANALOG_BASE));
	localparam [W_XR_ADDR-1:0] ADDR_XR_EYEMON_PCH     = t_xreconf_addr'(ADDR_XR_ANALOG_PCH    + (ADDR_XR_EYEMON_BASE - ADDR_XR_ANALOG_BASE));
	localparam [W_XR_ADDR-1:0] ADDR_XR_EYEMON_CONTROL = t_xreconf_addr'(ADDR_XR_ANALOG_STATUS + (ADDR_XR_EYEMON_BASE - ADDR_XR_ANALOG_BASE));
	localparam [W_XR_ADDR-1:0] ADDR_XR_EYEMON_OFFSET  = t_xreconf_addr'(ADDR_XR_ANALOG_OFFSET + (ADDR_XR_EYEMON_BASE - ADDR_XR_ANALOG_BASE));
	localparam [W_XR_ADDR-1:0] ADDR_XR_EYEMON_DATA    = t_xreconf_addr'(ADDR_XR_ANALOG_DATA   + (ADDR_XR_EYEMON_BASE - ADDR_XR_ANALOG_BASE));


	////////////////////////////////////////////////////////
	// Basic block addresses (internal, private addresses)
	////////////////////////////////////////////////////////
	// The 'basic' interface block is the switch that routes requests to
	// an appropriate physical reconfiguration interface.  A logical channel
	// number acts as a channel ID, which allows the basic block to find
	// the corresponding physical reconfiguration interface, and a physical
	// channel index within a physical interface.
	//
	// The Basic (B) block features are also available via the direct access block.
	// All users of the basic block, including the direct access block, must
	// acquire appropriate semaphores before using an interface, and release
	// the semaphores when done, to avoid locking out other feature blocks.
	localparam [W_XR_FEATURE_LADDR-1:0] ADDR_XCVR_RECONFIG_BASIC_MUTEX            = t_xr_feature_addr'(0);
	localparam [W_XR_FEATURE_LADDR-1:0] ADDR_XCVR_RECONFIG_BASIC_LOGICAL_CHANNEL  = t_xr_feature_addr'(1);
	localparam [W_XR_FEATURE_LADDR-1:0] ADDR_XCVR_RECONFIG_BASIC_PHYSICAL_CHANNEL = t_xr_feature_addr'(2);
	localparam [W_XR_FEATURE_LADDR-1:0] ADDR_XCVR_RECONFIG_BASIC_CONTROL          = t_xr_feature_addr'(3);
	localparam [W_XR_FEATURE_LADDR-1:0] ADDR_XCVR_RECONFIG_BASIC_OFFSET_ADDR      = t_xr_feature_addr'(4);
	localparam [W_XR_FEATURE_LADDR-1:0] ADDR_XCVR_RECONFIG_BASIC_DATA             = t_xr_feature_addr'(5);


	////////////////////////////////////////////////////////
	// Direct Access & Basic block addresses
	////////////////////////////////////////////////////////
	//
	// The minimum steps to read & write a reconfiguration word are the following:
	//  Step 1  - acquire basic arbiter lock (write 1 to ADDR_XR_DIRECT_ARB_ACQ)
	//  Step 2  - write logical channel number to ADDR_XR_DIRECT_LCH
	//  Step 3  - acquire channel lock
	//       3a - request channel lock (write XR_DIRECT_CONTROL_PHYS_LOCK_SET to ADDR_XR_DIRECT_CONTROL)
	//       3b - confirm channel lock (read ADDR_XR_DIRECT_CONTROL, mask with XR_DIRECT_STATUS_BITMASK_PHYS_LOCK_GRANTED)
	//          -- repeat step 3b until result after applying mask is != 0
	//  Step 4  - write channel offset address to ADDR_XR_DIRECT_OFFSET
	//  Step 5  - read existing value from reconfig space, modify, then write back
	//       5a (read cycle part 1)  - write XR_DIRECT_CONTROL_RECONF_READ to ADDR_XR_DIRECT_CONTROL
	//       5b (read cycle part 2)  - read data from ADDR_XR_DIRECT_DATA
	//       5c (write cycle part 1) - write modified value to ADDR_XR_DIRECT_DATA
	//       5d (write cycle part 2) - write XR_DIRECT_CONTROL_RECONF_WRITE to ADDR_XR_DIRECT_CONTROL
	//          -- addtional read-modify-write cycles, repeat from step 2 or 4 (can skip step 3a)
	//  Step 6  - release channel lock (write XR_DIRECT_CONTROL_PHYS_LOCK_CLEAR to ADDR_XR_DIRECT_CONTROL)
	//  Step 7  - release basic arbiter lock (write 0 to ADDR_XR_DIRECT_ARB_ACQ)
	//
	// Direct/Basic register bitmap ---------------------------------------------------------
	// word addr            wr/rd                description
	//    ------------------------------------------------------
	//      0                wr                 basic arbiter, 1 to request access, 0 to release lock
	//      1               wr/rd               logical channel number
	//      2                rd                 physical channel number.  When lower 3 bits are 3'b111, means ch is not present
	//      3               wr/rd               status/control -- see XR_DIRECT_CONTROL_* opcodes and XR_DIRECT_STATUS_* bitfield definitions
	//      4               wr/rd               offset_addr  -- for opcode-based reads & writes
	//      5               wr/rd               data         -- for opcode-based reads & writes
	//      6                --                 reserved
	//      7                --                 reserved
	localparam [W_XR_ADDR-1:0] ADDR_XR_DIRECT_ARB_ACQ = t_xreconf_addr'(ADDR_XR_DIRECT_BASE + 0); // write 1 to request B access, 0 to release
	localparam [W_XR_ADDR-1:0] ADDR_XR_DIRECT_LCH     = t_xreconf_addr'(ADDR_XR_DIRECT_BASE + ADDR_XCVR_RECONFIG_BASIC_LOGICAL_CHANNEL);
	localparam [W_XR_ADDR-1:0] ADDR_XR_DIRECT_PCH     = t_xreconf_addr'(ADDR_XR_DIRECT_BASE + ADDR_XCVR_RECONFIG_BASIC_PHYSICAL_CHANNEL);
	localparam [W_XR_ADDR-1:0] ADDR_XR_DIRECT_CONTROL = t_xreconf_addr'(ADDR_XR_DIRECT_BASE + ADDR_XCVR_RECONFIG_BASIC_CONTROL);
	localparam [W_XR_ADDR-1:0] ADDR_XR_DIRECT_OFFSET  = t_xreconf_addr'(ADDR_XR_DIRECT_BASE + ADDR_XCVR_RECONFIG_BASIC_OFFSET_ADDR);
	localparam [W_XR_ADDR-1:0] ADDR_XR_DIRECT_DATA    = t_xreconf_addr'(ADDR_XR_DIRECT_BASE + ADDR_XCVR_RECONFIG_BASIC_DATA);

	// Opcode values for writes to control word, ADDR_XR_DIRECT_CONTROL
	localparam XR_DIRECT_CONTROL_RECONF_WRITE = 32'b0000;	// reconfig space: write current DATA to OFFSET addr (as physical addr or ch offset addr)
	localparam XR_DIRECT_CONTROL_RECONF_READ  = 32'b0001;	// reconfig space: read from OFFSET_ADDR, save result in DATA
	localparam XR_DIRECT_CONTROL_LADDR_SET  = 32'b0010;	// interpret OFFSET_ADDR as logical addr, with automatic ch addr offset
	localparam XR_DIRECT_CONTROL_PADDR_SET  = 32'b0011;	// interpret OFFSET_ADDR as physical addr, with no automatic addr offset
	localparam XR_DIRECT_CONTROL_PHYS_LOCK_CLEAR = 32'b0100;	// clear lock request for current channel
	localparam XR_DIRECT_CONTROL_PHYS_LOCK_SET   = 32'b0101;	// set lock request for current channel
	localparam XR_DIRECT_CONTROL_ADDR_AUTO_INCR_CLEAR = 32'b0110;	// clear auto-write-and-address-increment mode for data writes
	localparam XR_DIRECT_CONTROL_ADDR_AUTO_INCR_SET   = 32'b0111;	// set auto-write-and-address-increment mode for data writes
	localparam XR_DIRECT_CONTROL_INTERNAL_WRITE = 32'b1000;	// Internal registers, mainly testbus control
	//localparam XR_DIRECT_CONTROL_INTERNAL_READ  = 32'b1001;	// internal reg space: read from OFFSET_ADDR, save result in DATA
	localparam XR_DIRECT_CONTROL_TABLE_READ  = 32'b1011;	// ROM table lookup, especially for PLL and clock mux remapping

	// Read of control/status reg returns this bitfield data
	localparam XR_DIRECT_STATUS_BITMASK_PHYS_LOCK_GRANTED = 32'b0001;	// on read, bit 0 is grant status
	localparam XR_DIRECT_STATUS_BITMASK_PHYS_LOCK_REQUESTED = 32'b0010;	// on read, bit 1 is physical lock request flag
	localparam XR_DIRECT_STATUS_BITMASK_USING_PHYS_ADDR = 32'b0100;	// on read, bit 2 is physical addr mode indicator (0 mean logical addr)
	localparam XR_DIRECT_STATUS_BITMASK_USING_ADDR_AUTO_INCR = 32'b1000;	// on read, bit 3 is auto-write-and-addr-incr mode indicator

	// Internal registers, for read/write via these opcodes: XR_DIRECT_CONTROL_INTERNAL_*
	localparam XR_DIRECT_OFFSET_TESTBUS_SEL = 2'd0;	// internal register for testbus sel
	localparam XR_DIRECT_OFFSET_TESTBUS_ADCE = 2'd1;	// internal register for ADCE capture and standby
	localparam XR_DIRECT_OFFSET_HARDOC_CALEN = 2'd2;	// internal register for hard OC cal enable
	localparam XR_DIRECT_BITMASK_TESTBUS_ADCE_CAPTURE = 32'b01;	// bitfield position of ADCE capture, within TESTBUS_ADCE reg
	localparam XR_DIRECT_BITMASK_TESTBUS_ADCE_STANDBY = 32'b10;	// bitfield position of ADCE standby, within TESTBUS_ADCE reg

endpackage
