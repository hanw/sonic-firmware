/*
 * routines.c
 *
 *  Created on: Aug 14, 2011
 *      Author: hwang
 */
#include "routines.h"
#include "sonic_io.h"
#include "debug.h"
#include <stdio.h>

#define BIT(x) 				(1 << (x))
#define SETBITS(x,y) 		((x) |= (y))
#define CLEARBITS(x,y) 		((x) &= (~(y)))
#define SETBIT(x,y) 		SETBITS((x), (BIT((y))))
#define CLEARBIT(x,y) 		CLEARBITS((x), (BIT((y))))
#define BITSET(x,y) 		((x) & (BIT(y)))
#define BITCLEAR(x,y) 		!BITSET((x), (y))
#define BITSSET(x,y) 		(((x) & (y)) == (y))
#define BITSCLEAR(x,y) 		(((x) & (y)) == 0)
#define BITVAL(x,y) 		(((x)>>(y)) & 1)

void wr32 (unsigned int base_address, unsigned int sub_base_address, unsigned int offset, unsigned int value) {
	unsigned int address;
	address = base_address + sub_base_address + offset;
	avalon_mm_write (address, value);
	pmesg(12, "wr32: address 0x%x, val 0x%x\n", address,value);
}

unsigned int rd32 (unsigned int base_address, unsigned int sub_base_address, unsigned int offset) {
	unsigned int value;
	unsigned int address;
	address = base_address + sub_base_address + offset;
	value = avalon_mm_read (address);
	pmesg(12, "rd32: address 0x%x, val 0x%x\n", address,value);
	return value;
}

void stats (){

}

void read_pma_controller(){

}

void read_pma_reset_controller() {

}

void read_pma_ch_controller () {


}

/*==============================================================================
  Writing to dev_prt_phy_address register (16 bits) of address 0x80 (0x20 on the slave)
    Bit [4:0] : phydev_address = clause 22 PHYAD / clause 45 DEVAD (device address)
    Bit [12:8] : prt_address = clause 45 PRTAD (for HSMC X2 daughter card, the value is define by the dip switch on the board)
    Bit [31:16] : c1ause 45 register address (refer to IEEE 802.1 clause 45 for description)
 ============================================================================== */
unsigned int read_mdio (unsigned int address) {
	unsigned int mdio_reg_value = address << 16 | 0x1;
	unsigned int val;
	unsigned int ret_val;

	val = rd32(MDIO_BASE_ADDR, MDIO_CSR_ADDR_CL45, 0);
	pmesg(10, "Read dev_prt_phy_add register 0x%x = 0x%x\n", MDIO_CSR_ADDR_CL45, val);

	wr32 (MDIO_BASE_ADDR, MDIO_CSR_ADDR_CL45, 0, mdio_reg_value);

	pmesg(10, "Read dev_prt_phy_add register 0x%x = 0x%x\n", MDIO_CSR_ADDR_CL45, rd32(MDIO_BASE_ADDR, MDIO_CSR_ADDR_CL45, 0));

	ret_val = rd32(MDIO_BASE_ADDR, MDIO_RW_ADDR, 0);
	pmesg(10, "Read PMA/PMD control register 0x%x = 0x%x\n", MDIO_RW_ADDR, ret_val);
	pmesg(10, "-----------------------------------------------\n");
	return ret_val;
}

/*==============================================================================
  Writing to dev_prt_phy_address register (16 bits) of address 0x80 (0x20 on the slave)
    Bit [4:0] : phydev_address = clause 22 PHYAD / clause 45 DEVAD (device address)
    Bit [12:8] : prt_address = clause 45 PRTAD (for HSMC X2 daughter card, the value is define by the dip switch on the board)
    Bit [31:16] : c1ause 45 register address (refer to IEEE 802.1 clause 45 for description)
  ============================================================================== */
void write_mdio (unsigned int address, unsigned int value) {
	unsigned int mdio_reg_value = address << 16 | 0x1;
	unsigned int val;

	val = rd32(MDIO_BASE_ADDR, MDIO_CSR_ADDR_CL45, 0);
	pmesg(10, "Read dev_prt_phy_add register 0x%x = 0x%x\n", MDIO_CSR_ADDR_CL45, val);

	wr32(MDIO_BASE_ADDR, MDIO_CSR_ADDR_CL45, 0, mdio_reg_value);

	val = rd32(MDIO_BASE_ADDR, MDIO_CSR_ADDR_CL45, 0);
	pmesg(10, "Read dev_prt_phy_add register 0x%x = 0x%x\n", MDIO_CSR_ADDR_CL45, val);

	wr32(MDIO_BASE_ADDR, MDIO_RW_ADDR, 0, value);
	pmesg(10, "Writing 0x%x to 0x%x\n", MDIO_RW_ADDR, value);
	pmesg(10, "-----------------------------------------------\n");
}

void wait_on_reset () {
	unsigned int mdio_reg_value = 0x1;
	unsigned int val;
	unsigned int expired;
	wr32(MDIO_BASE_ADDR, MDIO_CSR_ADDR_CL45, 0, mdio_reg_value);
	val = (rd32(MDIO_BASE_ADDR, MDIO_RW_ADDR, 0) | 0x8000) >> 16;

	while (val > 0) {
		expired++;
		if (expired > 100){
			pmesg(1, "wait on reset expired!\n");
			break;
		}
		val = (rd32(MDIO_BASE_ADDR, MDIO_RW_ADDR, 0) | 0x8000) >> 16;
	}
	pmesg(3, "-----------------------------------------------\n");
}

void set_pma_loopback(){
	write_mdio (1, 0x2041);
}

void unset_pma_loopback(){
	write_mdio (1, 0x2040);
}

//ext_xcvr_off
//ext_xcvr_on
unsigned int read_ext_xcvr_ctrl () {
	unsigned int val;
	val = rd32(EXT_XCVR_BASE_ADDR, 0, 0x4);
	pmesg(5, "external xcvr control register = 0x%x\n", val);
	return val;
}

void ext_xcvr_reset(){
	unsigned int regval = 0x7E;
	wr32(EXT_XCVR_BASE_ADDR, 0, 0x4, regval);
	read_ext_xcvr_ctrl();

	regval = 0x7;
	wr32(EXT_XCVR_BASE_ADDR, 0, 0x4, regval);
	read_ext_xcvr_ctrl();
	pmesg(5, "external xcvr reset done!\n");
}

/*
 * Netlogic initialization routine
 */
void netlogic_init(){
	unsigned int val;
	unsigned int i,j;
	pmesg (3, "initializing netlogic...\n");

	// Issue hardware reset
	ext_xcvr_reset();

	val = read_mdio(0);
	pmesg(8, "PMA/PMD control register 1 is 0x%x\n", val);

	val = read_mdio(0xC000);
	val = CLEARBIT(val, 5);
	write_mdio (0xC000, val);
	pmesg(8, "Mode selection register 0xC000 is 0x%x\n", read_mdio(0xC000));

	val = read_mdio(0xC000);
	val = SETBIT(val, 5);
	write_mdio (0xC000, val);
	pmesg(8, "Mode selection register 0xC000 is 0x%x\n", read_mdio(0xC000));

	// Write 1.CC41.6:0 = 0x7
	val = read_mdio(0xCC41);
	val = SETBITS(val, 0x7);
	val = CLEARBITS(val, 0x78);
	write_mdio(0xCC41, val);
	pmesg(8, "XFI receive register 0xCC41 is 0x%x\n", read_mdio(0xCC41));

	// Write 1.CC46.8:5 = 0x7
	val = read_mdio(0xCC46);
	val = SETBITS(val, 0xE0);
	val = CLEARBITS(val, 0x100);
	write_mdio(0xCC46, val);
	pmesg(8, "XFI receive register 0xCC46 is 0x%x\n", read_mdio(0xCC46));

	// Write 1.CB01.11:8 = 0xA
	val = read_mdio(0xCB01);
	val = SETBITS(val, 0xA00);
	val = CLEARBITS(val, 0x500);
	write_mdio(0xCB01, val);
	pmesg(8, "XFI receive register 0xCB01 is 0x%x\n", read_mdio(0xCB01));

	// write 1.CC44.3:0 = 0xF
	val = read_mdio(0xCC44);
	val = SETBITS(val, 0xF);
	write_mdio(0xCC44, val);
	pmesg(8, "XFI receive register 0xCC44 is 0x%x\n", read_mdio(0xCC44));

	// turn off receive offset calibration loop.
	val = read_mdio(0xCC00);
	val = CLEARBIT(val, 7);
	write_mdio (0xCC00, val);
	pmesg(8, "Limiting O2E Rx Calibration register is 0x%x\n", read_mdio(0xCC00));

	// write 1.CC01.6:0 = 0x7
	val = read_mdio(0xCC01);
	val = SETBITS(val, 0x7);
	val = CLEARBITS(val, 0x78);
	write_mdio(0xCC01, val);
	pmesg(8, "XFI receive register 0xCC01 is 0x%x\n", read_mdio(0xCC01));

	// write 1.CC06.8:5 = 0x7
	val = read_mdio(0xCC06);
	val = SETBITS(val, 0xE0);
	val = CLEARBITS(val, 0x100);
	write_mdio(0xCC06, val);
	pmesg(8, "XFI receive register 0xCC06 is 0x%x\n", read_mdio(0xCC06));

	// write 1.CB1B.3:0 = 0xA
	val = read_mdio(0xCB1B);
	val = SETBITS(val, 0xA);
	val = CLEARBITS(val, 0x5);
	write_mdio(0xCB1B, val);
	pmesg(8, "XFI receive register 0xCB1B is 0x%x\n", read_mdio(0xCB1B));

	// write 1.CC04.3:0 = 0xF
	val = read_mdio(0xCC04);
	val = SETBITS(val, 0xF);
	write_mdio(0xCC04, val);
	pmesg(8, "XFI receive register 0xCC04 is 0x%x\n", read_mdio(0xCC04));
}

