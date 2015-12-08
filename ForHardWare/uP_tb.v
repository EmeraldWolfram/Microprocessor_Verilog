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
	INPUT();
    INPUT();
    $monitor("%dns, Output: %d", $time, Output);
#600	$finish;
	end
	
	uP	test_uP(RESET, CLOCK, Enter, Init, Input, Halt, Output, CtrlSignals, Ins);

//*********************************ALL TEST TASK***************************************
	/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
	task INPUT;
	begin
		begin
		Input = {$random} % 256;
	#10 Enter = 1;
	#4  Enter = 0;
		$display("%dns, Input : %d", $time, Input);	
		end
	end
	endtask
	/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

endmodule
