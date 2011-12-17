// DESCRIPTION: Verilator Example: Top level main for invoking model
//
// Copyright 2003-2011 by Wilson Snyder. This program is free software; you can
// redistribute it and/or modify it under the terms of either the GNU
// Lesser General Public License Version 3 or the Perl Artistic License
// Version 2.0.
#include <fstream>
#include <iostream>
#include <string>

#include <stdio.h>

#include <verilated.h>		// Defines common routines
#include "Vsonic_gearbox_40_66.h"		// From Verilating "sonic_gearbox_40_66.sv"
#if VM_TRACE
# include <verilated_vcd_c.h>	// Trace file format header
#endif

#define SIM_TIME 10000
#define DEBUG 0
using namespace std;

Vsonic_gearbox_40_66 *top;			// Instantiation of module

vluint64_t main_time = 0;	// Current simulation time (64-bit unsigned)

ifstream indata;
FILE *fp;

double sc_time_stamp () {	// Called by $time in Verilog
    return main_time;		// Note does conversion to real, to match SystemC
}

int main(int argc, char **argv, char **env) {
    if (0 && argc && argv && env) {}	// Prevent unused variable warnings
    top = new Vsonic_gearbox_40_66;		// Create instance of module
    fp = fopen("./data/result.hex", "w");

    Verilated::commandArgs(argc, argv);
    Verilated::debug(0);

#if VM_TRACE			// If verilator was invoked with --trace
    Verilated::traceEverOn(true);	// Verilator must compute traced signals
    VL_PRINTF("Enabling waves...\n");
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);	// Trace 99 levels of hierarchy
    tfp->open ("Vsonic_gearbox_40_66.vcd");	// Open the dump file
#endif

    top->reset = 1;		// Set some inputs
    top->clk_in = 0;
    top->data_in = 0x0;

    string str;
    string block_lock;

    long unsigned int li1, li2;
    char *pEnd;
    const char *str_c;

    // Load test vector.
    indata.open("./data/test_vector.40b");

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

        if (!indata.eof() && top->clk_in == 0 ){
            getline(indata, str);
            str_c = str.c_str();
            li1 = strtoul(str_c, &pEnd, 16);
            //li2 = strtoul(pEnd, &pEnd, 16);
#if DEBUG
            cout << "long int:" << li1 << " " << hex << li2 << endl;
#endif
            //set_data_in(top->data_in, (QData)li1, (QData)li2);
        } 
        top->data_in = li1;
 
        top->eval();		// Evaluate model
#if VM_TRACE
        if (tfp) tfp->dump (main_time);	// Create waveform trace for this timestamp
#endif

        // Read outputs
/*        VL_PRINTF ("[%" VL_PRI64 "d] %x %x %lx, %X %016X\n",
               main_time, top->clk_in, top->reset, 
               top->data_in, top->data_out[1], top->data_out[0]);
*/
        if ((main_time % 2 == 0) && (top->data_valid == 1))
            fprintf(fp,"%x%08x%08x\n",top->data_out[2], top->data_out[1], top->data_out[0]);

        top->clk_in = !top->clk_in;
        main_time++;		// Time passes...
    }

    top->final();
    fclose(fp);

#if VM_TRACE
    if (tfp) tfp->close();
#endif

    exit(0L);
}
