//revision date: 2013/6/1

module udiv
#(parameter aw = 18,
  parameter bw = 10)(
  input      [aw   -1:0] a,
  input      [bw   -1:0] b,
  output     [aw-1:0] quo,
  output     [bw-1:0] res,
  output              divide_by_0
  );
  assign divide_by_0 = b == 0 ? 1'b1:1'b0;

  integer i;
  reg frac;
  reg   [aw-1:0] quo_temp;
  reg   [bw:0] am [0:aw-1];
  reg   [bw:0] at [0:aw-1];
  reg   [bw:0] a_end;
  
  wire signed [bw:0] sb;
 
  assign sb = {1'b0,b};

always  
begin
  quo_temp[aw-1] = 0;
  at[aw-2] = {{(bw-1){1'b0}},a[aw-1:aw-2]};
  for(i=aw-3;i>=0;i=i-1)
    begin
      am[i+1] = at[i+1] - sb;
      quo_temp[i+1] = ~am[i+1][bw];
      
      if(quo_temp[i+1])
        at[i] = {am[i+1][bw-1:0],a[i]};
      else
        at[i] = {at[i+1][bw-1:0],a[i]};
    end
//lsb  
  am[0] = at[0] - sb;
  quo_temp[0] = ~am[0][bw];

  if (quo_temp[0])
    a_end = am[0];
  else
    a_end = at[0];
end

assign quo = b == 0? {aw{1'b1}}: 
             b == 1? a:quo_temp;
assign res = b == 0? 0:
            (b == 1? 0:a_end[bw-1:0]);
endmodule
