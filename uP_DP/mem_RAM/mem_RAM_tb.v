module mem_RAM_tb();

	reg	CLOCK;
	reg [7:0] D;
	reg [4:0] Address;
	reg WE;
	wire [7:0] Q;
	
	integer i;
	
	initial begin
	CLOCK	= 0;
	D		= 8'h0F;
	Address	= 5'b00000;
	WE		= 1;
	$display("WE\t|Address\t|D\t|Q");
	$monitor("%d\t|%X\t\t|%X\t|%X", WE, Address, D, Q);
	for(i = 0; i < 5'b11111; i = i + 1)
	begin
#4	Address = Address + 5'b00001;
	D		= D + 8'd2;
	end
	WE		= 0;
	for(i = 0; i < 5'b11111; i = i + 1)
	begin
#4	Address = Address + 5'b00001;
	D		= D + 8'd2;
	end
#20	$finish;
	end

	always #1 CLOCK = ~CLOCK;

	mem_RAM	RAM_32(CLOCK, D, Address, WE, Q);
	
endmodule
	