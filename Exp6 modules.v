//Name:yazan issa alhroub
//ID:0145597


module Adder32bit (out, a, b); 
input [31:0]a, b; 
output [31:0]out; 

assign #50 out=a+b;
// implementation details are left to the student …… 

endmodule 

//////////////////////////////////////////////////////

 module SignExtend (out, in); 
input [15:0]in; 
output [31:0]out; 


assign out={{16{in[15]}},in};

// implementation details are left to the student …… 

endmodule 

//////////////////////////////////////////////////////

module Comparator32bit (equal, a, b); 
input [31:0]a, b; 
output equal; 
reg equal;
always @(a or b)
#10 if(a==b)
equal=1'b1;
else
equal=1'b0;

// implementation details are left to the student …… 

endmodule 

//////////////////////////////////////////////////////

module ShiftLeft26_by2(out, in); 
input [25:0]in; 
output [27:0]out; 


assign out=in<<2;

// implementation details are left to the student …… 

endmodule 

//////////////////////////////////////////////////////

module ShiftLeft32_by2(out, in); 
input [31:0]in; 
output [31:0]out; 

assign out=in<<2;
// implementation details are left to the student …… 

endmodule 

//////////////////////////////////////////////////////

module Mux_3_to_1_5bit(out, s, i2, i1, i0); 
input [4:0] i2, i1, i0; 
input [1:0]s; 
output [4:0]out; 
reg [4:0]out;
always @(s or i0 or i1 or i2)
#6 case (s)
2'b00 :  out=i0;
2'b01 :  out=i1;
2'b10 :  out=i2;
endcase

/*assign #6 out=(i0[4:0]& ~s[1] & ~s[0])|
              (i1[4:0]& ~s[1] & s[0])|
              (i2[4:0]& s[1] & ~s[0]);*/

// implementation details are left to the student …… 

endmodule 

//////////////////////////////////////////////////////

module Mux_3_to_1_32bit(out, s, i2, i1, i0); 
input [31:0] i2, i1, i0; 
input [1:0]s; 
output [31:0]out; 
reg [31:0]out;
always @(s or i0 or i1 or i2)
#6
case (s)
2'b00 :  out=i0;
2'b01 :  out=i1;
2'b10 :  out=i2;
endcase

 


 /*assign #6 out=       (i0[31:0]& ~s[1] & ~s[0])|
              (i1[31:0]& ~s[1] & s[0])|
              (i2[31:0]& s[1] & ~s[0]);*/



// implementation details are left to the student …… 

endmodule 

//////////////////////////////////////////////////////

module Mux_2_to_1_32bit(out, s, i1, i0); 
input [31:0] i1, i0; 
input s; 
output [31:0]out; 
reg [31:0]out;
always @(s or i0 or i1)
#6 case (s)
1'b0 :  out=i0;
1'b1 :  out=i1;
endcase

//assign #6 out=(i0[31:0]& ~s)|(i1[31:0]& s);

// implementation details are left to the student …… 

endmodule 





