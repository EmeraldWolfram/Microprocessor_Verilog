`timescale 1ns/1ns
`define PERIOD 1

module uP_tb();
	
	reg	RESET, CLOCK, Enter, Init;
	reg	[7:0] Input;
	wire Halt;
	wire [7:0] Output;
	wire [10:0] CtrlSignals;
	wire [2:0] Ins;
	integer errors;
	reg [7:0] i, j;
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
	for(i = 1; i < 100; i = i + 1)
		begin
	#2   RESET_STATE();
		 j = ({$random} % 256);
	#30  INPUT_SOMETHING(j);
	#30  INPUT_SOMETHING(i);
	#2	 FIND_LAST(j, i);
		end
	if(errors == 0)
		$display("Zero Error\nSimulation SUCCESSFUL");
	else
		$display("Total Error: %d, Simulation FAILED", errors);
#2	$finish;
	end
	
	
	uP	test_uP(RESET, CLOCK, Enter, Init, Input, Halt, Output, CtrlSignals, Ins);

//*********************************ALL TEST TASK***************************************
	/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/
	task INPUT_SOMETHING;
	input [7:0] dataIn;
	begin
		Input = dataIn;
	#10 Enter = 1;
	#4  Enter = 0;
		$display("%dns, Input : %d", $time, Input);	
	end
	endtask
	
	task RESET_STATE;
	begin
		RESET = 1;
	#2  RESET = 0;
	end
	endtask

	task FIND_LAST;
	input [7:0] X;
	input [7:0] Y;
	begin
		while(X != Y)
		begin
			if(X > Y)	X = X-Y;
			else		Y = Y-X;
		end
		comp_OUTPUT(X);
	end
	endtask

	task comp_OUTPUT;
	input [7:0] expectedValue;
	begin
		while(Halt == 0)
			begin
#100		i = i;
			end
		$display("%dns \tOutput : %d\n", $time, Output);	
		if(Output[7:0] != expectedValue[7:0])
			begin
			errors = errors + 1;
			$display("\t\t\t*******************\n%dns: ERROR: Expected %h was %h\n", 
			$time, expectedValue, Output);
			end
	end
	endtask
	/*$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$*/

endmodule
