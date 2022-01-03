//Name:yazan issa alhroub
//ID:0145597


module Data_Memory(readdata , address, writedata , memwrite , memread , clk); 
input [31:0] address , writedata ; 
input memwrite , memread , clk; 
output [31:0] readdata; 
reg [31:0] readdata; 
reg [31:0] DM [255:0]; 
integer i;
	initial begin 
	for(i=0;i<256;i=i+1)
        DM[i]=i;	 
	end 

always @(posedge clk)
 begin  #5; if(memwrite==1)
               DM[address>>2]=writedata; 
            end

always @(address or memread)
 begin  #15; if(memread==1)
               readdata=DM[address>>2];
             end


endmodule 
/*
	reg [31:0] instruction; 
	reg [31:0] IM [255:0]; 
	initial begin 
		 IM[0] = 32'h00000010;
		 IM[1] = 32'h00000020;
		 IM[2] = 32'h00000030;
		 IM[3] = 32'h00000040;
		 IM[4] = 32'h00000050;
	end 
	always @ (PC ) 
		#15 instruction = IM[PC>>2]; 
*/

