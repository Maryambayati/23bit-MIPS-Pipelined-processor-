module mux5(out, A, B, select);
	output reg [4:0] out;
	input [4:0] A,B;
	input select;
	
	always@(select or A or B) begin
		if(select == 1'b0)
			out = A;
		else out = B;
		end

endmodule