//Name:yazan issa alhroub
//ID:0145597



module Processor_CH(clk, reset, enable);
input clk, reset, enable;



wire [31:0] cpout, cpin,pcplus4,winstF,winstD,winstX,wsignextendD,wsignextendX,borpc4,finaladdress,fmuxout,jumpmux,FAmuxout,FBmuxout,FBmuxoutM;
wire [31:0]alub,readdata1 ,readdata2,readdata1X ,readdata2X,readdata2M,wsl32_2,wadd1F,wadd1D,wadd1X,wadd1M,wadd1W,wadd2,memoryout,memoryoutW,aluresult,aluresultM,aluresultW;
wire [4:0]instm,instmM,instmW;
wire [3:0] aluop1,aluop1X; //changed
wire [1:0] regdst1,regdst1X, memtoreg1,memtoreg1X,memtoreg1M,memtoreg1W,ForwardA, ForwardB;
wire alusrc1,alusrc1X, regwrite1,regwrite1X,regwrite1M,regwrite1W,memread1,memread1X,memread1M, memwrite1,memwrite1X,memwrite1M, branch1, jump1, pcsrc1,andout,compout;
wire [27:0] sh26out;
wire Flush,wresetOR;

//REG32negclk ProgramCounter(Q, D, clk, reset, enable); 
//REG32negclk ProgramCounter(cpout, cpin, clk, reset, enable);

//Instruction_Memory(PC, instruction); 
Instruction_Memory im(cpout, winstF);

//Adder32bit (out, a, b); for PC + 4
 //Adder32bit prcplus4 (pcplus4, cpout, 32'd4);

//Mux_3_to_1_5bit(out, s, i2, i1, i0); 
Mux_3_to_1_5bit instmux (instm, regdst1X, 5'd31, winstX[15:11], winstX[20:16]);




//ControlUnit(aluop, ��, jump, pcsrc, opcode, func);
ControlUnit CU (aluop1, alusrc1, regdst1, memtoreg1, regwrite1,memread1, memwrite1, branch1, jump1, pcsrc1, winstD[31:26], winstD[5:0]); 

 
//ShiftLeft26_by2(out, in);
ShiftLeft26_by2 shift26(sh26out, winstD[25:0]);
 
//SignExtend (out, in);
SignExtend SignExtend16  (wsignextendD, winstD[15:0]);



 
//RegFile(readdata1 ,readdata2, ���, clk, reset); 
RegFile RF(readdata1 ,readdata2, winstD[25:21], winstD[20:16], fmuxout, instmW, regwrite1W, clk, reset); 





//Mux_2_to_1_32bit(out, s, i1, i0); for the input b of the ALU
Mux_2_to_1_32bit M2to1(alub, alusrc1X, wsignextendX, FBmuxout);

 
//ALU_32(result, a, b, m);
ALU_32 alu32(aluresult, FAmuxout, alub, aluop1X);


 
//ShiftLeft32_by2(out, in); 
ShiftLeft32_by2 sl32_2(wsl32_2, wsignextendD);




//Adder32bit (out, a, b); to calculate branch target Address
Adder32bit add1 (wadd1F, 32'd4, cpout);
Adder32bit add2 (wadd2, wadd1D, wsl32_2);




 
//Comparator32bit (equal, a, b);
Comparator32bit Comparator32 (compout, readdata1, readdata2);


//AND (out, in1, in2); 
AND and1 (andout,compout, branch1); 




//Mux_2_to_1_32bit(out, s, i1, i0); branch address or PC + 4 
Mux_2_to_1_32bit baddressorPC4 (borpc4, andout, wadd2, wadd1F);




//Mux_2_to_1_32bit(out, s, i1, i0); jump address or jr
   Mux_2_to_1_32bit jumpmx (jumpmux, jump1, {wadd1D[31:28],sh26out}, readdata1);


//Mux_2_to_1_32bit(out, s, i1, i0); select the final address
Mux_2_to_1_32bit finaladdressmux (cpin, pcsrc1, jumpmux, borpc4);

 


 
//Data_Memory(readdata , address, ��., clk );
Data_Memory DM (memoryout , aluresultM, FBmuxoutM , memwrite1M , memread1M , clk);

 
//Mux_3_to_1_32bit(out, s, i2, i1, i0); 
Mux_3_to_1_32bit finalmux (fmuxout, memtoreg1W, wadd1W, memoryoutW, aluresultW);


ProgramCounter pcreg (cpout, cpin,clk,reset,enable);

IFID IFIDreg ({wadd1D,winstD}, {wadd1F,winstF}, clk, wresetOR, enable);

IDEX IDEXreg ({regwrite1X,memtoreg1X,memwrite1X,memread1X,aluop1X,regdst1X,alusrc1X,wadd1X,readdata1X ,readdata2X,wsignextendX,winstX[25:11]},
  {regwrite1,memtoreg1,memwrite1,memread1,aluop1,regdst1,alusrc1,wadd1D,readdata1 ,readdata2,wsignextendD,winstD[25:11]}, clk, reset, enable);

EXMEM EXMEMreg ({regwrite1M,memtoreg1M,memwrite1M,memread1M,wadd1M,aluresultM,FBmuxoutM,instmM},
{regwrite1X,memtoreg1X,memwrite1X,memread1X,wadd1X,aluresult,FBmuxout,instm}, clk, reset, enable);/////////

MEMWB MEMWBreg ({regwrite1W,memtoreg1W,wadd1W,memoryoutW,aluresultW,instmW},
                {regwrite1M,memtoreg1M,wadd1M,memoryout,aluresultM,instmM}, clk, reset, enable);



ForwardingUnit f1 (ForwardA, ForwardB, instmM, instmW, winstX[25:21], winstX[20:16], regwrite1M, regwrite1W);

//Mux_3_to_1_32bit(out, s, i2, i1, i0);
Mux_3_to_1_32bit FAmux (FAmuxout, ForwardA, fmuxout, aluresultM, readdata1X);
//Mux_3_to_1_32bit(out, s, i2, i1, i0);
Mux_3_to_1_32bit FBmux (FBmuxout, ForwardB, fmuxout, aluresultM, readdata2X);


HazardDetectionUnit HDU (Flush, pcsrc1, andout);
OR ooo (wresetOR,reset,Flush);


endmodule
