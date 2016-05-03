`include "ShiftLeft1.v"

module stimulus;

wire [15:0] in;
reg [15:0] out;

initial
	$vcdpluson;
initial
$monitor($time,"in = %b out = %b", in, out);

SignExtend4 signExtend4(.in(in),.out(out));
initial
begin
	in = 16'b0000_0000_0000_0000;
end

initial
begin
	in = 16'b0000_0000_0000_0001;

	#10
	in = 4'b0000_1111_1111_1111;

	#10
  in = 4'b1010_1010_1010_1010;

end

initial
begin
#30 $finish;
end


endmodule
