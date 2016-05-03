module MUX16bit(in0, in1, select, out);

input [15:0] in0, in1;
input select;

output reg [15:0] out;

always @(*) 
begin
	case (select)
		1'b0: out = in0; 
		1'b1: out = in1;
	endcase
end
endmodule
