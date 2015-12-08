module mem_RAM_tb();

	reg		CLOCK;
	reg 	[7:0] D;
	reg 	[4:0] Address;
	reg 	WE;
	//$$$$$$$$$ADD IN FOR TB$$$$$$$$$$
	reg		Init;
	//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
	wire	[7:0] Q;
	integer i;
	
	
	initial
	begin
	Init = 1;
	Address = 0;
	CLOCK = 0;
	WE = 0;
#2	Init = 0;
	for(i = 0; i < 11; i = i + 1)
		begin
#2		$display("Add[%d]  %b", Address, Q);
		Address = Address + 1;
		end		
	end
	
	mem_RAM	testMem(CLOCK, D, Address, WE, Init, Q);
	
	always #1 CLOCK = ~CLOCK;
	
endmodule
