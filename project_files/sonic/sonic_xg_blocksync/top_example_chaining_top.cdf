/* Quartus II 32-bit Version 11.1 Build 259 01/25/2012 Service Pack 2 SJ Full Version */
JedecChain;
	FileRevision(JESD32A);
	DefaultMfr(6E);

	P ActionCode(Ign)
		Device PartName(EPM570) MfrSpec(OpMask(0));
	P ActionCode(Cfg)
		Device PartName(EP4S100G2F40) Path("/home/hwang/sonic/projects/sonic_develop/current/dma_rxtx_v3.1/project_files/sonic/sonic_xg_blocksync/") File("top_example_chaining_top.sof") MfrSpec(OpMask(1));

ChainEnd;

AlteraBegin;
	ChainType(JTAG);
AlteraEnd;
