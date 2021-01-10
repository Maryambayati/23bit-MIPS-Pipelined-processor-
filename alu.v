module alu(aluControl,input1,input2,shamt,result,zero);

	input [3:0] aluControl;
	input [31:0] input1;
	input [31:0] input2;
	input [4:0] shamt;

	output reg [31:0] result;
	output reg zero;
	
	
	
	
	always @(*)begin
		case (aluControl)
		0: result <= input1 & input2;        //AND
		1: result <= input1 | input2;        //OR
		2: result <= input1 + input2;        //ADD
		6: result <= input2 - input1;        //SUB
		7: result <= input1 < input2 ? 1:0;  //slt
		8: result <= (~input1+1) < (~input2+1) ? 1:0; //sltu
		9: result <= input2 << shamt;            //srl
		10: result <= input2 >> shamt;           //sll
	  	12: result <= ~(input1 | input2);         //nor
	  
	  default: result <= 0;
			
		endcase
		zero <= result==0; //if result is zero then flag = true
	end
endmodule