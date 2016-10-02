//modules for memory flipflop

module lab_DFF(
	input clock,
	input data,
	input preset,
	input reset,
	output reg Q
);

	always @(posedge clock or negedge preset or negedge reset) begin

	if(~preset)
		Q <= 1'b1;
	else if(~reset)
		Q <= 1'b0;
	else
		Q <= data;

	end

endmodule

module lab_TFF(
	input clock,
	input t,
	input preset,
	input reset,
	output reg Q
);

	always @(posedge clock or negedge preset or negedge reset) begin

	if(~preset)
		Q <= 1'b1;
	else if(~reset)
		Q <= 1'b0;
	else
		Q <= ~t&Q|~Q&t;  //next state function for the good ol' tff

	end

endmodule

module lab_JKFF(
	input clock,
	input J,
	input K,
	input preset,
	input reset,
	output reg Q
);

	always @(posedge clock or negedge preset or negedge reset) begin

	if(~preset)
		Q <= 1'b1;
	else if(~reset)
		Q <= 1'b0;
	else
		Q <= J&~Q|~K&Q;

	end

endmodule
