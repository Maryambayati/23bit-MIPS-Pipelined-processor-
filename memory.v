module memory (memRead, memWrite, address, writeMData, readMData);

input [31:0] address;
input [31:0] writeMData;
input memRead;
input memWrite;
reg [31:0] data;

output reg [31:0] readMData;

//you should use this initialization to build your data memory, this part is not complete


	
	///  Intitialization for the memory 
	
	reg [7:0] mem [1023:0]; // building a 1k memory //
	integer i;
	
	initial
		begin
			for(i = 0; i <1024; i = i + 1)
				begin
					mem[i] <=  0;
					if((i+1)%4 == 0)
	  				mem[i] <= i+1;
	// mem[3] 	= 4
	// mem[7] 	= 8
	// mem[11] 	= 12
	// mem[15] 	= 16
	// mem[19] 	= 20
	// mem[23] 	= 24
	// mem[27] 	= 28
	// mem[31] 	= 32	
				end
			
		end
	

	always @ (*) begin
   	 if (memWrite==1) begin
		mem[address]   <= writeMData[31:24];
		mem[address+1] <= writeMData[23:16];
		mem[address+2] <= writeMData[15:8];
		mem[address+3] <= writeMData[7:0];
		end
	 else if(memRead==1)
	data <= {mem[address],mem[address+1],mem[address+2],mem[address+3]};
		readMData <= data;
  end 
	
endmodule

