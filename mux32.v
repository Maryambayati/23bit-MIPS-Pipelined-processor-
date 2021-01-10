module mux32(out, A, B, select);
	output reg [31:0] out;
	input [31:0] A,B;
	input select;
	
	always@(select or A or B) begin
		if(select == 1'b0)
			out = A;
		else out = B;
		end

endmodule