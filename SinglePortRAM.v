module Single_Port_RAM(clk,rst,Wr_Rd,valid,ADDR,WDATA,RDATA,ready);
  
  parameter N = 4;  //No. of Address Lines
  parameter D = 16; //Depth of Memory
  parameter W = 8;  //Width of Memory
  
  input clk,rst,Wr_Rd,valid;
  input [N-1:0] ADDR;
  input [W-1:0] WDATA;
  output[W-1:0] RDATA;
  output ready;
  
  reg [W-1:0] temp_read;
  reg [W-1:0] mem [D-1:0];
  integer i;
  
  always@(posedge clk)
    begin
      if(valid)
        begin
      if(!rst) //active low reset
        begin
          
          for(i = 0;i<D;i=i+1)
            mem[i] = 0;
        end
      else if(Wr_Rd && valid)
        mem[ADDR] = WDATA;
        end
    end 
  
  always@(posedge clk)
    if(!Wr_Rd && valid)
        temp_read = mem[ADDR];
  
  assign ready = (!Wr_Rd)&&valid;
  assign RDATA = (ready==1)?temp_read:16'bx;
  
endmodule