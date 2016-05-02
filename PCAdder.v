module PCAdder(PCin, i, PCout);

input wire [15:0] PCin, i;

output wire [15:0] PCout;

assign PCout = PCin + i;

endmodule
