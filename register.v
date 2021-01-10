module register (clk, regIn, regOut , en);
  input clk, en;
  input [31:0] regIn;
  output reg [31:0] regOut;
  always @ (posedge clk)  begin
  if(en)
    begin
    regOut <= regIn;
    end
  end
endmodule // register