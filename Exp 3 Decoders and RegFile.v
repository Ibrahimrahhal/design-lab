//Name:yazan issa alhroub
//ID:0145597

module Decoder2to4 (out, in, enable); 
input enable; 
input [1:0]in; 
output [3:0]out;
wire w1,w2; 

INV inv1 (w1, in[0]);
INV inv2 (w2, in[1]);

AND3 and0 (out[0], w1, w2, enable);
AND3 and1 (out[1], w2, in[0], enable);
AND3 and2 (out[2], in[1], w1, enable);
AND3 and3 (out[3], in[1], in[0], enable);

endmodule 

///////////////////////////////////////////////////////////////////

module Decoder3to8 (out, in, enable); 
input enable; 
input [2:0]in; 
output [7:0]out; 

wire w1,w2,w3; 

INV inv1 (w1, in[0]);
INV inv2 (w2, in[1]);
INV inv3 (w3, in[2]);

AND4 and0 (out[0],w3, w2, w1, enable);
AND4 and1 (out[1],w3, w2, in[0], enable);
AND4 and2 (out[2],w3, in[1], w1, enable);
AND4 and3 (out[3],w3, in[1], in[0], enable);
AND4 and4 (out[4],in[2], w2, w1, enable);
AND4 and5 (out[5],in[2], w2, in[0], enable);
AND4 and6 (out[6],in[2], in[1], w1, enable);
AND4 and7 (out[7],in[2], in[1], in[0], enable);



endmodule 

///////////////////////////////////////////////////////////////////

module Decoder5to32 (out, in, enable); 
input enable; 
input [4:0]in; 
output [31:0]out; 

wire [3:0]w;

Decoder2to4 dec0 (w, in[4:3], enable);

Decoder3to8 dec00 (out[7:0], in[2:0], w[0]); 
Decoder3to8 dec01 (out[15:8], in[2:0],w[1]); 
Decoder3to8 dec10 (out[23:16], in[2:0], w[2]); 
Decoder3to8 dec11 (out[31:24], in[2:0],w[3]); 

endmodule 

///////////////////////////////////////////////////////////////////

module RegFile(readdata1 ,readdata2, readreg1, readreg2, writedata, writereg, regwrite, clk, reset); 
input regwrite, clk, reset; 
input [4:0]readreg1, readreg2, writereg; 
input [31:0]writedata; 
output [31:0]readdata1, readdata2;
wire [31:0]w;
wire [31:0] R31,R30,R29,R28,R27,R26,R25,R24,R23,R22,R21,R20,R19,R18,R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0 ;
 

Decoder5to32 dec000 (w, writereg, regwrite);

REG32negclk r0 (R0, writedata, clk, reset, 1'b0);
REG32negclk r1 (R1,writedata, clk, reset, w[1]);
REG32negclk r2 (R2, writedata, clk, reset, w[2]);
REG32negclk r3 (R3,writedata, clk, reset, w[3]);
REG32negclk r4 (R4,writedata, clk, reset, w[4]);
REG32negclk r5 (R5, writedata, clk, reset, w[5]);
REG32negclk r6 (R6,writedata, clk, reset, w[6]);
REG32negclk r7 (R7, writedata, clk, reset, w[7]);
REG32negclk r8 (R8, writedata, clk, reset, w[8]);
REG32negclk r9 (R9, writedata, clk, reset, w[9]);
REG32negclk r10 (R10,writedata, clk, reset, w[10]);
REG32negclk r11 (R11, writedata, clk, reset, w[11]);
REG32negclk r12 (R12, writedata, clk, reset, w[12]);
REG32negclk r13 (R13,writedata, clk, reset, w[13]);
REG32negclk r14 (R14, writedata, clk, reset, w[14]);
REG32negclk r15 (R15, writedata, clk, reset, w[15]);
REG32negclk r16 (R16, writedata, clk, reset, w[16]);
REG32negclk r17 (R17, writedata, clk, reset, w[17]);
REG32negclk r18 (R18, writedata, clk, reset, w[18]);
REG32negclk r19 (R19, writedata, clk, reset, w[19]);
REG32negclk r20 (R20, writedata, clk, reset, w[20]);
REG32negclk r21 (R21, writedata, clk, reset, w[21]);
REG32negclk r22 (R22, writedata, clk, reset, w[22]);
REG32negclk r23 (R23, writedata, clk, reset, w[23]);
REG32negclk r24 (R24, writedata, clk, reset, w[24]);
REG32negclk r25 (R25, writedata, clk, reset, w[25]);
REG32negclk r26 (R26, writedata, clk, reset, w[26]);
REG32negclk r27 (R27, writedata, clk, reset, w[27]);
REG32negclk r28 (R28, writedata, clk, reset, w[28]);
REG32negclk r29 (R29, writedata, clk, reset, w[29]);
REG32negclk r30 (R30, writedata, clk, reset, w[30]);
REG32negclk r31 (R31, writedata, clk, reset, w[31]);

Mux_32_to_1_32bit mu1(readdata1, readreg1, {R31,R30,R29,R28,R27,R26,R25,R24,R23,R22,R21,R20,R19,R18,R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0});
Mux_32_to_1_32bit mu2(readdata2, readreg2, {R31,R30,R29,R28,R27,R26,R25,R24,R23,R22,R21,R20,R19,R18,R17,R16,R15,R14,R13,R12,R11,R10,R9,R8,R7,R6,R5,R4,R3,R2,R1,R0});



endmodule 







