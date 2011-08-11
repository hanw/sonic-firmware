/* Quartus II Version 11.0 Build 157 04/27/2011 Service Pack 0.01 SJ Full Version */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(EPM570) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(EP4S100G2F40) Path("/home/hwang/sonic/projects/sonic_fpga/src/top_examples/sonic_chaining_dma/") File("top_example_chaining_top.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
