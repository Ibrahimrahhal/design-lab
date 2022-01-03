module test ; 
reg clk, reset, enable; 



Processor_CH ProcessorCH(clk,reset,enable);
 // implementation details are left to the student 

initial begin : stop_at 
#2400 ; $finish ;
end 

initial begin : init 

reset=1 ; enable=1; clk =1;
#60 reset=0 ;

end
 
always #50 clk=~clk;

endmodule 

