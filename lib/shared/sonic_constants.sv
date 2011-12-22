//-----------------------------------------------------------------------------
// Copyright ??? 2009 Altera Corporation. All rights reserved.  Altera products are
// protected under numerous U.S. and foreign patents, maskwork rights, copyrights and
// other intellectual property laws.
//
// This reference design file, and your use thereof, is subject to and governed by
// the terms and conditions of the applicable Altera Reference Design License Agreement.
// By using this reference design file, you indicate your acceptance of such terms and
// conditions between you and Altera Corporation.  In the event that you do not agree with
// such terms and conditions, you may not use the reference design file. Please promptly
// destroy any copies you have made.
//
// This reference design file being provided on an "as-is" basis and as an accommodation
// and therefore all warranties, representations or guarantees of any kind
// (whether express, implied or statutory) including, without limitation, warranties of
// merchantability, non-infringement, or fitness for a particular purpose, are
// specifically disclaimed.  By making this reference design file available, Altera
// expressly does not recommend, suggest or require that this reference design file be
// used in combination with any other product not provided by Altera.
//-----------------------------------------------------------------------------

// PCIe Constants
// Global constant
 `define PCIE_SIM         TRUE
//-----------------------------------------------------------------------------
// TLP Packet constant
 `define TLP_FMT_4DW_W        2'b11    // TLP FMT field  -> 64 bits Write
 `define TLP_FMT_3DW_W        2'b10    // TLP FMT field  -> 32 bits Write
 `define TLP_FMT_4DW_R        2'b01    // TLP FMT field  -> 64 bits Read
 `define TLP_FMT_3DW_R        2'b00    // TLP FMT field  -> 32 bits Read

 `define TLP_FMT_CPL          2'b00    // TLP FMT field  -> Completion w/o data
 `define TLP_FMT_CPLD         2'b10    // TLP FMT field  -> Completion with data

 `define TLP_TYPE_WRITE       5'b00000 // TLP Type field -> write
 `define TLP_TYPE_READ        5'b00000 // TLP Type field -> read
 `define TLP_TYPE_READ_LOCKED 5'b00001 // TLP Type field -> read_lock
 `define TLP_TYPE_CPLD        5'b01010 // TLP Type field -> Completion with data
 `define TLP_TYPE_IO          5'b00010 // TLP Type field -> IO

 `define TLP_TC_DEFAULT       3'b000   // Default TC of the TLP
 `define TLP_TC_CLASS_CH_ZERO 3'b001   // TC class for Port 0
 `define TLP_TC_CLASS_CH_ONE  3'b101   // TC class for Port 1
 `define TLP_TD_DEFAULT       1'b0     // Default TD of the TLP
 `define TLP_EP_DEFAULT       1'b0     // Default EP of the TLP
 `define TLP_ATTR_DEFAULT     2'b0     // Default EP of the TLP

 `define RESERVED_1BIT        1'b0     // reserved bit on 1 bit
 `define RESERVED_2BIT        2'b00    // reserved bit on 1 bit
 `define RESERVED_3BIT        3'b000   // reserved bit on 1 bit
 `define RESERVED_4BIT        4'b0000  // reserved bit on 1 bit

 `define EP_ADDR_READ_OFFSET  16
 `define TRANSACTION_ID       3'b000

 `define ZERO_QWORD           64'h0000_0000_0000_0000
 `define ZERO_DWORD           32'h0000_0000
 `define ZERO_WORD            16'h0000
 `define ZERO_BYTE            8'h00

 `define ONE_QWORD            64'h0000_0000_0000_0001
 `define ONE_DWORD            32'h0000_0001
 `define ONE_WORD             16'h0001
 `define ONE_BYTE             8'h01

 `define MINUS_ONE_QWORD      64'hFFFF_FFFF_FFFF_FFFF
 `define MINUS_ONE_DWORD      32'hFFFF_FFFF
 `define MINUS_ONE_WORD       16'hFFFF
 `define MINUS_ONE_BYTE       8'hFF

 `define DIRECTION_WRITE      1
 `define DIRECTION_READ       0

 `define SONIC_REG_DMA_WR_DW0	8'h0
 `define SONIC_REG_DMA_WR_DW1	8'h4
 `define SONIC_REG_DMA_WR_DW2	8'h8
 `define SONIC_REG_DMA_WR_DW3	8'hC
 `define SONIC_REG_DMA_RD_DW0	8'h10
 `define SONIC_REG_DMA_RD_DW1	8'h14
 `define SONIC_REG_DMA_RD_DW2	8'h18
 `define SONIC_REG_DMA_RD_DW3	8'h1C

 `define SONIC_REG_DMA_WR_STATUS_HI	8'h20
 `define SONIC_REG_DMA_WR_STATUS_LO	8'h24
 `define SONIC_REG_DMA_RD_STATUS_HI	8'h28
 `define SONIC_REG_DMA_RD_STATUS_LO	8'h2C

 `define SONIC_REG_ERROR_STATUS	8'h30

 `define SONIC_REG_CNTL_DW0		8'h40
 `define SONIC_REG_CNTL_DW1		8'h44
 `define SONIC_REG_CNTL_DW2		8'h48
 `define SONIC_REG_CNTL_DW3		8'h4C

 `define SONIC_REG_CMD_DW0		8'h50
 `define SONIC_REG_CMD_DW1		8'h54
 `define SONIC_REG_CMD_DW2		8'h58
 `define SONIC_REG_CMD_DW3		8'h5C
 `define SONIC_REG_CMD_DW4		8'h60
 `define SONIC_REG_CMD_DW5		8'h64

//-----------------------------------------------
// SoNIC commands
//-----------------------------------------------
 `define SONIC_CMD_NONE				32'h00
 `define SONIC_CMD_RESET				32'h01
 `define SONIC_CMD_SET_ADDR_IRQ		32'h02
 `define SONIC_CMD_CONFIG_IRQ		32'h03
 `define SONIC_CMD_GET_RX_OFFSET		32'h10
 `define SONIC_CMD_GET_RX_OFFSET2	32'h11
 `define SONIC_CMD_GET_RX_SIZE		32'h12
 `define SONIC_CMD_GET_RX_BLOCK_SIZE	32'h13
 `define SONIC_CMD_SET_RX_BLOCK_SIZE	32'h14
 `define SONIC_CMD_GET_TX_OFFSET		32'h15
 `define SONIC_CMD_GET_TX_OFFSET2	32'h16
 `define SONIC_CMD_GET_TX_SIZE		32'h17
 `define SONIC_CMD_GET_TX_BLOCK_SIZE	32'h18
 `define SONIC_CMD_SET_TX_BLOCK_SIZE	32'h19
 `define SONIC_CMD_STOP_SFP1			32'h20
 `define SONIC_CMD_START_SFP1		32'h21
 `define SONIC_CMD_STOP_SFP2			32'h22
 `define SONIC_CMD_START_SFP2		32'h23
 `define SONIC_CMD_SFP_LPBK_ON		32'h24
 `define SONIC_CMD_SFP_LPBK_OFF		32'h25
 `define SONIC_CMD_INIT_NETLOGIC	32'h26
// -----------------------------------------------
// RC update mode
// -----------------------------------------------
 `define RC_UPD_CMD_MODE				32'h0
 `define RC_UPD_IRQ_MODE				32'h1

// Tx/Rx Ring size
// The Tx and Rx has the same size
// The interface to PCIe is 128 bit wide (OWORDS).
 `define RING_DEPTH_QWORDS			32'h4000	//14 bits
 `define RING_DEPTH_OWORDS			32'h2000	//13 bits
// Rx buffer
// Assume we have 8192 OWORDS entries in the ring
// We need 13 bits to address 8192 OWORD entries
// We need 14 bits to address 16384 QWORD entries
 `define QWORDS_LENGTH				14
 `define OWORDS_LENGTH				13

// Rx write addr is QWORDS, thus needs 14 bits
// Rx read addr is OWORDS, thus 13 bits
 `define USED_QWORDS_WIDTH			14
 `define RX_WRITE_ADDR_WIDTH			14
 `define RX_READ_ADDR_WIDTH			13

//Tx buffer
// Assume we have 8192 OWORDS in the ring.
// We need 13 bits to address 8192 OWORD entries
// We need 14 bits to address 16384 QWORD entries
// Tx write address is OWORDS, thus 13 bits
// Tx read address is QWORDS, thus 14 bits.
 `define TX_WRITE_ADDR_WIDTH			13
 `define TX_READ_ADDR_WIDTH			14

