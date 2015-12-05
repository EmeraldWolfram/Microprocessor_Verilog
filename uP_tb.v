`timescale 1ns/1ns
`define PERIOD 1

module uP_tb();
	
	reg	RESET, CLOCK, Enter, Init;
	reg	[7:0] Input;
	wire Halt;
	wire [7:0] Output;
	wire [10:0] CtrlSignals;
	wire [2:0] Ins;
	integer errors, i;
//*******************GLOBAL INITIAL CLOCK and GLOBAL INITIAL RESET********************
	initial begin
	CLOCK <= 0;
	forever #(`PERIOD) CLOCK = ~CLOCK;
	end

	initial begin
	RESET <= 1;
  Init  <= 1;
	@(posedge CLOCK);
	@(negedge CLOCK) RESET = 0;
                    Init = 0;
	end
//*********************************MAIN TEST BLOCK*************************************
	initial begin
	errors	= 0;
	Enter	= 0;
	$monitor("%dns, Output: 0x%h", $time, Output);
	Input	= {$random} % 256;
#10  Enter	= 1;
#4  Enter = 0;
    Input	= {$random} % 256;
#20	Enter	= 1;
#2  Enter = 0;
#600	$finish;
	end
	
	uP	test_uP(RESET, CLOCK, Enter, Init, Input, Halt, Output, CtrlSignals, Ins);

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
