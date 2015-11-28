`timescale 1ns/1ns
`define PERIOD 1

module uP_tb();
	
	reg	RESET, CLOCK, Enter;
	reg	[7:0] Input;
	wire Halt;
	wire [7:0] Output;
	integer errors, i;
//*******************GLOBAL INITIAL CLOCK and GLOBAL INITIAL RESET********************
	initial begin
	CLOCK <= 0;
	forever #(`PERIOD) CLOCK = ~CLOCK;
	end

	initial begin
	RESET <= 1;
	@(posedge CLOCK)
	@(negedge CLOCK) RESET = 0;
	end
//*********************************MAIN TEST BLOCK*************************************
	initial begin
	errors	= 0;
	Input	= 0;
	Enter	= 0;
#2	Input	= {$random} % 256;
#2	Enter	= 1;
#6	Input	= {$random} % 256;
	Enter	= 0;
#2	Enter	= 1;
	$monitor("%dns, Output: 0x%h", $time, Output);
	end
	
	uP	testUP(RESET, CLOCK, Enter, Input, Halt, Output);
//*********************************ALL TEST TASK***************************************
	/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
	task comp_OUTPUT;
	input [7:0] expectedValue;
	input [7:0] actualValue;
	begin
		if(actualValue[7:0] != expectedValue[7:0])
			begin
			errors = errors + 1;
			$display("\t\t\t*******************\n%dns: ERROR: Expected %h was %h\n", 
			$time, expectedValue, actualValue);
			end
	end
	endtask
	/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

endmodule
