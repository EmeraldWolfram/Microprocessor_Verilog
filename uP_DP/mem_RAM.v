module	mem_RAM(
	input	CLOCK,
	input 	[7:0] D,
	input 	[4:0] Address,
	input 	WE,
	output 	reg	[7:0] Q
);

	reg [7:0] REGISTER [31:0];
	
	always @(posedge CLOCK)
	begin
		if(!WE)	Q = REGISTER[Address];
		else	REGISTER[Address] = D;
	end
endmodule
