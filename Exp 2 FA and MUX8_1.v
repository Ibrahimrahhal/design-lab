module FullAdder(Cout, sum, a, b, Cin); 
output sum, Cout; 
input Cin, a, b; 
wire w1,w2,w3;

XOR3 x0(sum,a,b,Cin);
AND a0(w1,a,b);
AND a1(w2,a,Cin);
AND a2(w3,b,Cin);
OR3 o0(Cout,w1,w2,w3);
endmodule 

///////////////////////////////////////////////////////////////////
module Mux_8_to_1(result, s, in);
  output result;
  input [2:0] s;
  input [7:0] in;
  wire   n0,n1,n2,w0,w1,w2,w3,w4,w5,w6,w7;

  INV i0(n0, s[0]);
  INV i1(n1, s[1]);
  INV i2(n2, s[2]);
  AND4 a0 (w0, in[0], n2  , n1  , n0);
  AND4 a1 (w1, in[1], n2  , n1  , s[0]);
  AND4 a2 (w2, in[2], n2  , s[1], n0);
  AND4 a3 (w3, in[3], n2  , s[1], s[0]);
  AND4 a4 (w4, in[4], s[2], n1  , n0);
  AND4 a5 (w5, in[5], s[2], n1  , s[0]);
  AND4 a6 (w6, in[6], s[2], s[1], n0);
  AND4 a7 (w7, in[7], s[2], s[1], s[0]);
  OR8 o1  (result, w7, w6, w5, w4, w3, w2, w1, w0);
endmodule 
