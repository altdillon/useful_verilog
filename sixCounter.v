
module sixCounter(
	input clockIn,
	input en,
	output [3:0] out,
	output z,
	input reset
);

	// setup our wires 
	wire a,b,c; 
	wire ja,ka,jb,kb,jc,kc;
	
	// tie a,b, and, c to the outside world 
	assign out={1'b0,a,b,c};
	
	// assign combonatinal logic to the ff inputs 
	
	assign ja=c&b;
	assign ka=c|b;
	assign jb=~a&c;
	assign kb=c|a;
	assign jc=~a|~b;
	assign kc=1'b1;
	
	assign z=~a&~b&~c;
	
	/*
	module lab_JKFF(
	input clock,
	input J,
	input K,
	input preset,
	input reset,
	output reg Q
);
	*/
	
	lab_JKFF Qa(.clock(clockIn),.J(ja),.K(ka),.preset(1'b1),.reset(reset),.Q(a));
	lab_JKFF Qb(.clock(clockIn),.J(jb),.K(kb),.preset(1'b1),.reset(reset),.Q(b));
	lab_JKFF Qc(.clock(clockIn),.J(jc),.K(kc),.preset(1'b1),.reset(reset),.Q(c));
	
endmodule 