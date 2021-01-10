/*
Load-use hazard when
ID/EX.MemRead and((ID/EX.RegisterRt = IF/ID.RegisterRs) or (ID/EX.RegisterRt = IF/ID.RegisterRt))
If detected, stall and insert bubble
*/

module HazardDetection(PCWriteEn,IFID_WriteEn,Stall_flush,EX_MemRead,EX_rt,ID_rs,ID_rt);
output reg PCWriteEn,IFID_WriteEn,Stall_flush;
input [4:0] EX_rt,ID_rs,ID_rt;
input EX_MemRead;
initial begin
	PCWriteEn=1'b1;
	IFID_WriteEn=1'b1;
	Stall_flush =1'b0;
end

always @(EX_MemRead or EX_rt or ID_rs or ID_rt)
	begin
		if ((EX_MemRead==1)&&((EX_rt==ID_rs)||(EX_rt==ID_rt)))
			begin
				PCWriteEn=1'b0;
				IFID_WriteEn=1'b0;
				Stall_flush =1'b1;
			end
		else
			begin
				PCWriteEn=1'b1;
				IFID_WriteEn=1'b1;
				Stall_flush =1'b0;
			end
	end

endmodule