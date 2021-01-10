module PCRegtoWire(clk, firstPC, regIn, regOut , enFirst, PCWriteEnable);
  input clk, enFirst, PCWriteEnable;
  input [31:0] firstPC, regIn;
  output reg [31:0] regOut;

  always @ (negedge clk)  begin
if (PCWriteEnable)
  if(enFirst)
    begin
    regOut <= regIn;
    end
   else begin
    regOut <= firstPC;
    end
  end

endmodule

