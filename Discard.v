module Discard(jmp, branch,BranchN, flushIF, flushID);
output reg  flushIF, flushID;
input jmp, branch,BranchN;

always@(*)
begin	
 	flushID=1'b0;
	flushIF=1'b0;
	if ( branch||BranchN) begin
		flushIF=1'b1;
	end
	if (jmp) begin
		flushID=1'b1;
	end

end


endmodule