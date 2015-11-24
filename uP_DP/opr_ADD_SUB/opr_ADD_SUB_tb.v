module opr_ADD_SUB_tb();

	reg	[7:0] A, B;
	reg	Sub;
	wire [7:0] RESULT;

	initial begin
	A	= 8'd9;
	B	= 8'd5;
	Sub = 0;
	$display("Sub\tA\tB\tRESULT");
	$monitor("%X\t%d\t%d\t%d", Sub, A, B, RESULT);
#1	Sub = 1;
#1	A	= 8'd24;
	B	= 8'd9;
#1	Sub = 0;
#15	$finish;
	end

	opr_ADD_SUB	test(A, B, Sub, RESULT);

endmodule
