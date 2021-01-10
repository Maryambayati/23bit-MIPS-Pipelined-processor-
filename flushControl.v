module flushControl(RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,
MemWrite,Branch,BranchN, ALUOp2, ALUOp1, ALUOp0,jump, flushSignal,RegDstID,ALUSrcID,
MemtoRegID,RegWriteID,MemReadID,MemWriteID,BranchID,BranchNID, ALUOp2ID, ALUOp1ID, ALUOp0ID,jumpID);

output reg RegDstID,ALUSrcID,MemtoRegID,RegWriteID,MemReadID,
MemWriteID,BranchID,BranchNID, ALUOp2ID, ALUOp1ID, ALUOp0ID,jumpID;

input RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,
MemWrite,Branch,BranchN, ALUOp2, ALUOp1, ALUOp0,jump, flushSignal;

always @(*)
 begin 
	if (flushSignal)
	  begin
	  RegDstID=1'b0;
	  ALUSrcID=1'b0;
	  MemtoRegID=1'b0;
	  RegWriteID=1'b0;
	  MemReadID=1'b0;
	  MemWriteID=1'b0;
	  BranchID=1'b0;
	  BranchNID=1'b0;
	  ALUOp2ID=1'b0;
	  ALUOp1ID=1'b0;
	  ALUOp0ID=1'b0;
	  jumpID=1'b0;
	  end
	else begin
	  RegDstID=RegDst;
	  ALUSrcID=ALUSrc;
	  MemtoRegID=MemtoReg;
	  RegWriteID=RegWrite;
	  MemReadID=MemRead;
	  MemWriteID=MemWrite;
	  BranchID=Branch;
	  BranchNID=BranchN;
	  ALUOp2ID=ALUOp2;
	  ALUOp1ID=ALUOp1;
	  ALUOp0ID=ALUOp0;
	  jumpID=jump;
	end
	
 end

endmodule