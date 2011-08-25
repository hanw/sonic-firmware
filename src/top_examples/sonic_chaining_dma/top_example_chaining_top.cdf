/* Quartus II Version 11.0 Build 157 04/27/2011 Service Pack 0.01 SJ Full Version */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(EPM570) MfrSpec(OpMask(0) SEC_Device(CFI_256MB) Child_OpMask(3 1 1 1) PFLPath("/home/hwang/sonic/projects/sonic_fpga/src/top_examples/sonic_chaining_dma/sonic_fpga.pof"));
	P ActionCode(Ign)
		Device PartName(EP4S100G2F40) MfrSpec(OpMask(0) FullPath("/home/hwang/sonic/projects/sonic_fpga/src/top_examples/sonic_chaining_dma/top_example_chaining_top.sof"));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;