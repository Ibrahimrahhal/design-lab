//Name:yazan issa alhroub
//ID:0145597

module ControlUnit(aluop, alusrc, regdst, memtoreg, regwrite,memread, memwrite, branch, jump, pcsrc, opcode, func); 
input [5:0] opcode, func; 
output [3:0]aluop; // changed
output [1:0]regdst, memtoreg; 
output alusrc, regwrite, memread, memwrite, branch, jump, pcsrc; 
wire [5:0] invop;
wire [18:0] w; // changed
wire invfunc3;

INV i1 (invop[0],opcode[0]);
INV i2 (invop[1],opcode[1]);
INV i3 (invop[2],opcode[2]);
INV i4 (invop[3],opcode[3]);
INV i5 (invop[4],opcode[4]);
INV i6 (invop[5],opcode[5]);
INV i7 (invfunc3,func[3]);



//aluop
AND3 a1 (w[0], invop[5], invop[4], func[0]);
AND3 a2 (w[1], invop[5], opcode[4], opcode[0]);
AND a3 (w[2], opcode[5], invop[4]);
OR3 o1 (aluop[0], w[0], w[1], w[2]);

AND3 a11 (w[3], invop[5], invop[4], func[1]);
AND3 a22 (w[4], invop[5], opcode[4], opcode[1]);
AND a33 (w[5], opcode[5], invop[4]);
OR3 o2 (aluop[1], w[3], w[4], w[5]);


AND3 a111 (w[6], invop[5], invop[4], func[2]);
AND3 a222 (w[7], invop[5], opcode[4], opcode[2]);
OR o3 (aluop[2], w[6], w[7]);


AND a1111 (w[16], opcode[4], opcode[3]);  // changed
AND a2222 (w[17], func[5], func[3]);  // changed
AND a3333 (w[18], opcode[3], invop[4]);  // changed

OR o33333 (aluop[3], w[17], w[16]);  // changed


//regdst
AND rega0 (regdst[0], invop[5], invop[4]);
AND3 rega1 (regdst[1], opcode[5], opcode[4],opcode[1]);

//memtoreg
AND3 mema1 (memtoreg[0], opcode[5], invop[4],invop[3]);
AND3 mema2 (memtoreg[1], opcode[5], opcode[4],opcode[1]);

//alusrc
AND alua0 (w[8], invop[5], opcode[4]);
AND alua1 (w[9], opcode[5], invop[4]);
OR o1111 (alusrc, w[8], w[9]);

//regwrite
AND rega0 (w[10], invop[5], opcode[4]);
AND3 rega1 (w[11], invop[5], invop[4],invfunc3);
AND3 rega2 (w[12], opcode[5], invop[4],invop[3]);
AND3 rega3 (w[13], opcode[5], opcode[4],opcode[1]);
OR4 o112 (regwrite, w[10], w[11], w[12], w[13]);


//memread
AND3 memaa1 (memread, opcode[5], invop[4],invop[3]);

//memwrite
AND3 memwa1 (memwrite, opcode[5], invop[4], w[18]); // changed

//branch
AND4 branch1 (branch, opcode[5], opcode[4], invop[1], invop[0]);

//jump
AND3 jump1 (jump, opcode[5], opcode[4],opcode[0]);

//pcsrc
AND3 pcsrc0 (w[14], invop[5], invop[4],func[3]);
AND3 pcsrc1 (w[15], opcode[5], opcode[4],opcode[0]);
OR opcsrc (pcsrc, w[14], w[15]);

endmodule  
