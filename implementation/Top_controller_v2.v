`define SRAM_WRITE          1'b0
`define SRAM_READ           1'b1

module Hydra_controller(
        clk,
        rst_n,
        start_i,            //Input   1-bits
        ack_i,              //Input   1-bits
        data_in_i,          //Input  32-bits  2-pixels
        
        in_inst_require_o,  //Output  1-bits
        in_data_require_o,  //Output  1-bits
        out_require_o,      //Output  1-bits
        data_o,         //Output 32-bits
        addr_o,
        finish_o , 
				interrupt_o ,
				Mem_dft_mode ,
				Mem_wen
        );
	////////////////////////////
  //--Parameter  
  ////////////////////////////
	parameter inst_num = 31;
  
  parameter STATE_IDLE        = 3'd0;
	parameter STATE_INST_LOAD   = 3'd1;
	parameter STATE_DATA_LOAD   = 3'd2;
	parameter STATE_DATA_EXE    = 3'd3;
	parameter STATE_WAIT        = 3'd4;
	parameter STATE_OUTPUT_DATA = 3'd5;
	parameter STATE_FINISH      = 3'd6;
	parameter STATE_INTERRUPT   = 3'd7;
	
	
	parameter STALL      = 3'd7;
	parameter TERMINATE  = 5'd31;
	parameter DATA_IN    = 5'd30;
	parameter DATA_OUT   = 5'd29;
	parameter INTERRUPT  = 5'd28;
	
	
	parameter EXE    = 3'd0;
	parameter D_IN   = 3'd1;
	parameter I_IN   = 3'd2;
	parameter D_OUT  = 3'd3;
	parameter TERMIN = 3'd4;
	parameter INTER  = 3'd5;
	
	////////////////////////////
  //--I/O Port  
  ////////////////////////////	
  input           clk;
  input           rst_n;
  input           start_i;
  input           ack_i;
  input           Mem_dft_mode;
  input   [31:0]  data_in_i;
      
  output          in_inst_require_o;
  output          in_data_require_o;
  output          out_require_o;
  output  [31:0]  data_o;
  output  [19:0]  addr_o;
  output          finish_o;
	output          interrupt_o;
	output  [2:0]   Mem_wen;
	reg     [2:0]   Mem_wen;
  
  ////////////////////////////
  //--Input Registers  
  ////////////////////////////
  reg             start_r;
  wire            start_w;

  ////////////////////////////
  //--SUB_MODULE
  ////////////////////////////	
	wire apxy_CEN;
	wire hy_ready ;
	wire #1 D_cache_WEN_1 , D_cache_WEN_2 , dec_WEN_1 , dec_WEN_2 , I_cache_WEN;
	wire hy_exe ;
	wire [255:0] hy_data_o1 , hy_data_o2 , D_cache_Q1 , D_cache_Q2;
	wire [255:0]  #1 D_cache_D1 , D_cache_D2 , dec_data_o1 ,dec_data_o2 , D_cache_Q1_MEM , D_cache_Q2_MEM;
	reg  [255:0]  D_cache_D1_r , D_cache_D2_r ;
  wire [inst_num-1:0]  inst_cur , inst_nxt , inst_in , inst_in_MEM ;
  reg  [inst_num-1:0]  I_cache_D_r;
	wire [  4:0] #1 D_cache_A1 , D_cache_A2 , dec_A1 , dec_A2;
	wire [ 15:0] inst_cnt_nxt;
	wire [ 31:0] #1 I_cache_D;
	wire [  6:0] #1 I_cache_addr;
	////////////////////////////
  //--TOP_CONTROL
  ////////////////////////////	
	wire top_WEN_1 , top_WEN_2;
	wire [  4:0] top_addr_1 , top_addr_2;
	wire [  6:0] top_I_addr; 
	wire [255:0] top_data_1 , top_data_2;
	wire out_require_w , out_require_w1;
	reg  out_require_r , out_require_r1;
	integer i;
  wire dummy ;
	wire rst_n_IP;
	
	assign D_cache_Q1 = (Mem_dft_mode) ? D_cache_D1_r : D_cache_Q1_MEM; 
	assign D_cache_Q2 = (Mem_dft_mode) ? D_cache_D2_r : D_cache_Q2_MEM; 
	assign inst_in    = (Mem_dft_mode) ? I_cache_D_r  : inst_in_MEM; 
	// assign Mem_wen    = { D_cache_WEN_1 , D_cache_WEN_2 , I_cache_WEN}; 

	Hydra my_hydra (  .ready(hy_ready)      , 
									  .data_out(hy_data_o2) , 
                    .clk(clk)             , 
										.rst_n(rst_n_IP)      , 
										.inst_cur(inst_cur)   , 
                    .inst_nxt(inst_nxt)   , 
										.data_in_1(D_cache_Q1)     , 
										.data_in_2(D_cache_Q2)     ,  
										.hy_exe(apxy_CEN) 
	);
	/*D_Cache D_cache_1_1 (
								.Q(D_cache_Q1_MEM[127:0]),
                .CLK(clk),
                .CEN(1'b0),
                .WEN(D_cache_WEN_1),
                .A(D_cache_A1),
                .D(D_cache_D1[127:0]),
                .EMA(3'd0)
	);
	D_Cache D_cache_1_2 (
								.Q(D_cache_Q1_MEM[255:128]),
                .CLK(clk),
                .CEN(1'b0),
                .WEN(D_cache_WEN_1),
                .A(D_cache_A1),
                .D(D_cache_D1[255:128]),
                .EMA(3'd0)
	);
	D_Cache D_cache_2_1 (
								.Q(D_cache_Q2_MEM[127:0]),
                .CLK(clk),
                .CEN(1'b0),
                .WEN(D_cache_WEN_2),
                .A(D_cache_A2),
                .D(D_cache_D2[127:0]),
                .EMA(3'd0)
	);
	D_Cache D_cache_2_2 (
								.Q(D_cache_Q2_MEM[255:128]),
                .CLK(clk),
                .CEN(1'b0),
                .WEN(D_cache_WEN_2),
                .A(D_cache_A2),
                .D(D_cache_D2[255:128]),
                .EMA(3'd0)
	);*/
	
	blk_mem_gen_v4_2 D_cache_1_1 (
		.clka(clk),
		.ena(1'b1),
		.wea(D_cache_WEN_1),
		.addra(D_cache_A1),
		.dina(D_cache_D1[127:0]),
		.douta(D_cache_Q1_MEM[127:0])
	);
	blk_mem_gen_v4_2 D_cache_1_2 (
					 .douta(D_cache_Q1_MEM[255:128]),
                .clka(clk),
                .ena(1'b1),
                .wea(D_cache_WEN_1),
                .addra(D_cache_A1),
                .dina(D_cache_D1[255:128])
	);
	blk_mem_gen_v4_2 D_cache_2_1 (
					 .douta(D_cache_Q2_MEM[127:0]),
                .clka(clk),
                .ena(1'b0),
                .wea(D_cache_WEN_2),
                .addra(D_cache_A2),
                .dina(D_cache_D2[127:0])
	);
	blk_mem_gen_v4_2 D_cache_2_2 (
					 .douta(D_cache_Q2_MEM[255:128]),
                .clka(clk),
                .ena(1'b0),
                .wea(D_cache_WEN_2),
                .addra(D_cache_A2),
                .dina(D_cache_D2[255:128])
	);
		
	smart_unit my_dec (  .inst_out(inst_cur) , 
										.addr_d1(dec_A1) , 
										.addr_d2(dec_A2) , 
										.addr_inst(inst_cnt_nxt) ,  
										.W_d1(dec_WEN_1) , 
										.W_d2(dec_WEN_2) , 
										.Dout_d1(dec_data_o1) , 
										.Dout_d2(dec_data_o2) , 
										.apxy_CEN(apxy_CEN),
										.inst_nxt(inst_nxt),
								    .clk(clk) , 
										.rst_n(rst_n_IP) , 
										.inst_in(inst_in) , 
										.ready_hy(hy_ready) , 
										.hy_exe(hy_exe), 
								    .Din_c1(D_cache_Q1) , 
										.Din_c2(D_cache_Q2) , 
										.Din_hy(hy_data_o2) 
	);
	
	/*I_Cache I_cache (
								.Q( {dummy , inst_in_MEM} ),
                .CLK(clk),
                .CEN(1'b0),
                .WEN(I_cache_WEN),
                .A(I_cache_addr),
                .D(I_cache_D),
                .EMA(3'd0)
                );*/
				
	I_cache I_cache (
			.clka(clk),
			.ena(1'b1),
			.wea(I_cache_WEN),
			.addra(I_cache_addr),
			.dina(I_cache_D),
			.douta({dummy , inst_in_MEM} )
   );
								
	////////////////////////////
  //--FSM
  ////////////////////////////
  reg [2:0] curstate,nxtstate;
	reg [2:0] state_d1_r,state_d1_w;
  reg [2:0] state_d2_r,state_d2_w;
	reg [8:0] counter_inst_nxt , counter_inst , counter_data , counter_data_nxt , counter_data_d1;
	reg [4:0] counter_io , counter_io_nxt;
	// reg [8:0] count_data_d1_w ;  
	reg [2:0] counter_8 , counter_8_next ;  
	reg stall_in , stall_out , stall_in_d1_w;

	reg [31:0] data_byte_w_0 , data_byte_w_1 , data_byte_w_2 , data_byte_w_3 , data_byte_w_4 , data_byte_w_5 , data_byte_w_6 , data_byte_w_7;
	reg [31:0] data_byte_r_0 , data_byte_r_1 , data_byte_r_2 , data_byte_r_3 , data_byte_r_4 , data_byte_r_5 , data_byte_r_6 , data_byte_r_7 , data_byte_r_7_d1;
	
	reg [ 4:0] num_io_r;
	reg [13:0] offset_addr_r;
//==============//

  // wire rst_n_IP;
	reg  [2:0] flag_wait_w , flag_wait_r;
	//===================connecting wire===========================//
	wire [4:0] comp_type_cur = inst_cur[30:26];
	wire [4:0] addr_A_cur    = inst_cur[23:19];
	wire [4:0] addr_X_cur    = inst_cur[14:10];
  
  wire [5:0] addr_io_start  = inst_cur[25:20];
	wire [4:0] num_io         = inst_cur[19:15];
	wire [4:0] num_io_w       = (curstate==STATE_DATA_EXE && (comp_type_cur==DATA_IN || comp_type_cur==DATA_OUT) ) ? num_io : (curstate==STATE_DATA_EXE) ? 5'd0 : num_io_r;
	wire [13:0] offset_addr   = inst_cur[14:1];
	wire [13:0] offset_addr_w = (curstate==STATE_DATA_EXE && (comp_type_cur==DATA_IN || comp_type_cur==DATA_OUT) ) ? offset_addr : (curstate==STATE_DATA_EXE) ? 14'd0 : offset_addr_r;
	
	
  ////////////////////////////
  //--I/O control
  ////////////////////////////
  assign start_w = start_i;
	assign in_inst_require_o = (curstate == STATE_INST_LOAD)? 1'b1 : 1'b0;
	assign in_data_require_o = (curstate == STATE_DATA_LOAD  )? 1'b1 : 1'b0;
	
	assign out_require_o     = (state_d1_r == STATE_OUTPUT_DATA)? 1'b1 : 1'b0;
	assign out_require_w     = (curstate == STATE_OUTPUT_DATA)? 1'b1 : 1'b0;
	assign out_require_w1    = out_require_r;
	
	assign interrupt_o       = (curstate == STATE_INTERRUPT) ? 1'b1 : 1'b0;
  ////////////////////////////
  //--Hierarchical control
  //////////////////////////// 
	assign D_cache_D1 = (hy_exe) ? dec_data_o1 : top_data_1;
	assign D_cache_D2 = (hy_exe) ? dec_data_o2 : top_data_2;
	
	assign D_cache_WEN_1 =  (hy_exe) ? dec_WEN_1 : top_WEN_1;
	assign D_cache_WEN_2 =  (hy_exe) ? dec_WEN_2 : top_WEN_2;
	
	assign D_cache_A1 = (hy_exe) ? dec_A1 : top_addr_1;
	assign D_cache_A2 = (hy_exe) ? dec_A2 : top_addr_2;
	
	assign I_cache_addr = (curstate==STATE_INST_LOAD) ? top_I_addr : inst_cnt_nxt[6:0];
  reg fin_reg;
    ////////////////////////////
  //--Output
  ////////////////////////////
  wire        in_inst_require_o;
  wire        in_data_require_o;
  wire        out_require_o;
  reg  [31:0] data_o;
  wire [31:0] data_w;
  wire [19:0] addr_o   = { offset_addr_r , 3'd0 } /*+ {counter_io , 3'd0 } + counter_8*/;//{ counter_data_d1 , counter_8 };  //XXXXXXXXXXXXXXXXXX
  wire        finish_o = ( curstate==STATE_FINISH ) ? 1'b1 : 1'b0;
	//=====================================================================
  always@(posedge clk or negedge rst_n)
    if(!rst_n)
      fin_reg <= 0;
    else
      fin_reg <= curstate != STATE_FINISH;
  // assign rst_n_IP = fin_reg;
	assign rst_n_IP = (Mem_dft_mode) ? rst_n : fin_reg; 
  ////////////////////////////
  //--FSM
  ////////////////////////////
  always @ (*) begin
		case(curstate)
			STATE_IDLE : begin
				counter_inst_nxt = 9'd0;
				counter_data_nxt = 9'd0;
				counter_8_next   = 3'd0;
				counter_io_nxt   = 5'd0;
				stall_in  = 1'b0;
				flag_wait_w = EXE;
				if(start_r == 1'b1)
					nxtstate = STATE_INST_LOAD;
				else 
					nxtstate = STATE_IDLE;
			end
			STATE_INST_LOAD : begin
				counter_data_nxt = 9'd0;
				counter_8_next   = 3'd0;
				counter_io_nxt   = 5'd0;
				flag_wait_w = EXE;
				if ( ack_i==1'b0 ) begin
					nxtstate = STATE_INST_LOAD;
					counter_inst_nxt = counter_inst;
					stall_in = 1'b1;
				end
				else if  ( counter_inst == 9'd127 ) begin
					nxtstate = STATE_WAIT;
					counter_inst_nxt = 9'd0;
					stall_in = 1'b0;
				end
				else begin 
					nxtstate = STATE_INST_LOAD;
					counter_inst_nxt = counter_inst + 9'd1;
					stall_in = 1'b0;
				end
			end
			STATE_DATA_LOAD : begin
				counter_inst_nxt = 9'd0;
				flag_wait_w = EXE;
				if ( ack_i==1'b0 ) begin
					nxtstate = STATE_DATA_LOAD;
					counter_data_nxt = counter_data;
					counter_8_next = counter_8;
					counter_io_nxt = counter_io;
					stall_in = 1'b1;
				end
				else if  ( counter_io==num_io_r && counter_8==3'd7 ) begin // should be modified
					nxtstate = STATE_WAIT;
					counter_data_nxt = counter_data;
					counter_8_next = 3'd0;
					counter_io_nxt = counter_io;
					stall_in = 1'b0;
				end
				else begin
					nxtstate = STATE_DATA_LOAD;
					counter_data_nxt = (counter_8==3'd7) ? counter_data + 9'd1 : counter_data;
					counter_io_nxt   = (counter_8==3'd7) ? counter_io + 5'd1 : counter_io;
					counter_8_next = counter_8 + 3'd1;
					stall_in = 1'b0;
				end
			end
			STATE_DATA_EXE : begin
				counter_inst_nxt = 9'd0;
				counter_data_nxt = addr_io_start;
				counter_8_next   = 3'd0;
				stall_in  = 1'b0;
				if ( comp_type_cur[4:2]==STALL) begin
					nxtstate = STATE_WAIT;
					if (comp_type_cur==TERMINATE)
						flag_wait_w = TERMIN;
					else if (comp_type_cur==DATA_IN)
						flag_wait_w = D_IN;
					else if (comp_type_cur==DATA_OUT)
						flag_wait_w = D_OUT;
					else if (comp_type_cur==INTERRUPT)
						flag_wait_w = INTER;
					else
						flag_wait_w = EXE;
					counter_io_nxt = 5'd0;
				end
				else if ( I_cache_addr==0 && hy_ready==1'b1 ) begin
					nxtstate = STATE_WAIT;
					flag_wait_w = I_IN;
					counter_io_nxt = 5'd0;
				end
				else begin
					nxtstate = STATE_DATA_EXE;
					flag_wait_w = EXE;
					counter_io_nxt = 5'd0;
				end
			end
			STATE_WAIT : begin 
				counter_inst_nxt = 9'd0;
				counter_data_nxt = counter_data;
				counter_io_nxt   = counter_io;
				flag_wait_w      = flag_wait_r;
				
				if (flag_wait_r==D_OUT)
					counter_8_next = 3'd7;
				else
					counter_8_next   = 3'd0;
				stall_in  = 1'b0;
				case (flag_wait_r)
					EXE     : nxtstate = STATE_DATA_EXE;
					D_IN    : nxtstate = STATE_DATA_LOAD;
					I_IN    : nxtstate = STATE_INST_LOAD;
					D_OUT   : nxtstate = STATE_OUTPUT_DATA;
					TERMIN  : nxtstate = STATE_FINISH;
					default : nxtstate = STATE_INTERRUPT;
				endcase
			end
			STATE_INTERRUPT : begin
				counter_inst_nxt = counter_inst;
				counter_data_nxt = counter_data;
				counter_8_next   = counter_8;
				counter_io_nxt   = counter_io;
				flag_wait_w      = EXE;
				stall_in  = 1'b0;
				if (start_r==1'b1)
					nxtstate = STATE_WAIT;
				else 
					nxtstate = STATE_INTERRUPT;
			end
			STATE_OUTPUT_DATA : begin
				counter_inst_nxt = 9'd0;
				stall_in  = 1'b0;
				flag_wait_w = EXE;
				if ( ack_i==1'b0 && out_require_o==1'b1 ) begin
					nxtstate = STATE_OUTPUT_DATA;
					counter_data_nxt = counter_data;
					counter_8_next   = counter_8;
					counter_io_nxt   = counter_io;
				end
				else if ( counter_io==num_io_r+5'd1 && counter_8==3'd7 ) begin                         //????????????
					nxtstate = STATE_WAIT;                  // should be modified
					counter_data_nxt = counter_data;
					counter_8_next   = 3'd0;
					counter_io_nxt   = counter_io;
				end
				else begin 
					nxtstate = STATE_OUTPUT_DATA;
					counter_data_nxt = (counter_8==3'd5) ? counter_data + 9'd1 : counter_data;
					counter_io_nxt = (counter_8==3'd5) ? counter_io + 5'd1 : counter_io;
					counter_8_next = counter_8 + 3'd1;
				end
			end
			default : begin 
				if (counter_8==3'd7)
          nxtstate = STATE_IDLE;                   // default used as STATE_FINISH
				else
          nxtstate = STATE_FINISH;
        counter_inst_nxt = 9'd0;
				counter_data_nxt = 9'd0;
        counter_8_next   = counter_8 + 3'd1;
				flag_wait_w      = EXE; 
				counter_io_nxt   = 5'd0; 
				stall_in  = 1'b0;
			end
		endcase
	end
//*******This part is preserved********//  
  always@(*) begin
    if(curstate == STATE_FINISH) begin
      state_d1_w = curstate;
      // count_data_d1_w = counter_data;
      state_d2_w = state_d1_r;
      // count_data_d2_w = count_data_d1_r;
    end
    else if(stall_in == 1'b1 || stall_out == 1'b1)
        begin
            state_d1_w = state_d1_r;
            // count_data_d1_w = count_data_d1_r;
            state_d2_w = state_d2_r;
            // count_data_d2_w = count_data_d2_r;
        end
    else
        begin
            state_d1_w = curstate;
            // count_data_d1_w = counter_data;
            state_d2_w = state_d1_r;
            // count_data_d2_w = count_data_d1_r;
        end
    stall_in_d1_w = stall_in;
  end
//*******This part is preserved********//    //why use d2 data
  always@(*) begin
      if(state_d2_r==STATE_OUTPUT_DATA && ack_i == 1'b0)  
          stall_out = 1'b1;
      else
          stall_out = 1'b0;
  end
  ////////////////////////////
  //--Data Control
  //////////////////////////// 
	assign hy_exe = ( curstate==STATE_DATA_EXE ) ? 1'b1 : 1'b0;
	assign top_I_addr  = ( curstate==STATE_INST_LOAD ) ? counter_inst[6:0] : 7'd0;
	assign I_cache_D   = ( curstate==STATE_INST_LOAD ) ? data_in_i : 32'd0;
	assign I_cache_WEN = ( curstate==STATE_INST_LOAD ) ? 1'b0 : 1'b1;
	assign top_data_1 = { data_byte_w_7 , data_byte_w_6 , data_byte_w_5 , data_byte_w_4 , 
	                      data_byte_w_3 , data_byte_w_2 , data_byte_w_1 , data_byte_w_0 };
	assign top_data_2 = { data_byte_w_7 , data_byte_w_6 , data_byte_w_5 , data_byte_w_4 , 
	                      data_byte_w_3 , data_byte_w_2 , data_byte_w_1 , data_byte_w_0 };
	assign top_addr_1 = counter_data[4:0];
	assign top_addr_2 = counter_data[4:0];
	assign top_WEN_1 = ( curstate==STATE_DATA_LOAD && counter_8==3'd7 && counter_data<32 ) ? 1'b0 : 1'b1;
	assign top_WEN_2 = ( curstate==STATE_DATA_LOAD && counter_8==3'd7 && counter_data>31 ) ? 1'b0 : 1'b1;
  
	always @ (*) begin
    case (counter_8) 
      3'd0 : data_o = data_byte_r_0;
      3'd1 : data_o = data_byte_r_1;
      3'd2 : data_o = data_byte_r_2;
      3'd3 : data_o = data_byte_r_3;
      3'd4 : data_o = data_byte_r_4;
      3'd5 : data_o = data_byte_r_5;
      3'd6 : data_o = data_byte_r_6;
      3'd7 : data_o = data_byte_r_7;
			default : data_o = 32'd0;
    endcase
  end
  // assign data_o = data_byte_r[counter_8];

	
	always @ (*) begin
		
		if ( curstate==STATE_DATA_LOAD ) begin
			data_byte_w_0 = (counter_8==3'd0) ? data_in_i : data_byte_r_0;
			data_byte_w_1 = (counter_8==3'd1) ? data_in_i : data_byte_r_1;
			data_byte_w_2 = (counter_8==3'd2) ? data_in_i : data_byte_r_2;
			data_byte_w_3 = (counter_8==3'd3) ? data_in_i : data_byte_r_3;
			data_byte_w_4 = (counter_8==3'd4) ? data_in_i : data_byte_r_4;
			data_byte_w_5 = (counter_8==3'd5) ? data_in_i : data_byte_r_5;
			data_byte_w_6 = (counter_8==3'd6) ? data_in_i : data_byte_r_6;
			data_byte_w_7 = (counter_8==3'd7) ? data_in_i : data_byte_r_7;
      // for ( i=0 ; i!=8 ; i=i+1)
				// data_byte_w[i] = data_byte_r[i];
			// data_byte_w[counter_8] = data_in_i;
		end
		else if ( curstate==STATE_OUTPUT_DATA ) begin
			if ( counter_8_next==3'd0 && counter_data<32 ) begin
				{ data_byte_w_7 , data_byte_w_6 , data_byte_w_5 , data_byte_w_4 , 
	        data_byte_w_3 , data_byte_w_2 , data_byte_w_1 , data_byte_w_0 } = D_cache_Q1;
			end
			else if ( counter_8_next==3'd0) begin
				{ data_byte_w_7 , data_byte_w_6 , data_byte_w_5 , data_byte_w_4 , 
	        data_byte_w_3 , data_byte_w_2 , data_byte_w_1 , data_byte_w_0 } = D_cache_Q2;
			end
			else begin
        data_byte_w_0 = data_byte_r_0;
        data_byte_w_1 = data_byte_r_1;
        data_byte_w_2 = data_byte_r_2;
        data_byte_w_3 = data_byte_r_3;
        data_byte_w_4 = data_byte_r_4;
        data_byte_w_5 = data_byte_r_5;
        data_byte_w_6 = data_byte_r_6;
        data_byte_w_7 = data_byte_r_7;
				// for ( i=0 ; i!=8 ; i=i+1)
					// data_byte_w[i] = data_byte_r[i];
			end
		end
		else begin
			// for ( i=0 ; i!=8 ; i=i+1)
				// data_byte_w[i] = data_byte_r[i];
      data_byte_w_0 = data_byte_r_0;
      data_byte_w_1 = data_byte_r_1;
      data_byte_w_2 = data_byte_r_2;
      data_byte_w_3 = data_byte_r_3;
      data_byte_w_4 = data_byte_r_4;
      data_byte_w_5 = data_byte_r_5;
      data_byte_w_6 = data_byte_r_6;
      data_byte_w_7 = data_byte_r_7;
		end
	end
	////////////////////////////
  //--Sequential Circuit
  ////////////////////////////  
  always@( posedge clk or negedge rst_n_IP ) begin
    if(rst_n_IP == 1'b0) begin
			curstate     <= 3'd0;
			start_r      <= 1'd0;
			counter_inst <= 9'd0;
			counter_data <= 9'd0;
			state_d1_r   <= 3'd0;
			state_d2_r   <= 3'd0;  
			counter_8    <= 3'd0;			
			counter_data_d1 <= 9'd0;
      data_byte_r_0 <= 32'd0;
      data_byte_r_1 <= 32'd0;
      data_byte_r_2 <= 32'd0;
      data_byte_r_3 <= 32'd0;
      data_byte_r_4 <= 32'd0;
      data_byte_r_5 <= 32'd0;
      data_byte_r_6 <= 32'd0;
      data_byte_r_7 <= 32'd0;
      data_byte_r_7_d1 <= 32'd0; 
			
			out_require_r <= 1'b0;
			out_require_r1 <= 1'b0;
			
			counter_io     <= 5'd0;
			flag_wait_r    <= 3'd0;
			offset_addr_r  <= 13'd0;
			num_io_r       <= 5'd0;
			D_cache_D1_r   <= 256'd0;
			D_cache_D2_r   <= 256'd0;
			I_cache_D_r    <= 31'd0;
			Mem_wen        <=  3'd0;
			
    end 
    else begin
			curstate     <= nxtstate;
			start_r      <= start_w;
			counter_inst <= counter_inst_nxt;
			counter_data <= counter_data_nxt;
			state_d1_r   <= state_d1_w;
			state_d2_r   <= state_d2_w; 
			counter_8    <= counter_8_next;
			counter_data_d1 <= counter_data;
      data_byte_r_0 <= data_byte_w_0;
      data_byte_r_1 <= data_byte_w_1;
      data_byte_r_2 <= data_byte_w_2;
      data_byte_r_3 <= data_byte_w_3;
      data_byte_r_4 <= data_byte_w_4;
      data_byte_r_5 <= data_byte_w_5;
      data_byte_r_6 <= data_byte_w_6;
      data_byte_r_7 <= data_byte_w_7;
      data_byte_r_7_d1 <= data_byte_r_7;
			
			out_require_r <= out_require_w;
			out_require_r1 <= out_require_w1;
			
			counter_io     <= counter_io_nxt;
			flag_wait_r    <= flag_wait_w;
			offset_addr_r  <= offset_addr_w;
			num_io_r       <=num_io_w;
			D_cache_D1_r   <= D_cache_D1;
			D_cache_D2_r   <= D_cache_D2;
			I_cache_D_r    <= I_cache_D;
			Mem_wen        <= { D_cache_WEN_1 , D_cache_WEN_2 , I_cache_WEN };
    end
  end
    
endmodule        