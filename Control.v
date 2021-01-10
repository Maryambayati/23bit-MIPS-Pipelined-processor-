module Control(regDst,aluSrc,memtoReg,regWrite,memRead,
memWrite,branch,BranchN, ALUOp2, ALUOp1, ALUOp0,signZero,jmp, Opcode);

input [5:0] Opcode; 
output reg regDst,aluSrc,memtoReg,regWrite,memRead,
memWrite,branch,BranchN, ALUOp2, ALUOp1, ALUOp0,signZero,jmp;

initial begin 
	jmp=1'b0; //
	branch=1'b0;
	BranchN=1'b0;
end


always @(*)
case(Opcode)

	6'b000011 : begin //R type
		aluSrc= 1'b0; //read data2
		regDst= 1'b1; //use rd in WB
		memtoReg= 1'b1; //alu rsult to register 
		regWrite= 1'b1; //write on register file in WB
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b0;
		ALUOp1=1'b1;
		ALUOp0=1'b0; // ALUOp=010 for R type
		signZero= 1'b0; //no sign
		jmp= 1'b0; //no jump
		end
		
	
	6'b001001 : begin //Addi I type
		aluSrc= 1'b1; //read imm
		regDst= 1'b0; //use rt in WB
		memtoReg= 1'b1; //alu rsult to register 
		regWrite= 1'b1; //write on register file in WB
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b0;
		ALUOp1=1'b0;
		ALUOp0=1'b0; // ALUOp=000 for addi to add
		signZero= 1'b1; //sign
		jmp= 1'b0; //no jump
		end
		
	6'b001100 : begin //andi I type
		aluSrc= 1'b1; //read imm
		regDst= 1'b0; //use rt in WB
		memtoReg= 1'b1; //alu rsult to register 
		regWrite= 1'b1; //write on register file in WB
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b1;
		ALUOp1=1'b0;
		ALUOp0=1'b0; // ALUOp=100 for andi 
		signZero= 1'b0; //no sign
		jmp= 1'b0; //no jump
		end
		
		6'b001110 : begin //ori I type
		aluSrc= 1'b1; //read imm
		regDst= 1'b0; //use rt in WB
		memtoReg= 1'b1; //alu rsult to register 
		regWrite= 1'b1; //write on register file in WB
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b1;
		ALUOp1=1'b0;
		ALUOp0=1'b1; // ALUOp=101 for ori
		signZero= 1'b0; //no sign
		jmp= 1'b0; //no jump
		end
		
	6'b000101 : begin //beq I type
		aluSrc= 1'b0; //read data2
		regDst= 1'b0; //don't care
		memtoReg= 1'b1; //don't care
		regWrite= 1'b0; //don't write on register file in WB
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b1; //branch
		ALUOp2=1'b0;
		ALUOp1=1'b0;
		ALUOp0=1'b1; // ALUOp=001 for beq to subtract
		signZero= 1'b0; //sign
		jmp= 1'b0; //no jump
		end
		
		6'b000100 : begin //bnq I type
		aluSrc= 1'b0; //read data2
		regDst= 1'b0; //don't care
		memtoReg= 1'b1; //don't care
		regWrite= 1'b0; //don't write on register file in WB
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //branch
		BranchN=1'b1; //no branch
		ALUOp2=1'b0;
		ALUOp1=1'b0;
		ALUOp0=1'b1; // ALUOp=001 for beq to subtract
		signZero= 1'b0; //sign
		jmp= 1'b0; //no jump
		end
		
		6'b010010 : begin //lw I type
		aluSrc= 1'b1; //read imm
		regDst= 1'b0; //use rt in WB
		memtoReg= 1'b0; //rsult from memory to register 
		regWrite= 1'b1; //write on register file in WB
		memRead= 1'b1; //use data memory to read
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b0;
		ALUOp1=1'b0;
		ALUOp0=1'b0; // ALUOp=000 for LW to add
		signZero= 1'b0; //sign
		jmp= 1'b0; //no jump
		end
		
		6'b101011 : begin //sw I type
		aluSrc= 1'b1; //read imm
		regDst= 1'b0; //dnt care 
		memtoReg= 1'b0; //dnt care
		regWrite= 1'b0; //write on register file in WB
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b1; //use data memory to write
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b0;
		ALUOp1=1'b0;
		ALUOp0=1'b0; // ALUOp=000 for SW to add
		signZero= 1'b0; //sign
		jmp= 1'b0; //no jump
		end
		
		6'b000010 : begin //J J type
		aluSrc= 1'b0; //dnt care
		regDst= 1'b0; //dnt care 
		memtoReg= 1'b0; //dnt care
		regWrite= 1'b0; //dnt care
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b0;
		ALUOp1=1'b0;
		ALUOp0=1'b0; //dnt care
		signZero= 1'b0; //sign
		jmp= 1'b1; //jump
		end
		
		/*
		6'b000111 : begin //Jal J type
		aluSrc= 1'b0; //data2
		regDst= 1'b1; //rd
		memtoReg= 1'b1; //
		regWrite= 1'b0; //dnt care
		memRead= 1'b0; //don't use data memory 
		memWrite= 1'b0; //don't use data memory 
		branch= 1'b0; //no branch
		BranchN=1'b0; //no branch
		ALUOp2=1'b0;
		ALUOp1=1'b1;
		ALUOp0=1'b0; // ALUOp=010 for R type
		signZero= 1'b0; //sign
		jmp= 1'b1; //jump
		end
		*/
		
		endcase
		

	
endmodule