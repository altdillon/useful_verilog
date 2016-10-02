
module clock_divider(
	input sys_clock,
	input preset,
	input reset,
	output [6:0] clock
);

	wire clk_1Mhz,clk_100Khz,clk_10Khz,clk_1Khz,clk_100hz,clk_10hz,clk_1hz;
	assign clock = {clk_1Mhz,clk_100Khz,clk_10Khz,clk_1Khz,clk_100hz,clk_10hz,clk_1hz};

	divide_by_50 div50(sys_clock,preset,reset,clk_1Mhz);
	divide_by_10 div10_100khz(clk_1Mhz,preset,reset,clk_100Khz);
	divide_by_10 div10_10khz(clk_100Khz,preset,reset,clk_10Khz);
	divide_by_10 div10_1Khz(clk_10Khz,preset,reset,clk_1Khz);
	divide_by_10 div10_100hz(clk_1Khz,preset,reset,clk_100hz);
	divide_by_10 div10_10hz(clk_100hz,preset,reset,clk_10hz);
	divide_by_10 div10_1hz(clk_10hz,preset,reset,clk_1hz);

endmodule

module divide_by_50(
	input sys_clock,
	input preset,
	input reset,
	output divclock
);

	wire div5out;
	divide_by_5 firstStage(sys_clock,preset,reset,div5out);
	divide_by_10 secondStage(div5out,preset,reset,divclock);

endmodule

module divide_by_10(
	input sys_clock,
	input preset,
	input reset,
	output divclock
);

	wire div2out;
	divide_by_2 firstStage(sys_clock,preset,reset,div2out);
	divide_by_5 secondStage(div2out,preset,reset,divclock);

endmodule

module divide_by_2(
	input sys_clock,
	input preset,
	input reset,
	output divclock
);

//divide by 2
//	wire dffOut;
//	wire dffIn;
//	assign dffIn=~dffOut;
//	assign div_sig=dffOut;
//
//	part2_DFF testdff(sys_clock,dffIn,1'b1,1'b1,dffOut);

	wire diffOut;
	wire dffIn;
	assign dffIn=~dffOut;
	assign divclock=dffOut;
	lab_DFF testdff(sys_clock,dffIn,preset,reset,dffOut);

endmodule

module divide_by_5(
	input sys_clock,
	input preset,
	input reset,
	output divclock
);

	wire d0,d1,d2;
	wire q0,q1,q2,q3;

	wire q3_clock=~sys_clock; //clock for q3, since it needs to be nanded

	//rtl assignments
	assign d2=q1&q0;
	xor xor1(d1,q1,q0);
	nor nor1(d0,q2,q0);

	//flip flops
	lab_DFF dff_q2(sys_clock,d2,preset,reset,q2);
	lab_DFF dff_q1(sys_clock,d1,preset,reset,q1);
	lab_DFF dif_q0(sys_clock,d0,preset,reset,q0);
	lab_DFF dif_q3(q3_clock,q1,preset,reset,q3);

	assign divclock=q1|q3;

endmodule
