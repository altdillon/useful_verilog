module synch_ram(input clk,input chipsel,input writeEn,input readEn,input [7:0] busIn,output reg [7:0] busOut,input [15:0] addrIn);
  reg [7:0] mem [9999:0];

  wire op_write, op_read; // enable lines for verious operations
  assign op_write = chipsel & writeEn;
  assign op_read = chipsel & readEn;

 initial begin
   // load some stuff from input
   $readmemh("testprog.mem",mem);
   busOut = 8'h00;
 end

  // write operation
  always @(posedge clk)
    begin
      if(op_write)
        begin
          mem[addrIn] <= busIn;
        end
    end

  // read operation
  always @(posedge clk)
    begin
      if(op_read)
        begin
          //$display("op read! address: %x",addrIn);
          busOut <= mem[addrIn];
        end
    end

endmodule //
