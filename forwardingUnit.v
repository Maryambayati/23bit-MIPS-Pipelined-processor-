//this unit gives select signals to control the alu source
//this unit solves data hazards by forwarding 


/*
Data hazards when
1a. EX/MEM.RegisterRd = ID/EX.RegisterRs
1b. EX/MEM.RegisterRd = ID/EX.RegisterRt
2a. MEM/WB.RegisterRd = ID/EX.RegisterRs
2b. MEM/WB.RegisterRd = ID/EX.RegisterRt
*/

module forwardingUnit(ForwardA, ForwardB,MEMRegWrite, WBRegWrite,MEMRegisterRd,WBRegisterRd,EXrs,EXrt);
output reg [1:0] ForwardA, ForwardB; //to control the ALU source mux A & B
input MEMRegWrite, WBRegWrite; //control signals
input [4:0] MEMRegisterRd,WBRegisterRd,EXrs,EXrt; 

reg Aexp1,Aexp2,Bexp1,Bexp2;

always@(*) begin

ForwardA=2'b00;
ForwardB=2'b00;

//farward A
 Aexp1= (MEMRegWrite==1)&&(MEMRegisterRd != 0)&&(MEMRegisterRd==EXrs);//EX hazard
 Aexp2= (WBRegWrite==1)&&(WBRegisterRd != 0)&&(WBRegisterRd==EXrs);//MEM hazard

if (Aexp1)
	ForwardA=2'b10;
if  (Aexp2)
 ForwardA=2'b01;
 

//farward B
 Bexp1= (MEMRegWrite==1)&&(MEMRegisterRd != 0)&&(MEMRegisterRd==EXrt);//EX hazard
 Bexp2= (WBRegWrite==1)&&(WBRegisterRd != 0)&&(WBRegisterRd==EXrt);//MEM hazard

if (Bexp1)
	ForwardB=2'b10;
if  (Bexp2)
	ForwardB=2'b01;
	
end

endmodule