module TimingCircuits(
	input	CLOCK_50,
	output	reg [0:0]outX
);
	reg [31:0] i = 0;	
	
	always @ (posedge CLOCK_50)
		begin
			if(i>25000000)
				begin
					i = 0;
				 outX = ~outX;
				end
			else	
				i = i + 1;
		end
		
	
endmodule
