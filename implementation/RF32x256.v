module D_Cache ( clk , rst_n , A , D , WEN	, Q );
  
	input clk , rst_n;
	input [4:0] A;
	input WEN;
	input  [255:0] D;
	output [255:0] Q;
	reg    [255:0] Q;
	
	reg [255:0] mem [0:31];
	
	
	integer i;

	
always @( posedge clk or negedge rst_n) begin
	 
	if ( rst_n==1'b0 ) begin
    for ( i=0 ; i!=32 ; i=i+1) begin
      mem[i] <= 0;
    end
		Q <= 0;
  end
  else if ( WEN==1'b0 ) begin
		mem[A] <= D;
		Q      <= D;
	end		
	else begin
		Q <= mem[A]; 
	end
end
	
endmodule
