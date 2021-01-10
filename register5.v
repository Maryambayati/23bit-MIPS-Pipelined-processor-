module register5 (clk, regIn, regOut , en);
  input clk, en;
  input [4:0] regIn;
  output reg [4:0] regOut;
  always @ (posedge clk)  begin
  if(en)
    begin
    regOut <= regIn;
    end
  end
endmodule // register