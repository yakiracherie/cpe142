`timescale 1ns / 1ns

module PC(clk, rst, PCin, PCout);

input clk, rst;
input [15:0] PCin;

output reg [15:0] PCout;

always @(posedge clk or negedge reset) 
begin
	if (!reset) begin
		PCout <= PCout;
	end
	else begin
		PCout <= PCin;
	end
end
endmodule
