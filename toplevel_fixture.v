`include "toplevel.v"

module stimulus;

reg clk, rst;

initial
	$vcdpluson;
initial
$monitor($time,"");
toplevel toplevel(clk, rst);
initial
begin
  clk = 0;
  rst = 0;
end
initial
begin
	clk = 0;
	rst = 0;
	
	forever #10 clk = ~clk;
end

initial
begin
#500 $finish;
end
endmodule
