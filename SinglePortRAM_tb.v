module tb;
  
  reg clk,rst,Wr_Rd,valid;
  reg [7:0] WDATA;
  reg [3:0] ADDR;
  wire [7:0] RDATA;
  wire ready;
  
  Single_Port_RAM DUT (clk,rst,Wr_Rd,valid,ADDR,WDATA,RDATA,ready);
  
  initial begin
    rst = 0;
    clk = 0;
    forever
      #5 clk = ~clk;
  end
  
  initial begin
    $monitor("Time = %3t, clk=%0b, rst=%b,Wr_Rd=%b,valid=%b,ADDR=%b,WDATA=%b,RDATA=%b,ready=%b",$time,clk,rst,Wr_Rd,valid,ADDR,WDATA,RDATA,ready);
    
    valid=0; #10
    rst=1;
     
    Wr_Rd=1;//Write Data
    for(integer i=0;i<16;i=i+1) begin
      repeat(1) @(posedge clk)
        begin
          ADDR=i;
          WDATA = $random;
        end
    end
    
    Wr_Rd=0;//Read Data
    for(integer i=0;i<16;i=i+1) begin
      repeat(1) @(posedge clk)
        begin
          ADDR=i;
        end
    end
    
    #10
    valid=1;
     
    Wr_Rd=1;//Write Data
    for(integer i=0;i<16;i=i+1) begin
      repeat(1) @(posedge clk)
        begin
          ADDR=i;
          WDATA = $random;
        end
    end
    
    #10
    Wr_Rd=0;//Read Data
    for(integer i=0;i<16;i=i+1) begin
      repeat(1) @(posedge clk)
        begin
          ADDR=i;
        end
    end
    
	#10 $finish;
    
  end
  
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars;
  end
  
endmodule