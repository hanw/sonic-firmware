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

#include <verilated.h>		// Defines common routines
#if VM_TRACE
#include <verilated_vcd_c.h>	// Trace file format header
#endif

#include "Vsonic_tx_circular_buffer_66.h"		// From Verilating "sonic_blocksync_xg.sv"

#define SIM_TIME    20000
#define DEBUG       0
#define INPUT_VEC   1
using namespace std;

Vsonic_tx_circular_buffer_66 *top;	// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

ifstream indata;
FILE *fp;

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
    top = new Vsonic_tx_circular_buffer_66;		// Create instance of module
    fp = fopen("data/result.hex","w");

    Verilated::commandArgs(argc, argv);
    Verilated::debug(1);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("Vsonic_tx_circular_buffer_66.vcd");	// Open the dump file
#endif
    set_data_in (top->data_in, 0, 0);
    top->wrreq = 1;
    top->wr_address = 0;
    top->reset = 1;
    top->rdreq = 0;
    top->rdena = 0;

    string str;
    string block_lock;

    unsigned long li1, li2, li3;
    char *pEnd;
    const char *str_c;

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
        if (!indata.eof() && top->wr_clk == 0 && top->reset == 0){
            getline(indata, str);
            str_c = str.c_str();
            li1 = strtoul(str_c, &pEnd, 16);
            li2 = strtoul(pEnd, &pEnd, 16);
            li3 = strtoul(pEnd, &pEnd, 16);
#if DEBUG
            cout << "long int:" << li1 << " " << hex << li2 << endl;
#endif
            set_data_in(top->data_in, (QData)li1, (QData)li2);
        } 
#endif

        if (top->wr_clk == 0) {
            top->wr_address = li3;
            top->wrreq = 1;
        } else {
            top->wrreq = 0;
        }

        if (main_time > 4000 && main_time % 4 == 0) {
            top->rdena = 1;
            top->rdreq = 1;
        }
            
        top->eval();		// Evaluate model

#if VM_TRACE
        if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif

        if (main_time > 4008 && main_time % 2 == 0) {
            fprintf(fp, "%0x %08x%08x\n", top->data_out[2], top->data_out[1], top->data_out[0]);
        }

        // Read outputs
#if INPUT_VEC
        VL_PRINTF ("[%" VL_PRI64 "d] %x %08X %08X %08X %08X, %X %08X %08X \n",
               main_time, top->wr_clk, top->data_in[3], top->data_in[2], top->data_in[1],
               top->data_in[0], top->data_out[2], top->data_out[1], top->data_out[0]);
#endif
        top->wr_clk = !top->wr_clk;
        top->rd_clk = !top->rd_clk;
        main_time++;		// Time passes...
    }
    
    top->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    indata.close();
    exit(0L);
}
