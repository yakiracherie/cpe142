`include "MUX4bit.v"

module stimulus;

reg [4:0] in0, in1;
reg select
wire [4:0] out;

initial
	$vcdpluson;
initial
$monitor($time,"in0 = %b in1 = %b select = %b out = %b", in0, in1, select, out);

MUX16bit mux16bit(.in0(in0), .in1(in1), .select(select), .out(out));
initial
begin
	in0 = 16'b0000;
	in1 = 16'b0000;
	select = 1'b0;
end

initial
begin
	in0 = 16'b0000;
	in1 = 16'b1111;
	select = 1'b0;

	#10
	in0 = 16'b0000;
	in1 = 16'b0000;
	select = 1'b1;

end

initial
begin
#30 $finish;
end


endmodule
