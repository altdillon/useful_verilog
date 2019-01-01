module synch_ram_tb();

  reg clk,ren,wen,cs1;
  reg [7:0] dataI;
  reg [15:0] addr;
  wire [7:0] dataOut;

  initial begin
    $display("synch ram test bench");
    // first test, write 0xBE
    cs1 = 1'b1;
    wen = 1'b0;
    ren = 1'b1; // turn read on
    addr = 16'h0000;
    dataI = 8'h00;
    //addr = 16'h0000;
    for(addr = 16'h0000;addr < 16'h000d;addr = addr + 1)
      begin
        // cycle the clock 1 time
        clk = 1'b1; #1;
        clk = 1'b0; #1;
        clk = 1'b1; #1;
        $display("addr: %x, data: %x ",addr,dataOut); // display data while the clock is high
        clk = 1'b0; #1;
      end
      // try writing to a random address
       ren = 1'b0;
       wen = 1'b1;
       addr = 16'h0FAA;
       dataI = 8'hEA;
       clk = 1'b1; #1; clk = 1'b0; #1;
       // read from that same address 
       ren = 1'b1;
       wen = 1'b0;
       // run the clock 
       clk = 1'b1; #1;
       clk = 1'b0; #1;
       clk = 1'b1; #1;
       $display("reading from some place in ram");
       $display("addr: %x, data: %x ",addr,dataOut);
       clk = 1'b0; #1;

      $finish;
  end

  synch_ram DUT1(.clk(clk),.chipsel(cs1),.writeEn(wen),.readEn(ren),.busIn(dataI),.busOut(dataOut),.addrIn(addr));

endmodule
