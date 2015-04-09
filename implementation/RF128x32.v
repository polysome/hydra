module I_Cache ( clk , rst_n , A , D , WEN	, Q );
  
	input clk , rst_n;
	input [6:0] A;
	input WEN;
	input  [31:0] D;
	output [31:0] Q;
	reg    [31:0] Q;
	
	reg [31:0] mem [0:127];
	
	
	integer i;
	
always @( posedge clk or negedge rst_n ) begin
	if ( rst_n==1'b0 ) begin
    for ( i=0 ; i<128 ; i=i+1) begin
      mem[i] <= 0;
    end
		Q<=0;
  end
  else if ( WEN==1'b0 ) begin
		mem[A] <= D;
		Q      <= D;
	end		
	else
  	Q <= mem[A];  
	
end
	
endmodule
