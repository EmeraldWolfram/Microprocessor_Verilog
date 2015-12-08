module uP(
	input	CLOCK_50,
	input	[9:0] SW,
	input	[2:0] KEY,
	output	[7:0] LEDR,
	output	[4:0] LEDG
);


	wire	RESET, Enter, Init;
	wire	[7:0] Input;
	wire	Halt;
	wire	[7:0] Output;
	wire	[3:0] State;
	wire	CLOCK;
	TimingCircuits(CLOCK_50, CLOCK);
	//For internal connection only
	assign RESET = ~KEY[1];
	assign Enter = ~KEY[2];
	assign Init	 = ~KEY[0];
	assign Input = SW[7:0];
	
	assign LEDR = Output;
	assign LEDG[4]	= Halt;
	assign LEDG[3:0]= State[3:0];

	wire IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Aeq0, Apos;
	wire [1:0] Asel;
	wire [7:5] IR;

	uP_CU	CtrlUnit(RESET, CLOCK, IR, Aeq0,  Apos, Enter, IRload, JMPmux,
					 PCload, Meminst, MemWr, Aload, Sub, Halt, Asel, State);

	uP_DP	DataPath(CLOCK, RESET, Init, Input, IRload, JMPmux, PCload, Meminst,
	                 MemWr, Aload, Sub, Asel, Aeq0, Apos, IR, Output);
	
endmodule
