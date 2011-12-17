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

#include "Vsonic_blocksync_xg.h"		// From Verilating "sonic_blocksync_xg.sv"

#define SIM_TIME 20000
#define DEBUG 0

using namespace std;

Vsonic_blocksync_xg *top;	// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

ifstream indata;

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

static inline void set_data_in (WDataOutP owp, QData hbits, QData lbits) { 
    // Assume 66 bits
    owp[0] = (WData)(lbits & VL_ULL(0xFFFFFFFF));
    owp[1] = (WData)((lbits >> VL_ULL(32)) & VL_ULL(0xFFFFFFFF));
    owp[2] = (WData)(hbits & VL_ULL(0xFFFFFFFF));
}

int main(int argc, char **argv, char **env) {

    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    top = new Vsonic_blocksync_xg;		// Create instance of module

    Verilated::commandArgs(argc, argv);
    Verilated::debug(1);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("Vsonic_blocksync_xg.vcd");	// Open the dump file
#endif
    
    top->reset = 1;		// Initialize inputs
    top->valid = 1;
    top->clk = 0;

    string str;
    string block_lock;

    long unsigned int li1, li2;
    char *pEnd;
    const char *str_c;

    // Load test vector.
    indata.open("data/test_vector.dat");

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

        if (!indata.eof() && top->clk == 0 ){
            getline(indata, str);
            str_c = str.c_str();
            li1 = strtoul(str_c, &pEnd, 16);
            li2 = strtoul(pEnd, &pEnd, 16);
#if DEBUG
            cout << "long int:" << li1 << " " << hex << li2 << endl;
#endif
            set_data_in(top->data_in, (QData)li1, (QData)li2);
        } 
    
        top->eval();		// Evaluate model

#if VM_TRACE
        if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif

        // Read outputs

        VL_PRINTF ("[%" VL_PRI64 "d] %x %x %0x %08x %08x %x %x\n",
               main_time, top->clk, top->reset, top->data_in[2], top->data_in[1], top->data_in[0], top->block_lock, top->v__DOT__offset);

        top->clk = !top->clk;
        main_time++;		// Time passes...
    }
    
    top->final();

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    indata.close();
    exit(0L);
}
