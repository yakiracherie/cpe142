module ALUOp();
module alu(A, B, Crtl, R, O, N, Z);
	input [15:0] A, B;
	input [3:0] Crtl;
	output [15:0] R;
	output O, N, Z;

	reg [15:0] R;
	reg sa, sb, scum;
	reg [15:0] b2;
	reg O, N, Z;
	reg zero;

	always @ (*)
	begin
	  case(Crtl)
	    4’b1111: begin	// add
	      R = A + B;
	      sa = A[15];
	      sb = B[15];
	      ssum = R[15];
	      
	      O = (sa != sb ? 0 : sb == ssum ? 0 : 1);
	      Z = (R == 0 ? 1 : 0);
	      N = (R[15] == 1 ? 1 : 0);
	      end		
	      
	        4’b1110: begin	// sub
	          b2 = ~B + 1;
	          R = A + b2;
	          sa = A[15];
	          sb = b2[15];
	          ssum = R[15];
	          
	          O = (sa != sb ? 0 : sb == ssum ? 0 : 1);
	          Z = (R == 0 ? 1 : 0);
	         end
	         
	       4’b1101:		// and
	          R <= A & B;
	        
	       4’b1101:		// or
	          R <= A | B;
	      
	       4’b0001:		// mul
	          R <= A * B;
	          
	       4’b0010:		// div
	          R <= A / B;
	          
	       4’b1010:		// sll
	          R <= A << B;
	     
	       4’b1011:		// slr
	          R <= A >> B;
	          
	       4’b1000:		// rol
	      
	      
	       4’b1001:		// ror		
	       
	   endcase
  end
endmodule
