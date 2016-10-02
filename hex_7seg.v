/*  Module name: hex_7seg
*
*   Input:  hex_digit (4 bits) for hex numbers 0 - F
*   Output: seg - 7 bit signal turns on/off the segments of a 7 segment
*           display
*
*	 Note: Code is for an active low device: 0 turns on a segment,
*         1 turns off a segment   
*
*/

module hex_7seg(display_on, hex_digit,seg);
input display_on;
input [3:0] hex_digit;
output [6:0] seg;

// seg = {6,5,4,3,2,1,0};
reg [6:0] seg;

always @ (hex_digit, display_on)
	if(display_on)
	begin
		case (hex_digit)
				4'h0: seg = 7'b1000000; // 0x40
				4'h1: seg = 7'b1111001; // 0x79	// ---0----
				4'h2: seg = 7'b0100100; // 0x24	// |	    |
				4'h3: seg = 7'b0110000; // 0x30	// 5	    1
				4'h4: seg = 7'b0011001; // 0x19	// |	    |
				4'h5: seg = 7'b0010010; // 0x12	// ---6----
				4'h6: seg = 7'b0000010; // 0x02	// |	    |
				4'h7: seg = 7'b1111000; // 0x78	// 4	    2
				4'h8: seg = 7'b0000000; // 0x00	// |	    |
				4'h9: seg = 7'b0011000; // 0x18	// ---3----
				4'ha: seg = 7'b0001000;	// 0x08
				4'hb: seg = 7'b0000011; // 0x03
				4'hc: seg = 7'b1000110; // 0x46
				4'hd: seg = 7'b0100001; // 0x21
				4'he: seg = 7'b0000110; // 0x06
				4'hf: seg = 7'b0001110; // 0x0E
		endcase
	end
	else
			seg = 7'b1111111;

endmodule
