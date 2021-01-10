module mux32x3(out, A, B, C, select);
	output reg [31:0] out;
	input [31:0] A,B,C;
	input [1:0] select;
	
	always@(select or A or B or C) begin
		if(select == 2'b00)
			out = A;
		else if (select == 2'b01)
			out = B;
		else if(select == 2'b10)
			out = C;
		end

endmodule