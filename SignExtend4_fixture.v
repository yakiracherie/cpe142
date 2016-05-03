`include "SignExtend4.v"

module stimulus;

wire [3:0] in;
reg [15:0] out;

initial
	$vcdpluson;
initial
$monitor($time,"in = %b out = %b", in, out);

SignExtend4 signExtend4(.in(in),.out(out));
initial
begin
	in = 4'b0000;
end

initial
begin
	in = 4'b0001;

	#10
	in = 4'b1111;

	#10
  in = 4'b1010;

end

initial
begin
#30 $finish;
end


endmodule
