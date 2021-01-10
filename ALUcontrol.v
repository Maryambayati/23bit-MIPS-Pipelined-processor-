module ALUcontrol(ALUOp, func, ALUControl);

output reg [3:0] ALUControl;
input [2:0] ALUOp;
input [5:0] func;
wire [8:0] ALUControlIn;
assign ALUControlIn = {ALUOp,func};
always @(ALUControlIn)
casex (ALUControlIn)
9'b101xxxxxx: ALUControl=4'b0001;  //I-Type ORI 
9'b000xxxxxx: ALUControl=4'b0010; //I-Type ADDI & LW & SW
9'b100xxxxxx: ALUControl=4'b0000;  //I-Type ANDI
9'b001xxxxxx: ALUControl=4'b0110; //I-Type BEQ

//jr
9'b010100000: ALUControl=4'b0010; //R-type ADD
9'b010010100: ALUControl=4'b0000; //R-type AND
9'b010100001: ALUControl=4'b0010; //R-type LWN
9'b010100111: ALUControl=4'b1100; //R-type NOR
9'b010100101: ALUControl=4'b0001; //R-type OR
9'b010101010: ALUControl=4'b0111; //R-type slt
9'b010101011: ALUControl=4'b1000; //R-type sltu
9'b010000000: ALUControl=4'b1001; //R-type sll
9'b010000010: ALUControl=4'b1010; //R-type srl
9'b010010011: ALUControl=4'b0010; //R-type SWN
9'b010100100: ALUControl=4'b0110; //R-type SUB
default: ALUControl=4'b0000;
endcase


endmodule
