//declares a 32x32 register file.
module registerFile(clk, regWriteEn, readR1, readR2, writeR, 
writeData, readData1, readData2);//parameters
	//dnt forget list 
	//this module is not complete ... you should use these names to declare the register file unit 
	//int complete 
//int instructions	
reg [31:0] registers_i[31:0];// create registers from 0 - 31

input clk;
input regWriteEn;

input [4:0] readR1;
input [4:0] readR2;
input [4:0] writeR;
input [31:0]writeData;


output [31:0]readData1;
output [31:0]readData2;


initial 
	begin
   //random values stored in registers   
	 registers_i[0] = 32'h0000; //zero register constant value
   // registers_i[8] = 32'h0003; //t0
   // registers_i[9] = 32'h0008; //t1
    
	 
	end	
  
  assign readData1 = registers_i[readR1];
  assign readData2 = registers_i[readR2];
  
 always @ (negedge clk) begin
    if (regWriteEn==1) 
		registers_i[writeR] <= writeData;
  end 
  
  
  
endmodule