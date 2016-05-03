module HazardDetectionUnit(IFIDRegRs, IFIDRegRt, IDEXRegRt, IDEXMemRead, PCWrite, IFIDWrite, mux); 
  input [3:0] IFIDRegRs, IFIDRegRt, IDEXRegRt; 
  input IDEXMemRead; 
  output PCWrite, IFIDWrite, mux; 
  
  reg PCWrite, IFIDWrite, mux; 
  
  always@(IFIDRegRs, IFIDRegRt, IDEXRegRt, IDEXMemRead) 
    if(IDEXMemRead & ((IDEXRegRt == IFIDRegRs) | (IDEXRegRt == IFIDRegRt))) 
    begin              // stalling 
      PCWrite = 0; 
      IFIDWrite = 0;
      mux = 1; 
    end 
    
    else begin          //no stalling 
      PCWrite = 1; 
      IFIDWrite = 1; 
      mux = 1; 
    end 
 
endmodule 
