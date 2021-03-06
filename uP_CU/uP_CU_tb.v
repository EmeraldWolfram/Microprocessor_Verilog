`timescale 1ns/1ns
`define PERIOD 4

module uP_CU_tb();

	reg RESET, CLOCK;
	reg [7:5] IR;
	reg Aeq0, Apos, Enter;
	wire IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt;
	wire [1:0] Asel;
	wire [3:0] outState;
	wire [14:0] GhinYew_Output;
	assign GhinYew_Output = {IRload, JMPmux, PCload, Meminst, MemWr, Aload, Sub, Halt, Asel, outState};
	
	wire IRload1, JMPmux1, PCload1, Meminst1, MemWr1, Aload1, Sub1, Halt1;
	wire [1:0] Asel1;
	wire [3:0] outState1;
	wire [14:0] JS_Output;
	assign JS_Output = {IRload1, JMPmux1, PCload1, Meminst1, MemWr1, Aload1, Sub1, Halt1, Asel1, outState1};
	integer i;
	
	initial begin
		RESET = 0;
		CLOCK = 0;
		IR[7:5] = 3'b000;
		Aeq0 = 0;
		Apos = 0;
		Enter = 1;
	#4	RESET = 1;
	#4	RESET = 0;
		for (i=0; i<=3'b111; i=i+1) begin
			#32	IR[7:5] = IR[7:5] + 3'b001;
		end
	#60 $finish;
	end
	
  initial begin
	CLOCK <= 0;
	forever #(`PERIOD) CLOCK = ~CLOCK;
	end

	initial begin
	RESET <= 1;
	@(posedge CLOCK)
	@(negedge CLOCK) RESET = 0;
	end
  
	always #1 Aeq0 = ~Aeq0;
	always #2 Apos = ~Apos;
	always #2 Enter = ~Enter;
	
	uP_CU processor(.RESET(RESET),.CLOCK(CLOCK),.IR(IR),.Aeq0(Aeq0),.Apos(Apos),.Enter(Enter),
					.IRload(IRload),.JMPmux(JMPmux),.PCload(PCload),.Meminst(Meminst),.MemWr(MemWr),
					.Aload(Aload),.Sub(Sub),.Halt(Halt),.Asel(Asel),.outState(outState));
					
					
//	LAB2_CU JS_uP(.IR(IR),.Aeq0(Aeq0),.Apos(Apos),.Enter(Enter),.Clk(CLOCK),.Reset(RESET),
//				  .IRload(IRload1),.JMPmux(JMPmux1),.PCload(PCload1),.Meminst(Meminst1),
//				  .MemWr(MemWr1),.Aload(Aload1),.Sub(Sub1),.Halt(Halt1),.Asel(Asel1),.stateOut(outState1));
				  
					
//	always #1 begin
//		if(GhinYew_Output != JS_Output)
//		begin
//			$display("Result Not Match at State %h\n", outState);
//			$display("Different between JS: 0x%h - GY: 0x%h", JS_Output, GhinYew_Output);
//			$stop;
//		end
//		else
//		begin
//			$display("Match State %h", outState);
//		end
//	end
					
	
endmodule
