//Name:yazan issa alhroub
//ID:0145597


// No. Cycles (including reset)=_______________

/////////////////////////////////////////

module ProgramCounter (Q,D,clk,reset,enable);
input clk,reset,enable ;
input  [31:0] D;
output [31:0] Q;
REG8 regpc1 (Q[7:0],D[7:0],clk,reset,enable);
REG8 regpc2 (Q[15:8],D[15:8],clk,reset,enable);
REG8 regpc3 (Q[23:16],D[23:16],clk,reset,enable);
REG8 regpc4 (Q[31:24],D[31:24],clk,reset,enable);

endmodule 

//////////////////////////////////////////////////////


module IFID (Q, D, clk, reset, enable);
input clk, reset, enable;
input [63:0] D;
output [63:0] Q;

ProgramCounter  IFIDREG1 (Q[31:0],D[31:0],clk,reset,enable);
ProgramCounter  IFIDREG2 (Q[63:32],D[63:32],clk,reset,enable);

endmodule

//////////////////////////////////////////////////////

module IDEX (Q, D, clk, reset, enable);
input clk, reset, enable;
input [154:0] D; //changed
output [154:0] Q; //changed
IFID IDEXreg1 (Q[63:0], D[63:0], clk, reset, enable);
IFID IDEXreg2 (Q[127:64], D[127:64], clk, reset, enable);
REG8 IDEXreg3 (Q[135:128],D[135:128],clk,reset,enable);
REG8 IDEXreg4 (Q[143:136],D[143:136],clk,reset,enable);
REG8 IDEXreg5 (Q[151:144],D[151:144],clk,reset,enable);
DFF  IDEXdff6 (Q[152], D[152], clk, reset,enable);
DFF  IDEXdff7 (Q[153], D[153], clk, reset,enable);
DFF  IDEXdff8 (Q[154], D[154], clk, reset,enable); //changed

endmodule

//////////////////////////////////////////////////////

module EXMEM (Q, D, clk, reset, enable);
input clk, reset, enable;
input [105:0] D;
output [105:0] Q;
IFID EXMEMreg1 (Q[63:0], D[63:0], clk, reset, enable);
ProgramCounter EXMEMreg2  (Q[95:64],D[95:64],clk,reset,enable);
REG8  EXMEMreg3 (Q[103:96],D[103:96],clk,reset,enable);
DFF  IDEXdff6 (Q[104], D[104], clk, reset,enable);
DFF  IDEXdff7 (Q[105], D[105], clk, reset,enable);

endmodule

//////////////////////////////////////////////////////

module MEMWB (Q, D, clk, reset, enable);
input clk, reset, enable;
input [103:0] D;
output [103:0] Q;
IFID MEMWBreg1 (Q[63:0], D[63:0], clk, reset, enable);
ProgramCounter MEMWBreg2  (Q[95:64],D[95:64],clk,reset,enable);
REG8  MEMWBreg3 (Q[103:96],D[103:96],clk,reset,enable);


endmodule







