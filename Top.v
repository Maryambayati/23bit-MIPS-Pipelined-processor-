/*
stage1 : instruction fetch (IF)
stage2 : instruction decode and register fetch (ID)
stage3 : execuction stage (EXEC)
stage4 : memory stage (MEM)
stage5 : writeback stage (WB)
*/

module Top(PC_VALUE);// testbench holds the PC Value.

input [31:0] PC_VALUE; //it is a wire 
reg [31:0] PC_VALUEreg;
wire [31:0] program_counter;
wire PCsrc;

reg Enfirst;


//clock
clock clkk(clk);

initial begin
	Enfirst = 1'b0;
	#1 PC_VALUEreg = PC_VALUE;
	#150 Enfirst = 1'b1;
	
end



//wires in IF stage
wire PC_WriteEn,IFID_WriteEn,IDEX_WriteEn,EXMEM_WriteEn,MEMWB_WriteEn;


wire [31:0] pcWire, pc4Wire, pc4ifWire;
wire [31:0] pcIns, instifWire;


//wires in ID stage
wire [31:0] pc4idWire;
wire [31:0] instidWire,immExtWire,readData1Wire,readData2Wire,wbRegWire, wbDataWire;
wire [15:0] immWire;
wire [5:0] opControlWire; //6bits opcode wire going to control  
wire [4:0] rsWire, rdWire; 
wire [25:0] jmpAdd;
wire [27:0] jmpAdd2;
wire [31:0] jumpAddressFull;
wire [3:0] pcJmpwire;
//control signals
wire RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,
MemWrite,Branch, ALUOp2, ALUOp1, ALUOp0,SignZero,jump;
wire signZeroWire, jumpWire;
wire ID_flush,IFID_flush,IF_flush;

//wires in EX stage 
wire [31:0] pc4exWire,instexWire,outBranchMux;
wire [31:0] readData1exWire, immExtexWire, readData2exWire, writeDataexWire, immShiftWire  ;
wire [31:0] ALUOut_EXEC, aluSrcResultWire, adderResultWire,outMuxB,outMuxA;
wire [5:0] funcWire;
wire [4:0] rtRtypeWire, rtItypeWire, regdstResultWire,EXrsWire,EXrtWire,shamt;
wire [3:0] aluControlWire;
wire [2:0] aluOpWire;
wire regDstWire, aluSrcWire, zeroWire,branchSel,jumpSel;
wire [1:0] ForwardSignalA,ForwardSignalB;
//2 main control signals
wire [1:0] wbControlexWire; // WB
wire [2:0] mControlexWire; // M


//wires in MEM stage
wire [31:0] writeDataMemWire, addressMemWire, addressRegDstWire, readDataMemWire,instmemWire,adderResultMemWire;
wire [4:0] regDstResultMemWire;
wire MemWriteWire, MemReadWire, zeroMemWire, branchControlWire;
//main control signals
wire [1:0] wbControlMemWire; // WB


//wires in WB stage 
wire [31:0] readDataMemWbWire, addressRegDstWbWire,wbdataWire;
wire [4:0] wbregWire;
wire memtoRegwire;


//control signals
wire RegWriteWB; //from WB stage to ID




//=======IF stage========
PCRegtoWire  PC_reg(clk, PC_VALUEreg, pcWire, program_counter, Enfirst, PC_WriteEn); //PC_WriteEn for hazard detection control
adder adder1(program_counter, 32'b100, pc4ifWire ); //pc=pc+4
instructionMemory insMem(instifWire, program_counter);

//========================IFID
register IFID_PC(clk, pc4ifWire, pc4idWire, IFID_WriteEn); // IFID_WriteEn for hazard detection control
register IFID_Inst(clk, instifWire, instidWire, IFID_WriteEn);
register1 IFID_FlushSignal(clk,IF_flush,IFID_flush,IFID_WriteEn);


//=======ID stage========
assign pcJmpwire = pc4idWire[31:28];
assign opControlWire = instidWire[31:26];
assign rsWire = instidWire[25:21];
assign rtRtypeWire = instidWire[20:16];
assign immWire = instidWire[15:0];
assign jmpAdd = instidWire[25:0];

Control MainControl (RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,
MemWrite,Branch,BranchN, ALUOp2, ALUOp1, ALUOp0,SignZero,jump, opControlWire);//////

//if flush needed -> Force control values in ID/EX register to 0
flushControl flushCon(RegDst,ALUSrc,MemtoReg,RegWrite,MemRead,MemWrite,
Branch,BranchN, ALUOp2, ALUOp1, ALUOp0,jump, flushSignal,RegDstID,ALUSrcID,
MemtoRegID,RegWriteID,MemReadID,MemWriteID,BranchID,BranchnID, ALUOp2ID, ALUOp1ID, ALUOp0ID,jumpID);

registerFile regFile (clk, RegWriteWB , rsWire, rtRtypeWire, wbregWire, 
wbdataWire, readData1Wire, readData2Wire);

extend extendID (SignZero, immWire, immExtWire);

//jump datapath
shiftLeftjmp jumpshift(jmpAdd2, jmpAdd);
assign jumpAddressFull={pcJmpwire,jmpAdd2};

//*********************Hazard Detection MEM-ALU*************************
HazardDetection hazardsDet(PC_WriteEn,IFID_WriteEn,Stall_flush,MemReadEX,EXrtWire,rsWire,rtRtypeWire);
Discard discardSignals(jump, Branch,BranchN, IF_flush, ID_flush);
assign flushSignal = (ID_flush || IFID_flush || Stall_flush) ; //Or gate for flush

//========================IDEX
register IDEX_ReadData1(clk, readData1Wire, readData1exWire, 1);
register IDEX_ReadData2(clk, readData2Wire, readData2exWire, 1);
register IDEX_Imm(clk, immExtWire, immExtexWire, 1);
register IDEX_Inst(clk, instidWire, instexWire, 1);
register IDEX_PC(clk, pc4idWire, pc4exWire, 1);
//controlbits
register1 IDEX_RegDst(clk,RegDstID,RegDstEX,1);
register1 IDEX_ALUSrc(clk,ALUSrcID,ALUSrcEX,1);
register1 IDEX_MemtoReg(clk,MemtoRegID,MemtoRegEX,1);
register1 IDEX_MemRead(clk,MemReadID,MemReadEX,1);
register1 IDEX_MemWrite(clk,MemWriteID,MemWriteEX,1);
register1 IDEX_Branch(clk,BranchID,BranchEX,1);
register1 IDEX_BranchN(clk,BranchnID,BranchNEX,1);
register1 IDEX_ALUOp2(clk,ALUOp2ID,ALUOp2EX,1);
register1 IDEX_ALUOp1(clk,ALUOp1ID,ALUOp1EX,1);
register1 IDEX_ALUOp0(clk,ALUOp0ID,ALUOp0EX,1);
register1 IDEX_RegWrite(clk,RegWriteID,RegWriteEX,1);

//=======EX stage========
assign aluOpWire={ALUOp2EX,ALUOp1EX,ALUOp0EX};
assign EXrsWire = instexWire[25:21]; //forwarding
assign EXrtWire = instexWire [20:16]; //forwarding
assign rtItypeWire = instexWire [20:16];
assign rdWire = instexWire[15:11];
assign writeDataexWire=readData2exWire;
assign funcWire=instexWire[5:0];
assign shamt = instexWire[10:6];

ALUcontrol aluControl(aluOpWire, funcWire, aluControlWire);//tl3 func mn wire
mux32x3 muxA(outMuxA, readData1exWire, wbdataWire, addressMemWire, ForwardSignalA);
mux32x3 muxB(outMuxB, readData2exWire, wbdataWire, addressMemWire, ForwardSignalB);
mux32 muxAluSrc(aluSrcResultWire, outMuxB, immExtexWire,ALUSrcEX );////????
alu ALU(aluControlWire, outMuxA, aluSrcResultWire, shamt, ALUOut_EXEC, zeroWire);
shiftLeft shiftL(immShiftWire, immExtexWire);
adder adder2(pc4exWire, immShiftWire, adderResultWire);
mux5 muxRegDst(regdstResultWire, rtItypeWire, rdWire, RegDstEX);

//*********************FORWARD***************************
forwardingUnit forward(ForwardSignalA, ForwardSignalB, MemtoRegEX, RegWriteWB, regDstResultMemWire, wbregWire,EXrsWire,EXrtWire);

////jump and branch mux======PC Src
assign branchSel = ((BranchEX && zeroWire)||(BranchNEX && ~zeroWire)); // And gate for branch detection
mux32 BranchMux(outBranchMux, pc4ifWire, adderResultWire, branchSel);
mux32 JumpMux(pcWire, outBranchMux, jumpAddressFull, jump);


//========================EXMEM
register EXMEM_adder2Result(clk, adderResultWire, adderResultMemWire , 1);
register EXMEM_aluResult(clk, ALUOut_EXEC, addressMemWire, 1);
register EXMEM_writeData2(clk,writeDataexWire, writeDataMemWire, 1);
register EXMEM_Inst(clk, instexWire, instmemWire, 1);
register5 EXMEM_RegDstResult(clk, regdstResultWire, regDstResultMemWire, 1);

//controlbits
register1 EXMEM_MemRead(clk,MemReadEX,MemReadMEM,1);
register1 EXMEM_MemWrite(clk,MemWriteEX,MemWriteMEM,1);
register1 EXMEM_MemtoReg(clk,MemtoRegEX,MemtoRegMEM,1);
register1 EXMEM_RegWrite(clk,RegWriteEX,RegWriteMEM,1);

//=======MEM stage========
memory dataMemory(MemReadMEM,MemWriteMEM, addressMemWire, writeDataMemWire, readDataMemWire);

//========================MEMWB
register MEMWB_aluresult(clk,addressMemWire,addressRegDstWbWire,1);
register MEMWB_dataResult(clk, readDataMemWire, readDataMemWbWire,1);
register5 MEMWB_RegDstResult(clk, regDstResultMemWire, wbregWire, 1);

//controlbits
register1 MEMWB_MemtoReg(clk,MemtoRegMEM,MemtoRegWB,1);
register1 MEMWB_RegWrite(clk,RegWriteMEM,RegWriteWB,1);
//write on register filee!!!!!!!

//=======WB stage========
mux32 muxMemToReg (wbdataWire, readDataMemWbWire, addressRegDstWbWire, MemtoRegWB);


endmodule 


	