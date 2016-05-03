`include "SignExtend8.v"

module stimulus;

wire [7:0] in;
reg [15:0] out;

initial
	$vcdpluson;
initial
$monitor($time,"in = %b out = %b", in, out);

SignExtend8 signExtend8(.in(in),.out(out));
initial
begin
	in = 8'b0000_0000;
end

initial
begin
	in = 8'b0000_0001;

	#10
	in = 8'b1111_1111;

	#10
  in = 8'b1010_1010;

end

initial
begin
#30 $finish;
end


endmodule
