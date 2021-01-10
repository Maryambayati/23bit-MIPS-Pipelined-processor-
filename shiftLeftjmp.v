module shiftLeftjmp(Out, In);
output [27:0] Out;
input [25:0] In;
assign Out = {In[25:0],2'b00};
endmodule