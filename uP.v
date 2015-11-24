module uP(
	input	RESET, CLOCK, Enter,
	input	[7:0] Input,
	output	Halt,
	output	[7:0] Output
	//$$$$$ FOR TESTBENCH PURPOSE $$$$$$$
	//output	[8:0] CtrlSignals
);

	wire IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Aeq0, Apos;
	wire [1:0] Asel;
	wire [7:5] IR;

	uP_CU	CtrlUnit(RESET, CLOCK, IR, Aeq0,  Apos, Enter, IRload, JMPmux,
					 PCload, Meminst, MemWr, Aload, Sub, Halt, Asel);

	uP_DP	DataPath(CLOCK, RESET, Input, IRload, JMPmux, PCload, Meminst,
	                 MemWr, Aload, Sub, Asel, Aeq0, Apos, IR, Output);

	//assign CtrlSignals = {IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Aeq0, Apos, Asel};
	
	
endmodule
