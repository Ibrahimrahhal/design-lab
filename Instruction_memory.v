
 module Instruction_Memory(PC, instruction); 
input [31:0] PC; 
output [31:0] instruction; 
reg [31:0] instruction; 
reg [31:0] IM [255:0]; 
initial begin 
IM[0] = 32'h8c010004; 
IM[1] = 32'h8c02000c; 
IM[2] = 32'h8c030014; 
IM[3] = 32'h8c04001c; 
IM[4] = 32'h00232805; 
IM[5] = 32'h50a603ff;
IM[6] = 32'h00824007;
IM[7] = 32'hcc00000b;
IM[8] = 32'h00a63802;
IM[9] = 32'hac070008;
IM[10] = 32'hc4000013;
IM[11] = 32'h4d080002;
IM[12] = 32'hac050004;
IM[13] = 32'hac060018;
IM[14] = 32'hc068fffc;
IM[15] = 32'h01034807;
IM[16] = 32'h03e00008;
IM[17] = 32'h00e95000;
IM[18] = 32'h01245806;
end 
//MIPS instruction is 4 Byte, Processor counts bytes not words 
always @ (PC ) 
#15 instruction = IM[PC>>2]; //To get the correct 
//address, we divide by 4 
endmodule 
