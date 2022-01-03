//Name:yazan issa alhroub
//ID:0145597

module ALU_1(result, sum, Cout, Cin, a, b, less, m); 
output result, sum, Cout; 
input Cin, a, b, less; 
input [2:0] m;
wire wOR,wAND,wXOR,wXORm,wNOR,wNAND;
OR or1 (wOR, a, b);
AND and1 (wAND, a, b);
XOR xor1 (wXOR, a, b);
FullAdder adder1 (Cout, sum, a, wXORm, Cin);
NAND nand1 (wNAND, a, b);
NOR nor1 (wNOR, a, b);
XOR xor2 (wXORm, m[2], b);
Mux_8_to_1 mux1(result, m, {sum,less,wNAND,wNOR,sum,wXOR,wAND,wOR});

endmodule 

///////////////////////////////////////////////////////////////////

module ALU_8(result, sum, Cout, Cin, a, b, less, m);
  output [7:0]result, sum;
  output Cout;
  input  Cin;
  input  [7:0]a, b, less;
  input  [2:0] m;
  wire wCout0,wCout1,wCout2,wCout3,wCout4,wCout5,wCout6;

ALU_1 alu8_0(result[0], sum[0], wCout0, Cin,    a[0], b[0], less[0], m);
ALU_1 alu8_1(result[1], sum[1], wCout1, wCout0, a[1], b[1], less[1], m); 
ALU_1 alu8_2(result[2], sum[2], wCout2, wCout1, a[2], b[2], less[2], m); 
ALU_1 alu8_3(result[3], sum[3], wCout3, wCout2, a[3], b[3], less[3], m); 
ALU_1 alu8_4(result[4], sum[4], wCout4, wCout3, a[4], b[4], less[4], m); 
ALU_1 alu8_5(result[5], sum[5], wCout5, wCout4, a[5], b[5], less[5], m); 
ALU_1 alu8_6(result[6], sum[6], wCout6, wCout5, a[6], b[6], less[6], m); 
ALU_1 alu8_7(result[7], sum[7], Cout, wCout6,   a[7], b[7], less[7], m); 
    

endmodule

///////////////////////////////////////////////////////////////////

module ALU_32(result, a, b, m); 
output [31:0]result; 
input [31:0]a, b; 
input [3:0] m; //changed
wire [31:0]sum;
wire wcout0,wcout1,wcout2,Cout;
wire w111; //changed
XOR xor11 (w111, m[3], sum[31]); //changed
ALU_8 alu32 (result[7:0], sum[7:0], wcout0, m[2], a[7:0], b[7:0], {7'b0, w111}, m); //changed
ALU_8 alu32 (result[15:8], sum[15:8], wcout1, wcout0, a[15:8], b[15:8], 8'b0, m);
ALU_8 alu32 (result[23:16], sum[23:16], wcout2, wcout1, a[23:16], b[23:16], 8'b0, m);
ALU_8 alu32 (result[31:24], sum[31:24], Cout, wcout2, a[31:24], b[31:24], 8'b0, m);


endmodule 

///////////////////////////////////////////////////////////////////
