module n_REG_tb();

	reg 	CLOCK;
	reg		Load, Clear;
	reg		[7:0] D;
	reg		[15:0] D16;
	wire	[7:0] Q;
	wire	[15:0] Q16;
	
	initial begin
    CLOCK = 0;
    Load	= 0;
    Clear	= 1;
    D		  = 8'b00001111;
    D16		= 16'hF0F0;
    $display("Load\t| Input D \t| Output Q");
    $monitor("%X\t| %X\t\t| %X", Load, D, Q);
#2	Clear	= 0;
#2	Load	= 1;
#2	Load	= 0;
    D		  = 8'b00001001;
    D16		= 16'h00FF;
#2	Load	= 1;
#20	$finish;
	end
	
	always #1 CLOCK = ~CLOCK;
	
	n_REG #(8)	testReg0(CLOCK, Load, Clear, D, Q);
	n_REG #(16)	testReg1(CLOCK, Load, Clear, D16, Q16);	
	
endmodule
