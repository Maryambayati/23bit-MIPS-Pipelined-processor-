module extend (signZero, Imm, ImmOut);
input signZero;
input [15:0]Imm;
output reg [31:0]ImmOut;



always@(signZero or Imm) begin
		if(signZero == 1'b0)
			ImmOut[31:0] <= { 16'b0 , Imm[15:0] };
		else ImmOut[31:0] <= { {16{Imm[15]}}, Imm[15:0] };
	end


endmodule