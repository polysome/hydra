module Hydra (  ready , data_out ,
								clk , rst_n ,
                inst_cur , inst_nxt ,
                data_in_1 , data_in_2 , 
                hy_exe
							);
								
//====parameter Declaration====//
parameter inst_num = 31;

parameter nop    	= 5'h0;
parameter setrn 	= 5'h1;
parameter mul    	= 5'h2;
parameter add    	= 5'h3;
parameter sub    	= 5'h4;
parameter mod   	= 5'h5;
parameter pol_add = 5'h6;
parameter mov     = 5'h7;
parameter shuffle = 5'h8;
parameter stall   = 3'h7;


parameter mode_i = 1'b0;
parameter mode_q = 1'b1;

parameter state_idle   = 4'h0  ;							 
parameter state_load_N = 4'h1  ;							 
parameter state_p_m_0  = 4'h2  ;							 
parameter state_p_m_1  = 4'h3  ;							 
parameter state_p_m_2  = 4'h4  ;							 
parameter state_p_m_3  = 4'h5  ;		
parameter state_p_a_1  = 4'h6  ;		
parameter state_p_s_N  = 4'h7  ;
parameter state_p_s_1  = 4'h8  ;		
parameter state_p_a_N  = 4'h9  ;	
parameter state_write  = 4'hf ;	
integer i;
//====I/O Declaration====//
output ready ;
reg    ready ;
output [255:0] data_out;
reg    [255:0] data_out;
input          clk , hy_exe , rst_n;
input [255:0]  data_in_1 , data_in_2;	
input [inst_num-1:0]  inst_cur , inst_nxt;			
//====Register Declaration====//
reg [15:0] A      [15:0];
reg [15:0] A_next [15:0];
reg [15:0] X      [15:0];
reg [15:0] X_next [15:0];
reg [15:0] N      [15:0];
reg [15:0] N_next [15:0];
reg [18:0] Y      [16:0];
reg [18:0] Y_next [16:0];			
reg [15:0] temp , temp_next , np , np_next;
reg [3: 0] curstate , nextstate;
reg [4: 0] counter , counter_next;
//====Wire Declaration====//
reg [15:0] mul_in1 [15:0];
reg [15:0] mul_in2 [15:0];
reg [31:0] mul_o [15:0];

reg [17:0] add1_in1 [15:0];
reg [17:0] add1_in2 [15:0];
reg [18:0] add1_o [15:0];

reg [17:0] add2_in1 [15:0];
reg [17:0] add2_in2 [15:0];
reg [18:0] add2_o [15:0];
//====Connection Wire====//
reg [15:0] buf_44   [43:0];
reg [15:0] vec_inA  [15:0];
reg [15:0] vec_inX  [15:0];
reg [15:0] vec_out  [15:0];
//====Define Wire====//
wire [4:0] comp_type_nxt = inst_nxt[30:26];
wire [4:0] comp_type = inst_cur[30:26];
wire [1:0] shift     = inst_cur[17:16];
wire mode 	= inst_cur[9];
wire rstY 	= inst_cur[8];
wire accuY 	= inst_cur[7];
wire WB   	= inst_cur[6];
wire expand = inst_cur[18];

wire load_A = inst_nxt[24];
wire load_X = inst_nxt[15];

wire [31:0] pol_det = { N[1] , N[0] };




//====Vector Connection====//
always @ (*) begin
	data_out = {  vec_out[15], vec_out[14], vec_out[13], vec_out[12], vec_out[11], vec_out[10], vec_out[9], vec_out[8],
                vec_out[ 7], vec_out[ 6], vec_out[ 5], vec_out[ 4], vec_out[ 3], vec_out[ 2], vec_out[1], vec_out[0] };
	{ vec_inA[15], vec_inA[14], vec_inA[13], vec_inA[12], vec_inA[11], vec_inA[10], vec_inA[9], vec_inA[8],
	  vec_inA[ 7], vec_inA[ 6], vec_inA[ 5], vec_inA[ 4], vec_inA[ 3], vec_inA[ 2], vec_inA[1], vec_inA[0] } = data_in_1;
	{ vec_inX[15], vec_inX[14], vec_inX[13], vec_inX[12], vec_inX[11], vec_inX[10], vec_inX[9], vec_inX[8],
	  vec_inX[ 7], vec_inX[ 6], vec_inX[ 5], vec_inX[ 4], vec_inX[ 3], vec_inX[ 2], vec_inX[1], vec_inX[0] } = data_in_2;

	buf_44[ 0] = N[ 0];buf_44[ 1] = N[ 1];buf_44[ 2] = N[ 2];buf_44[ 3] = N[ 3];buf_44[ 4] = N[ 4];buf_44[ 5] = N[ 5];
	buf_44[ 6] = N[ 6];buf_44[ 7] = N[ 7];buf_44[ 8] = N[ 8];buf_44[ 9] = N[ 9];buf_44[10] = N[10];buf_44[11] = N[11];
	buf_44[12] = N[12];buf_44[13] = N[13];buf_44[14] = N[14];buf_44[15] = N[15];buf_44[16] = X[ 0];buf_44[17] = X[ 1];
	buf_44[18] = X[ 2];buf_44[19] = X[ 3];buf_44[20] = X[ 4];buf_44[21] = X[ 5];buf_44[22] = X[ 6];buf_44[23] = X[ 7];
	buf_44[24] = X[ 8];buf_44[25] = X[ 9];buf_44[26] = X[10];buf_44[27] = X[11];buf_44[28] = X[12];buf_44[29] = X[13];
	buf_44[30] = X[14];buf_44[31] = X[15];buf_44[32] = Y[ 0];buf_44[33] = Y[ 1];buf_44[34] = Y[ 2];buf_44[35] = Y[ 3];
	buf_44[36] = Y[ 4];buf_44[37] = Y[ 5];buf_44[38] = Y[ 6];buf_44[39] = Y[ 7];buf_44[40] = Y[ 8];buf_44[41] = Y[ 9];
	buf_44[42] = Y[10];buf_44[43] = Y[11];	
end
//===============================Sequential Logic===============================//
always @ ( posedge clk or negedge rst_n ) begin
	if ( rst_n == 1'b0 ) begin
		curstate <= 4'd0;
		counter <= 5'd0;
		temp <=16'd0;
		np <=16'd0;
		for ( i=0 ; i!=16 ; i=i+1 ) begin
			A[i] <= 16'd0;
			X[i] <= 16'd0;
			N[i] <= 16'd0;
			Y[i] <= 19'd0;
		end
		Y[16]  <= 19'd0;
	end
	else begin
		curstate <= nextstate;
		counter <= counter_next;
		temp <= temp_next;
		np <= np_next;
		for ( i=0 ; i!=16 ; i=i+1 ) begin
			A[i] <= A_next[i];
			X[i] <= X_next[i];
			N[i] <= N_next[i];
			Y[i] <= Y_next[i];
		end
		Y[16]  <= Y_next[16];
	end
end
//===============================NextState Logic===============================//
always @ (*) 
begin
	case (curstate)
		state_idle : 
			case (comp_type)
				mul : 
					nextstate = state_p_m_0;
				add :
					nextstate = state_p_a_1;
				sub :
					nextstate = state_p_s_1;
				default :
					nextstate = state_idle;
			endcase
		state_p_m_0 : 
			nextstate = state_p_m_1;
		state_p_m_1 : 
			nextstate = state_p_m_2;
		state_p_m_2 : 
			nextstate = state_p_m_3;	
		state_p_m_3 : 
			if ( counter==5'd17 )
				nextstate = state_write; 
			else
				nextstate = state_p_m_1;
		state_p_a_1 : 
			if ( add2_o[15]<N[15] && add2_o[15][16]==1'b0 )
				nextstate = state_write;
			else
				nextstate = state_p_s_N;
		state_p_s_N : 
			nextstate = state_write;
		state_p_s_1	:
			if (add2_o[15][16]==1'b0 )
				nextstate = state_write;
			else
				nextstate = state_p_a_N;
		state_p_a_N : 
			nextstate = state_write;
		state_write : 
			nextstate = state_idle;
		default : 
			nextstate = state_idle;
	endcase	
end
//===============================Output Logic===============================//
always @ ( * ) begin
	temp_next = temp;
//-------------------------------------------  
//--********Write back strategy************--
//-------------------------------------------  
  for ( i=0 ; i!=16 ; i=i+1 ) begin                  //vec_out
    if (WB)
      vec_out[i] = add2_o[i];
    else 
      vec_out[i] = 16'd0;
  end
//----------------------------------------
//--********Loading strategy************--
//----------------------------------------
  if (ready==1'b1) begin                             //A & X
    if (load_A==1'b1) begin
      if (expand==1'b1) begin
        for ( i=0 ; i!=16 ; i=i+1 )
          A_next[i] = vec_inA[0];
      end  // end expand
      else if (shift==2'd1) begin
        for ( i=0 ; i!=15 ; i=i+1 )
          A_next[i] = vec_inA[i+1];
        A_next[15] = 16'd0;
      end  // end shift 1
      else if (shift==2'd2) begin
        for ( i=0 ; i!=14 ; i=i+1 )
          A_next[i] = vec_inA[i+2];
        A_next[14] = 16'd0;
        A_next[15] = 16'd0;
      end  // end shift 2
      else begin
        for ( i=0 ; i!=16 ; i=i+1 )
          A_next[i] = vec_inA[i];
      end  // end normal load
    end  // end load_A == 1
    else if (shift==2'd1) begin
      for ( i=0 ; i!=15 ; i=i+1 )
        A_next[i] = A[i+1];
      A_next[15] = 16'd0;
    end  // end shift 1
    else if (shift==2'd2) begin
      for ( i=0 ; i!=14 ; i=i+1 )
        A_next[i] = A[i+2];
      A_next[14] = 16'd0;
      A_next[15] = 16'd0;
    end  // end shift 2
    else begin
      for ( i=0 ; i!=16 ; i=i+1 )
        A_next[i] = A[i];
    end
  end
  else begin
    for ( i=0 ; i!=16 ; i=i+1 )
      A_next[i] = A[i];
  end
  for ( i=0 ; i!=16 ; i=i+1 ) begin
    if ( ready==1'b1 && load_X==1'b1 )
      X_next[i] = vec_inX[i];
    else 
      X_next[i] = X[i];
  end
//---------------------------------------------
//--********Accumulation strategy************--
//---------------------------------------------
  for ( i=0 ; i!=16 ; i=i+1 ) begin                  //Y
    if (accuY==1'b1)
      Y_next[i] = add2_o[i];
    else if (rstY==1'b1)
      Y_next[i] = 19'd0;
    else
      Y_next[i] = Y[i];
  end
	if (rstY==1'b1)
    Y_next[16] = 19'd0;
  else
    Y_next[16] = Y[16];
//----------------------------------------
//--********Default strategy************--
//----------------------------------------
  np_next = (comp_type==setrn) ? 16'h15c1/*A[0]*/ : np;
  // for ( i=0 ; i!=16 ; i=i+1 ) begin
    // N_next[i] = (comp_type==setrn) ? X[i] : N[i];
  // end
  ready = hy_exe;
	for ( i=0 ; i!=16 ; i=i+1 ) begin
		mul_in1[i]  = 16'd0;
		mul_in2[i]  = 16'd0;
		add1_in1[i] = 18'd0;
		add1_in2[i] = 18'd0;
		add2_in1[i] = 18'd0;
		add2_in2[i] = 18'd0;
    N_next[i] = N[i];
	end
	counter_next = 5'd0;
//--------------------------------------------
//--********Instruction strategy************--
//--------------------------------------------
  if (hy_exe==1'b0) begin
		counter_next = counter;
		for ( i=0 ; i!=16 ; i=i+1 ) begin
			N_next[i] = N[i];
			X_next[i] = X[i];
			A_next[i] = A[i];
			Y_next[i] = Y[i];
		end
		Y_next[16] = Y[16];
	end
	else if (mode==mode_q) begin
		case (comp_type) 
      nop : begin
        counter_next = 5'd0;
        for ( i=0 ; i!=16 ; i=i+1 ) begin
        	mul_in1[i]  = 16'd0;
        	mul_in2[i]  = 16'd0;
        	add1_in1[i] = A[i];
        	add1_in2[i] = mul_o[i];
        	add2_in1[i] = (accuY) ? Y[i] : 16'd0;
        	add2_in2[i] = add1_o[i];
        end
      end
			setrn : begin
				if (comp_type_nxt==pol_add)
          counter_next = 5'd0;
        else
          counter_next = 5'd0;
        //XXXXXXXXXXXXXXXXXXXXXXXXXX  TO BE CONFIRMED  XXXXXXXXXXXXXXXXXXXXXXXXXX
				for ( i=0 ; i!=16 ; i=i+1 ) begin
        	mul_in1[i]  = 16'd0;
        	mul_in2[i]  = 16'd0;
        	add1_in1[i] = A[i];
        	add1_in2[i] = mul_o[i];
        	add2_in1[i] = (accuY) ? Y[i] : 18'd0;
        	add2_in2[i] = add1_o[i];
          // X_next [i]  = vec_inX[i];
          N_next [i]  = A[i];
        end
        // ready = (counter==5'd1) ? 1'b1 : 1'b0;
        //XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
			end
			pol_add : begin
        counter_next = (counter>5'd6) ? 5'd0 : counter +5'd1;
        ready = (counter==5'd7) ? 1'b1 : 1'b0;
				//computation part
				for ( i=0 ; i!=16 ; i=i+1 ) begin
					add1_in1[i] = (N[0][i]==1'b1 && counter<5'd8 ) ? A[0] : 18'd0 ;
					
          add2_in1[i] = (accuY) ? Y[i] : 18'd0;
          add2_in2[i] = add1_o[i];
				end
        for ( i=0 ; i!=15 ; i=i+1 ) begin
          add1_in2[i] = (N[0][i+1]==1'b1  && counter<5'd8 ) ? A[1] : 18'd0 ;
        end
        add1_in2[15] = (N[1][0]==1'b1  && counter<5'd8 ) ? A[1] : 18'd0 ;
				if ( counter < 5'd8 ) begin         
          for ( i=0 ; i!=15 ; i=i+1 ) 
            N_next[i] = { N[i+1][1:0] , N[i][15:2] };
          N_next[15] = { X[0][1:0] , N[15][15:2] };
          for ( i=0 ; i!=8 ; i=i+1 ) 
            X_next[i] = { X[i+1][1:0] , X[i][15:2] };
          X_next[8] = { 3'd0 , N[0][1:0] , X[8][12:2] };
          for ( i=9 ; i!=16 ; i=i+1 ) 
            X_next[i] = X[i] ;
        end
        else begin
          for ( i=0 ; i!=16 ; i=i+1 ) begin
            N_next[i] = N[i];
            X_next[i] = X[i];
          end
        end
        if ( counter>5'd6 ) begin
					for ( i=0 ; i!=16 ; i=i+1 )
						A_next[i] = vec_inA[i];
				end
				else begin
					for ( i=0 ; i!=14 ; i=i+1 )
						A_next[i] = A[i+2];
					A_next[14] = 16'd0;
					A_next[15] = 16'd0;
				end
			end
			mul : begin
				counter_next = 5'd0;
				ready = 1'b1;
				for ( i=0 ; i!=16 ; i=i+1 ) begin
					if (expand==1'b1)
						mul_in1[i] = A[0];
					else
						mul_in1[i] = A[i];
					mul_in2[i] = X[i];
					add1_in1[i] = 16'd0;
					add1_in2[i] = mul_o[i];
					add2_in1[i] = (accuY) ? Y[i][17:0] : 18'd0;
					add2_in2[i] = add1_o[i][17:0];
				end
			end
			add : begin
				counter_next = 5'd0;
				ready = 1'b1;
				for ( i=0 ; i!=16 ; i=i+1 ) begin
					add1_in1[i] = A[i];
					add1_in2[i] = X[i];
					add2_in1[i] = (accuY) ? Y[i][17:0] : 18'd0;
					add2_in2[i] = add1_o[i];
				end
			end
			sub : begin //Should be modified
				counter_next = 5'd0;
				ready = 1'b1;
				for ( i=0 ; i!=16 ; i=i+1 ) begin
					add1_in1[i] = A[i];
					add1_in2[i] = ~X[i]+16'd1;
					add2_in1[i] = (accuY) ? Y[i][17:0] : 18'd0;
					add2_in2[i] = add1_o[i];
				end
			end
			mod : begin
				counter_next = 5'd0;
				ready = 1'b1;
        for ( i=0 ; i!=16 ; i=i+1 ) begin
					add1_in1[i] = 18'd0;
					add1_in2[i] = 18'd0;
					add2_in1[i] = Y[i] % {inst_cur[23:19] , inst_cur[14:10]};
					add2_in2[i] = add1_o[i];
				end	
        //rotation control
				for ( i=0 ; i!=15 ; i=i+1 ) 
					N_next[i] = { N[i+1][12:0] , N[i][15:13] };
				N_next[15] = { X[0][12:0] , N[15][15:13] };
				for ( i=0 ; i!=7 ; i=i+1 ) 
					X_next[i] = { X[i+1][12:0] , X[i][15:13] };
				X_next[7] = { X[8][12:0] , X[7][15:13]};
				X_next[8] = { 3'd0 , N[0][12:0] } ;
				for ( i=9 ; i!=16 ; i=i+1 ) 
					X_next[i] = X[i] ;
			end
			shuffle : begin
				counter_next = 5'd0;
				ready = 1'b1;
         for ( i=0 ; i!=16 ; i=i+1 ) begin
					add1_in1[i] = buf_44[A[i]];
					add1_in2[i] = 18'd0;
					add2_in1[i] = 18'd0;
					add2_in2[i] = add1_o[i];
				end	
			end
		endcase
	end
	else begin
    if ( comp_type==nop || comp_type==mov || comp_type[4:2]==stall ) begin
      ready = hy_exe;
    end
		else begin
			case (curstate)
				state_p_a_1 : begin
					counter_next = 5'd1;
					ready = 1'b0;
					for ( i=0 ; i!=16 ; i=i+1 ) begin
						add1_in1[i] = A[i];
						add1_in2[i] = X[i];
						add2_in1[i] = add1_o[i][15:0];
						Y_next[i] = add2_o[i][16:0];
					end
					for ( i=1 ; i!=16 ; i=i+1 ) 
						add2_in2[i] = add1_o[i-1][16];
					add2_in2[0] = 18'd0;
				end
				state_p_s_N : begin
					counter_next = 5'd1;
					ready = 1'b0;
					for ( i=0 ; i!=16 ; i=i+1 ) begin
						add1_in1[i] = Y[i][17:0];
						add1_in2[i] = { 2'b11 , ~N[i] };
						Y_next[i]   = add2_o[i][15:0];
					end
					for ( i=1 ; i!=16 ; i=i+1 ) begin
						add2_in1[i] = add1_o[i][17:0];
						if (add1_o[i-1][17]==1'b1 && add1_o[i-1]!=-18'd1 )
							add2_in2[i] = 18'd0;
						else 
							add2_in2[i] = 18'd1;
					end
					add2_in1[0] = add1_o[0][17:0];
					add2_in2[0] = 18'd1;
				end
				state_p_s_1 : begin
					counter_next = 5'd1;
					ready = 1'b0;
					for ( i=0 ; i!=16 ; i=i+1 ) begin
						add1_in1[i] = A[i];
						add1_in2[i] = { 2'b11 , ~X[i] };
						Y_next[i]   = add2_o[i][15:0];
					end
					for ( i=1 ; i!=16 ; i=i+1 ) begin
						add2_in1[i] = add1_o[i][17:0];
						if (add1_o[i-1][17]==1'b1 && add1_o[i-1][17:0]!=-18'd1 )
							add2_in2[i] = 18'd0;
						else 
							add2_in2[i] = 18'd1;
					end
					add2_in1[0] = add1_o[0][17:0];
					add2_in2[0] = 18'd1;
				end
				state_p_a_N : begin
					counter_next = 5'd1;
					ready = 1'b0;
					for ( i=0 ; i!=16 ; i=i+1 ) begin
						add1_in1[i] = Y[i][17:0];
						add1_in2[i] = N[i];
						add2_in1[i] = add1_o[i][15:0];
						Y_next[i] = add2_o[i][16:0];
					end
					for ( i=1 ; i!=16 ; i=i+1 ) 
						add2_in2[i] = add1_o[i-1][16];
					add2_in2[0] = 18'd0;
				end
				state_p_m_0 : begin
					counter_next = counter;
					ready = 1'b0;
					mul_in1[0] = A[0];
					mul_in2[0] = X[0];
					temp_next  = mul_o[0][15:0];
					Y_next[0] = { 1'b0 , mul_o[0][15:0] };
					Y_next[1] = { 1'b0 , mul_o[0][31:16]};
				end 
				state_p_m_1 : begin
					counter_next = counter + 5'd1;
					ready = 1'b0;
					mul_in1[0] = temp;
					mul_in2[0] = np;
					for ( i=1 ; i!=16 ; i=i+1 ) begin
						mul_in1[i] 	= A[0];
						mul_in2[i] 	= X[i];
						add1_in1[i] = { 1'b0 , Y[i][16:0] };
						add1_in2[i] = { 2'd0 , mul_o[i][15:0] };
						add2_in1[i] = add1_o[i][17:0];
					end
					for ( i=2 ; i!=16 ; i=i+1 ) 
						add2_in2[i] = { 2'd0 , mul_o[i-1][31:16] };
					add2_in2[1] = 18'd0;
					for ( i=1 ; i!=16 ; i=i+1 ) begin
						Y_next[i] = add2_o[i];
					end
					Y_next[ 0] = Y[0];
					Y_next[16] = mul_o[15][31:16];
					temp_next = mul_o[0][15:0];
				end
				state_p_m_2 : begin
					counter_next = counter;
					ready = 1'b0;
					for ( i=0 ; i!=16 ; i=i+1 ) begin
						mul_in1[i]  = temp;
						mul_in2[i]  = N[i];
						add1_in1[i] = Y[i][17:0];
						add1_in2[i] = { 2'd0 , mul_o[i][15:0] };
					end
					add2_in1[0] = Y[16][17:0];
					add2_in2[0] = { 2'd0 , mul_o[15][31:16] };
					for ( i=1 ; i!=16 ; i=i+1 ) begin
						add2_in1[i] = add1_o[i][17:0];	
						add2_in2[i] = { 2'd0 , mul_o[i-1][31:16] };
						Y_next[i] = add2_o[i];
					end
					Y_next[ 0] = add1_o[0];
					Y_next[16] = add2_o[0];
					for( i=0 ; i!=15 ; i=i+1 )
						A_next[i] = A[i+1];
					A_next[15] = 16'd0;
				end
				state_p_m_3 : begin
					counter_next = counter;
					ready = 1'b0;
					mul_in1[0] = A[0]; 
					mul_in2[0] = X[0];
					for ( i=1 ; i!=16 ; i=i+1 ) begin
						add1_in1[i] = {  2'd0 , Y[i][15:0]};
						add1_in2[i] = { 15'd0 , Y[i-1][18:16]};
					end
					add1_in1[0] = { 2'd0 , Y[16][15:0]};
					add1_in2[0] = { 15'd0 , Y[15][18:16]};
					
					add2_in1[1] = add1_o[1][17:0];
					add2_in2[1] = { 2'd0 , mul_o[0][15:0] };
					add2_in1[2] = add1_o[2][17:0];
					add2_in2[2] = { 2'd0 , mul_o[0][31:16] };
					//should be mpdified to Y_next[i] = add2_o[i] for regular
					for ( i=2 ; i!=15 ; i=i+1 ) 
						Y_next[i] = add1_o[i+1];
					Y_next[ 0] = add2_o[1];
					Y_next[ 1] = add2_o[2];
					Y_next[15] = add1_o[0];
					Y_next[16] = 19'd0;
					temp_next = add2_o[1][15:0];
				end
				state_write : begin
					counter_next = 5'd0	;
					ready = 1'b1;
					for ( i=0 ; i!=16 ; i=i+1) begin
						vec_out[i] = Y[i][15:0];
						Y_next[i]   = (accuY) ? Y[i] : 19'd0;
						// A_next[i] = vec_inA[i];
						// X_next[i] = vec_inX[i];
					end
				end
        default : begin
          counter_next = 5'd0;
					ready = 1'b0;
					// ready = hy_exe;
					for ( i=0 ; i!=16 ; i=i+1) begin
						vec_out[i] = 16'd0;
						// Y_next[i]   = 19'd0;
						// A_next[i] = 16'd0;
						// X_next[i] = 16'd0;
					end
        end
			endcase
		end
	end
end

//===============================Combinational Logic===============================//
always @ (*) begin
  for (i=0 ; i<=15 ; i=i+1) begin
	  mul_o[i] = mul_in1[i] * mul_in2[i] ;
	  add1_o[i] = add1_in1[i] + add1_in2[i] ;
	  add2_o[i] = add2_in1[i] + add2_in2[i] ;
	end
end


endmodule

							