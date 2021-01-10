module register1 (clk, regIn, regOut , en);
  input clk, en;
  input regIn;
  output reg regOut;
  always @ (posedge clk)  begin
  if(en)
    begin
    regOut <= regIn;
    end
  end
endmodule // register