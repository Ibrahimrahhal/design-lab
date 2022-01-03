// Name:yazan issa alhroub
// ID:0145597
// No. Cycles (including reset)=_______________
/////////////////////////////////////////

module Comparator5bit (equal, a, b);
input [4:0]a, b;
output equal;
wire w0,w1,w2,w3,w4,w5;
XNOR x0 (w0,a[0],b[0]);
XNOR x1 (w1,a[1],b[1]);
XNOR x2 (w2,a[2],b[2]);
XNOR x3 (w3,a[3],b[3]);
XNOR x4 (w4,a[4],b[4]);
AND4 a0 (w5,w0,w1,w2,w3);
AND  a1 (equal,w5,w4);
endmodule 
//////////////////////////////////////////////////////
module ForwardingUnit(ForwardA, ForwardB, EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt, EXMEM_RegWrite, MEMWB_RegWrite);
input [4:0] EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt;
input EXMEM_RegWrite, MEMWB_RegWrite;
output [1:0]ForwardA, ForwardB;
wire w1,w2,w3,w4,w5,w6,w7,w8,w9,w10,w11;

Comparator5bit c1 (w1, EXMEM_Rd,IDEX_Rs);
Comparator5bit c2 (w2, EXMEM_Rd,5'b0);
INV i1 (w3,w2);
AND3 a1 (ForwardA[0],EXMEM_RegWrite,w1,w3);

Comparator5bit c3 (w4, EXMEM_Rd,IDEX_Rt);
Comparator5bit c4 (w5, EXMEM_Rd,5'b0);
INV i2 (w6,w5);
AND3 a2 (ForwardB[0],EXMEM_RegWrite,w4,w6);

Comparator5bit c5 (w7, MEMWB_Rd,IDEX_Rs);
INV i3 (w8,w1);
Comparator5bit c6 (w9, EXMEM_RegWrite,5'b0);
Comparator5bit c7 (w10, MEMWB_Rd,5'b0);
INV i3 (w11,w10);
OR o1 (w12,w8,w9);
AND4 a3 (ForwardA[1],MEMWB_RegWrite,w7,w12,w11);


Comparator5bit c8 (w13, MEMWB_Rd,IDEX_Rt);
INV i4 (w14,w4);
Comparator5bit c9 (w15, EXMEM_RegWrite,5'b0);
Comparator5bit c10 (w16, MEMWB_Rd,5'b0);
INV i5 (w17,w16);
OR o2 (w18,w14,w15);
AND4 a4 (ForwardB[1],MEMWB_RegWrite,w13,w18,w17);


endmodule
//////////////////////////////////////////////////////









