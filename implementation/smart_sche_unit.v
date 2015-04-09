module smart_unit ( inst_out , addr_d1 , addr_d2 , addr_inst ,  
                 W_d1 , W_d2 , Dout_d1 , Dout_d2 , apxy_CEN , inst_nxt , 
								 clk , rst_n , inst_in , ready_hy , hy_exe ,  
								 Din_c1 , Din_c2 , Din_hy
							);
								
//====parameter Declaration====//
parameter inst_num = 31;

parameter mov     = 5'h7;
parameter set     = 5'h9;
parameter jump    = 5'ha;


parameter mode_i = 1'b0;
parameter mode_q = 1'b1;
//====I/O Declaration====//
output [inst_num-1:0] inst_out ;
// reg    [ 28:0] inst_out ;
output [  4:0] addr_d1 , addr_d2;
reg    [  4:0] addr_d1 , addr_d2;
output [ 15:0] addr_inst;
reg    [ 15:0] addr_inst;
output [255:0] Dout_d1 , Dout_d2;
reg    [255:0] Dout_d1 , Dout_d2;
output W_d1 , W_d2;
reg    W_d1 , W_d2;
output apxy_CEN;
output [inst_num-1:0] inst_nxt;

input  clk , rst_n , ready_hy , hy_exe; 
input  [inst_num-1:0] inst_in;
input  [255:0] Din_c1 , Din_c2 , Din_hy;
//====Register Declaration====//
reg [inst_num-1:0] inst_out_next;
reg [inst_num-1:0] inst_1 , inst_2 , inst_1_next , inst_2_next;
reg [15:0] addr_inst_next;
reg [ 4:0] counter , counter_next;
reg [ 6:0] counter_jump , counter_jump_next;

wire hy_WB = inst_out[6];
wire hy_W_bank = inst_out[5];
wire [4:0] comp_type_1  = inst_1[30:26];
wire [6:0] j_counter_1  = inst_1[25:19]; 
wire [4:0] hy_addr_A  = inst_out[23:19];
wire [4:0] hy_addr_X  = inst_out[14:10];
wire [4:0] hy_addr_WB = inst_out[4 : 0];


wire [4:0] addr_A_in = inst_in[23:19];
wire [4:0] addr_X_in = inst_in[14:10];
wire [4:0] comp_type_i = inst_in[30:26];
wire [6:0] j_counter_i = inst_in[25:19];


wire [4:0] addr_A_1 = inst_1[23:19];
wire [4:0] addr_X_1 = inst_1[14:10];

wire [4:0] addr_A_cur = inst_2[23:19];
wire [4:0] addr_X_cur = inst_2[14:10];

wire [4:0] mov_addr_A = inst_1[24:20];
wire [4:0] mov_addr_X = inst_1[24:20];
wire [4:0] mov_addr_WB = inst_1[18:14];

assign inst_out = inst_2;
assign apxy_CEN = (addr_inst>5'd2 && hy_exe==1'b1 ) ? 1'b1 : 1'b0;
assign inst_nxt = inst_1;

always @ ( posedge clk or negedge rst_n ) begin
	if ( rst_n==1'b0 ) begin
		inst_1   <= 31'd0;
		inst_2   <= 31'd0;
		counter  <= 5'd0;
		counter_jump <= 7'd0;
	end
	else begin
		// inst_out <= inst_out_next;
		inst_1   <= inst_1_next;//( (ready_hy==1'b1 || addr_inst<5'd3) && hy_exe==1'b1 ) ? inst_in : inst_1;
		inst_2   <= inst_2_next;//( (ready_hy==1'b1 || addr_inst<5'd3) && hy_exe==1'b1 ) ? inst_1 : inst_2;
		counter  <= counter_next;
		counter_jump <= counter_jump_next;
	end
end
always @ ( negedge clk or negedge rst_n ) begin
	if ( rst_n==1'b0 ) begin
		addr_inst<= 16'd0;
	end
	else begin
		addr_inst<= addr_inst_next;
	end
end

always @ (*) begin
	if (hy_exe==1'b0)
		addr_inst_next = addr_inst;
	else if ( comp_type_i==jump ) // jump should be change
		if (counter_jump==7'd0)
			addr_inst_next = addr_inst + 5'd1;
		else
			addr_inst_next = addr_inst - j_counter_i ;
	else if (ready_hy==1'b1 || addr_inst<5'd3 || comp_type_1==set)
		addr_inst_next = addr_inst + 5'd1 ;
	else if (comp_type_1==mov)
		addr_inst_next = (counter==5'd1) ? addr_inst+5'd1 : addr_inst;
	else
		addr_inst_next = addr_inst;
end

always @ (*) begin
	inst_1_next = ( (ready_hy==1'b1 || addr_inst<5'd3) && hy_exe==1'b1 ) ? inst_in : inst_1;
	inst_2_next = ( (ready_hy==1'b1 || addr_inst<5'd3) && hy_exe==1'b1 ) ? inst_1 : inst_2;
	case (comp_type_1)
		mov : begin
			if ( hy_WB==1'b1 && ready_hy==1'b1 ) begin
				counter_next = counter;
				if (hy_W_bank==1'b1) begin
					W_d1 = 1'b1;
					W_d2 = 1'b0;
					addr_d1 = addr_A_in;
					addr_d2 = hy_addr_WB;
					Dout_d1 = Din_hy;
					Dout_d2 = Din_hy;
				end
				else begin 
					W_d1 = 1'b0;
					W_d2 = 1'b1;
					addr_d1 = hy_addr_WB;
					addr_d2 = addr_X_in;
					Dout_d1 = Din_hy;
					Dout_d2 = Din_hy;	
				end	
			end
			else if (counter==5'd1) begin
				counter_next = 5'd0;
				W_d1 = inst_1[19];
				W_d2 = ~inst_1[19];
				addr_d1 = mov_addr_WB;
				addr_d2 = mov_addr_WB;
				if (inst_1[25]) begin
					Dout_d1 = Din_c2;
					Dout_d2 = Din_c2;
				end
				else begin
					Dout_d1 = Din_c1;
					Dout_d2 = Din_c1;
				end
				inst_1_next = inst_in;
				inst_2_next = inst_2;
			end
			else begin
				counter_next = 5'd1;
				W_d1 = 1'b1;
				W_d2 = 1'b1;
				addr_d1 = mov_addr_A;
				addr_d2 = mov_addr_X;
				Dout_d1 = 256'd0;
				Dout_d2 = 256'd0;
			end
			counter_jump_next = counter_jump;
		end
		default : begin
			if (comp_type_1==set)
				counter_jump_next = j_counter_1;
			else if (comp_type_i==jump && counter_jump!=7'd0)
				counter_jump_next = counter_jump-7'd1;
			else
				counter_jump_next = counter_jump;
			counter_next = 5'd0;
			
			if (comp_type_1==set /*|| inst_1==stall*/) begin
				inst_1_next = inst_in;
				inst_2_next = 31'd0;
			end
			if (comp_type_i==jump) begin
				inst_1_next = 31'd0;
			end
			
			
			if ( hy_WB==1'b1 && ready_hy==1'b1 ) begin
				if (hy_W_bank==1'b1) begin
					addr_d2 = hy_addr_WB;
					Dout_d2  = Din_hy;
					W_d2 = 1'b0;
					W_d1 = 1'b1;
					addr_d1 = (ready_hy==1'b1) ? addr_A_in : addr_A_1;
					Dout_d1 = 256'd0;
				end
				else begin
					addr_d2 = (ready_hy==1'b1) ? addr_X_in : addr_X_1;
					Dout_d2  = 256'd0;
					W_d2 = 1'b1;
					W_d1 = 1'b0;
					addr_d1 = hy_addr_WB;
					Dout_d1 = Din_hy;
				end
				
			end
			else begin
				addr_d2 = (ready_hy==1'b1) ? addr_X_in : addr_X_1;
				Dout_d2  = 256'd0;
				W_d2 = 1'b1;
				W_d1 = 1'b1;
				addr_d1 = (ready_hy==1'b1) ? addr_A_in : addr_A_1;
				Dout_d1 = 256'd0;
			end
		end
	endcase
end

endmodule

							