// DESCRIPTION: Verilator Example: Top level main for invoking model
//
// Copyright 2003-2011 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
//
#include <fstream>
#include <iostream>
#include <string>

#include <stdio.h>

#include <verilated.h>		// Defines common routines
#if VM_TRACE
#include <verilated_vcd_c.h>	// Trace file format header
#endif

#include "Vsonic_loopback_test.h"		// From Verilating "sonic_blocksync_xg.sv"

#define SIM_TIME    40000
#define DEBUG       0
#define INPUT_VEC   1
using namespace std;

Vsonic_loopback_test *top;	// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

ifstream indata;
FILE *fp;
FILE *fcbuf;

double sc_time_stamp () {	// Called by $time in Verilog
  return main_time;		// Note does conversion to real, to match SystemC
}

static inline void set_data_in (WDataOutP owp, QData hbits, QData lbits) { 
  // Assume 66 bits
  owp[0] = (WData)(lbits & VL_ULL(0xFFFFFFFF));
  owp[1] = (WData)((lbits >> VL_ULL(32)) & VL_ULL(0xFFFFFFFF));
  owp[2] = (WData)(hbits & VL_ULL(0xFFFFFFFF));
  owp[3] = (WData)((hbits >> VL_ULL(32)) & VL_ULL(0xFFFFFFFF));
}

int main(int argc, char **argv, char **env) {

  if (0 && argc && argv && env) {}	// Prevent unused variable warnings
  top = new Vsonic_loopback_test;		// Create instance of module
  fp = fopen("data/result.dat","w");

  Verilated::commandArgs(argc, argv);
  Verilated::debug(1);

#if VM_TRACE			// If verilator was invoked with --trace
  Verilated::traceEverOn(true);	// Verilator must compute traced signals
  VL_PRINTF("Enabling waves...\n");
  VerilatedVcdC* tfp = new VerilatedVcdC;
  top->trace (tfp, 99);	// Trace 99 levels of hierarchy
  tfp->open ("Vsonic_loopback_test.vcd");	// Open the dump file
#endif
  set_data_in (top->tx_data_in, 0, 0);
  top->tx_wr_address = 0;
  top->tx_tag_cpl = 1;
  top->reset = 1;
  top->enable_sfp = 1;
  top->xcvr_tx_ready = 1;
  top->xcvr_rx_ready = 1;
  top->tx_wrreq = 1;
  top->loopback_en = 1;
  string str;
  string block_lock;

  unsigned long li1, li2, li3, li4;
  char *pEnd;
  const char *str_c;

  unsigned int curr_rd_pos;

  // Load test vector.
#if INPUT_VEC
  indata.open("data/test_vector.dat");
#endif

  while (main_time < SIM_TIME && !Verilated::gotFinish()) {

    if (main_time > 10) {
      top->reset = 0;	// Deassert reset
    } else if (main_time > 1) {
      top->reset = 1;	// Assert reset
    }

    // Parsing code is file specific.
    // ==============================
    // data_in <space> block_lock
    // 72 bit  <space> 1 bit
    // ==============================
#if INPUT_VEC
    if (!indata.eof() && top->wr_clock == 0 && top->reset == 0){
      getline(indata, str);
      str_c = str.c_str();
      li1 = strtoul(str_c, &pEnd, 16);
      li2 = strtoul(pEnd, &pEnd, 16);
      li3 = strtoul(pEnd, &pEnd, 16);
#if DEBUG
      cout << "long int:" << li1 << " " << hex << li2 << endl;
#endif
      set_data_in(top->tx_data_in, (QData)li1, (QData)li2);
    } 
#endif
    top->tx_wr_address = li3;

    top->eval();		// Evaluate model
        
#if VM_TRACE
    if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif


    if (top->v__DOT__rx_chan__DOT__blocksync_lock == 1) {
      if (top->rx_ring_wptr - curr_rd_pos >= 0x200) {
	curr_rd_pos = top->rx_ring_wptr;
      }

      if (top->rx_rd_address < curr_rd_pos / 2 && top->wr_clock == 0) {
	top->rx_rd_address++;
	top->rx_dma_rdreq = 1;
      } else {
	top->rx_dma_rdreq = 0;
      }
    }
    
    if (main_time % 2 == 0 && top->rx_dma_rdreq == 1) {
      fprintf(fp, "%08x%08x%08x%08x\n", top->rx_data_out[3], top->rx_data_out[2],
	      top->rx_data_out[1], top->rx_data_out[0]);
    }

    // Read outputs

    top->wr_clock = !top->wr_clock;
    top->rd_clock = !top->rd_clock;
    main_time++;		// Time passes...
  }
    
  top->final();
  fclose(fp);

#if VM_TRACE
  if (tfp) tfp->close();
#endif

  indata.close();
  exit(0L);
}
