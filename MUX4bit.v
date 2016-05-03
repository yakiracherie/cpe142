module MUX4bit(in0, in1, select, out);

input [4:0] in0, in1;
input select;

output reg [4:0] out;

always @(*) 
begin
	case (select)
		1'b0: out = in0; 
		1'b1: out = in1;
	endcase
end
endmodule
