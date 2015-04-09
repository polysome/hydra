// ------------------------------------ //
// Date: 2009/01/06
// Designers: doli, peter, firstpeople
// DSP/IC Lab
//
// ------------------------------------ //



module MYIP_WRAPPER(HCLK,             //HCLK       , Input
					          HRESETn,          //HRESETn    , Input
					                                           
					          M_HREADY,         //Master Port, Input
					          M_HRESP,          //Master Port, Input
					          M_HRDATA,         //Master Port, Input
					          M_HGRANT,         //Master Port, Input
					          M_HBUSREQ,        //Master Port, Output
					          M_HLOCK,          //Master Port, Output
					          M_HTRANS,         //Master Port, Output
					          M_HADDR,          //Master Port, Output
					          M_HWRITE,         //Master Port, Output
					          M_HSIZE,          //Master Port, Output
					          M_HBURST,         //Master Port, Output
					          M_HPROT,          //Master Port, Output
					          M_HWDATA,         //Master Port, Output
					          
					          S_HADDR,          //Slave Port , Input
					          S_HTRANS,         //Slave Port , Input
					          S_HWRITE,         //Slave Port , Input
					          S_HSIZE,          //Slave Port , Input
					          // S_HBURST,         //Slave Port , Input
					          S_HWDATA,         //Slave Port , Input
					          S_HSELx,          //Slave Port , Input
					          S_HREADYin,       //Slave Port , Input
					          S_HRDATA,         //Slave Port , Output
					          S_HREADYout,      //Slave Port , Output
					          S_HRESP,           //Slave Port , Output
										interrupt,
										Mem_dft_mode , 
										Mem_wen_hydra
					          );        
                         
  input             HCLK;    
  input             HRESETn; 
  input             Mem_dft_mode; 
                    
  input             M_HREADY;  
  input   [1:0]     M_HRESP;   
  input  [31:0]     M_HRDATA;  
  input             M_HGRANT;
  output            M_HBUSREQ;
  output            M_HLOCK;
  output  [1:0]     M_HTRANS;
  output [31:0]     M_HADDR;
  output            M_HWRITE;
  output  [2:0]     M_HSIZE;
  output  [2:0]     M_HBURST;
  output  [3:0]     M_HPROT;
  output [31:0]     M_HWDATA;
                    
  input  [31:0]     S_HADDR;
  input   [1:0]     S_HTRANS;
  input             S_HWRITE;
  input   [2:0]     S_HSIZE;
  // input   [2:0]     S_HBURST;
  input  [31:0]     S_HWDATA;
  input             S_HSELx;
  input             S_HREADYin;
  output [31:0]     S_HRDATA;
  output            S_HREADYout;
  output  [1:0]     S_HRESP;
	output  [2:0]     Mem_wen_hydra;
  reg               S_HREADYout;

//------------------------------------------------------------------------------
//  Constant declarations
//------------------------------------------------------------------------------
// HTRANS transfer type signal encoding
  `define TRN_IDLE   2'b00
  `define TRN_BUSY   2'b01
  `define TRN_NONSEQ 2'b10
  `define TRN_SEQ    2'b11

// HSIZE transfer type signal encoding
  `define SZ_BYTE 3'b000
  `define SZ_HALF 3'b001
  `define SZ_WORD 3'b010

// HRESP transfer response signal encoding
  `define RSP_OKAY   2'b00
  `define RSP_ERROR  2'b01
  `define RSP_RETRY  2'b10
  `define RSP_SPLIT  2'b11
  
// HBURST
	`define BURST_SINGLE 3'b000
	`define BURST_INCE   3'b001
	`define BURST_WRAP4  3'b010
	`define BURST_INCR4  3'b011
	`define BURST_WRAP8  3'b100
	`define BURST_INCR8  3'b101
	`define BURST_WRAP16 3'b110
	`define BURST_INCR16 3'b111

// myip status
`define MYIP_STATUS_VALID           4'b0000
`define MYIP_STATUS_WAIT            4'b0010
`define MYIP_STATUS_INPUT_BURST16   4'b0100
`define MYIP_STATUS_OUTPUT_BURST16  4'b1000

// myip state
`define MYIP_IDLE            			4'd0
`define MYIP_WAIT            			4'd1
`define MYIP_INST_INPUT_BURST16   4'd2
`define MYIP_DATA_INPUT_BURST16		4'd6
`define MYIP_OUTPUT_BURST16  			4'd3
`define MYIP_INPUT_BURST16_END   	4'd4
`define MYIP_OUTPUT_BURST16_END   4'd5
`define MYIP_STALL                4'hf

////////////////////////////////////////////////////
//=====================Ohters=====================//
////////////////////////////////////////////////////

reg  [3:0]  current_state, next_state;
reg  [3:0]  current_state_d1_r;
wire [3:0]  current_state_d1_w;
reg  [3:0]  burst_counter, burst_counter_acc;
// reg [29:0]  ext_input_addr_counter, ext_input_addr_counter_acc;
reg [29:0]  ext_inst_input_addr_counter, ext_inst_input_addr_counter_acc;
reg [29:0]  ext_data_input_addr_counter, ext_data_input_addr_counter_acc;
reg [29:0]  ext_data_output_addr_counter, ext_data_output_addr_counter_acc;
            
                                                                                 
reg         MYIP_start_r                      , MYIP_start_w                       ; 
reg  [3:0]  MYIP_status_r                     , MYIP_status_w                      ;   
reg [31:0]  MYIP_outdata_des_start_address_r  , MYIP_outdata_des_start_address_w   ; 
reg [31:0]  MYIP_inst_src_start_address_r     , MYIP_inst_src_start_address_w      ;  
reg [31:0]  MYIP_data_src_start_address_r     , MYIP_data_src_start_address_w      ; 
reg [31:0]  MYIP_inst_number_r                , MYIP_inst_number_w                 ; 
reg         MYIP_resp_r                       , MYIP_resp_w                        ;
            
wire				MYIP_ack;            
reg				  MYIP_finish_r;
wire        MYIP_finish_w;

output      interrupt;
wire        myip_clk_i;
wire        myip_rst_i;
wire        myip_write_en_i;			
wire        myip_en_read_mem_o; 
wire [31:0] myip_sys_data_in_i;		

wire        myip_rgb_output_ack_i;
wire [19:0] myip_rgb_addr_o;
wire [31:0] myip_rgb_data_o;
wire [31:0] MYIP_output_data_w , MYIP_output_data_w2; 
reg  [31:0] MYIP_output_data_r , MYIP_output_data_r2;
wire        myip_require_o;
wire        myip_rgb_finish_o;

wire				myip_is_busy;
wire				out_require;
wire				in_inst_require;
wire				in_data_require;
///////////////////////////////////////////////////
//=====================Slave=====================//
///////////////////////////////////////////////////


reg  [31:0] S_HaddrReg;                
reg  [ 1:0] S_HtransReg;            
reg         S_HwriteReg;            
reg  [ 2:0] S_HsizeReg;             
reg         S_HselReg;              
reg         S_HREADYinReg;         
reg  [31:0] S_HRDATA;

wire [31:0] S_Haddr_w;             


////////////////////////////////////////////////////
//=====================Master=====================//
////////////////////////////////////////////////////

reg    [31:0] M_HRDATA_r;  
wire   [31:0] M_HRDATA_w;
reg    				M_HBUSREQ;  
reg    				M_HLOCK;    
reg     [1:0] M_HTRANS;   
reg    [31:0] M_HADDR;    
reg           M_HWRITE;   
reg     [2:0] M_HSIZE;    
reg     [2:0] M_HBURST;  
reg    [31:0] M_HWDATA;      
wire		[3:0] M_HPROT = 4'b0001;


//////////////////////////////////////////////////////////////////
//=====================Slave Output Signals=====================//
//////////////////////////////////////////////////////////////////
assign S_Haddr_w = (S_HSELx & S_HREADYin & S_HTRANS[1]) ? S_HADDR : S_HaddrReg;

always@(*)
	begin
		if( S_HselReg == 1'b1 && S_HREADYinReg == 1'b1 && S_HtransReg[1] == 1'b1 && S_HwriteReg == 1'b1)
			begin
    			MYIP_start_w                         = (S_HaddrReg[15:0] == 16'h00) ? S_HWDATA[   0] : MYIP_start_r;  
    			MYIP_outdata_des_start_address_w     = (S_HaddrReg[15:0] == 16'h08) ? S_HWDATA[31:0] : MYIP_outdata_des_start_address_r;    			
    			MYIP_inst_src_start_address_w        = (S_HaddrReg[15:0] == 16'h0C) ? S_HWDATA[31:0] : MYIP_inst_src_start_address_r;
    			MYIP_data_src_start_address_w        = (S_HaddrReg[15:0] == 16'h10) ? S_HWDATA[31:0] : MYIP_data_src_start_address_r; // modified by doli
    			MYIP_inst_number_w                   = (S_HaddrReg[15:0] == 16'h14) ? S_HWDATA[31:0] : MYIP_inst_number_r;
			end
		else
			begin
          MYIP_start_w                         = 1'b0;          
          MYIP_outdata_des_start_address_w     = MYIP_outdata_des_start_address_r;            
          MYIP_inst_src_start_address_w        = MYIP_inst_src_start_address_r;   
          MYIP_data_src_start_address_w        = MYIP_data_src_start_address_r;
    			MYIP_inst_number_w                   = MYIP_inst_number_r;
			end
	end

always@(*)
	begin
		if( S_HselReg == 1'b1 && S_HREADYinReg == 1'b1 && S_HtransReg[1] == 1'b1 && S_HwriteReg == 1'b0)
			begin
				case(S_HaddrReg[15:0])
					16'h00:		S_HRDATA    = {31'd0,MYIP_start_r};
					16'h04:		S_HRDATA    = {28'd0,MYIP_status_r};
					16'h08:		S_HRDATA    = MYIP_outdata_des_start_address_r;
					16'h0C:		S_HRDATA    = MYIP_inst_src_start_address_r;
					16'h10:		S_HRDATA    = MYIP_data_src_start_address_r;
					16'h14:		S_HRDATA    = MYIP_inst_number_r;        
					16'h18:   S_HRDATA    = {31'd0,MYIP_resp_r};
					default:	S_HRDATA    = {16'd0,16'haaaa};
				endcase
			end
		else
			begin
    		S_HRDATA    = {16'd0,16'hbbbb};
			end
	end
	
always@(*)
begin
	case(current_state)
    `MYIP_IDLE           			: MYIP_status_w = `MYIP_STATUS_VALID         ;         
    `MYIP_WAIT           			: MYIP_status_w = `MYIP_STATUS_WAIT          ;
    `MYIP_INST_INPUT_BURST16	: MYIP_status_w = `MYIP_STATUS_INPUT_BURST16 ;
    `MYIP_DATA_INPUT_BURST16	: MYIP_status_w = `MYIP_STATUS_INPUT_BURST16 ;
    `MYIP_OUTPUT_BURST16 			: MYIP_status_w = `MYIP_STATUS_OUTPUT_BURST16;  
    `MYIP_INPUT_BURST16_END  	: MYIP_status_w = `MYIP_STATUS_INPUT_BURST16 ;
    `MYIP_OUTPUT_BURST16_END  : MYIP_status_w = `MYIP_STATUS_OUTPUT_BURST16;    
    default                  	: MYIP_status_w = `MYIP_STATUS_VALID         ;            
  endcase
end

always@(*)
begin
	MYIP_resp_w = (M_HREADY == 1'b0 && M_HRESP != `RSP_OKAY && MYIP_resp_r == 1'b0 && current_state == `MYIP_OUTPUT_BURST16)? 1'b1 : MYIP_resp_r;
end


//detect HRESETn and latch the bus signals
always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    begin
      S_HaddrReg    <= 32'h0000_0000;
      S_HtransReg   <= 2'b00;
      S_HwriteReg   <= 1'b0;
      S_HsizeReg    <= 3'b000;
      S_HselReg     <= 1'b0;
      S_HREADYinReg <= 1'b0;
    end
  else
  begin      
      S_HaddrReg    <= S_Haddr_w;//S_HADDR;
      S_HtransReg   <= S_HTRANS;
      S_HwriteReg   <= S_HWRITE;
      S_HsizeReg    <= S_HSIZE;
      S_HselReg     <= S_HSELx;  
      S_HREADYinReg <= S_HREADYin;        
  end
end              
              
// assign S_HREADYout  =  1'b1;
assign S_HRESP      = `RSP_OKAY;


//////////////////////////////////////////////////
//=============Master Output Signal=============//
//////////////////////////////////////////////////

assign M_HRDATA_w = (M_HREADY == 1'b1 ) ? M_HRDATA : M_HRDATA_r;

           
always@(*)
begin
	case(current_state)
		`MYIP_IDLE:
		begin
			M_HBUSREQ  = 1'b0;      
		  M_HLOCK    = 1'b0;     
		  M_HTRANS   = `TRN_IDLE;	  
			M_HADDR    = 32'd0;	
			M_HWRITE   = 1'b0;					
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_SINGLE; 	
			M_HWDATA   = MYIP_output_data_r2;
		end
		
		`MYIP_WAIT:
		begin        
			M_HBUSREQ  = 1'b1; 
		  M_HLOCK    = 1'b1; 
		  M_HTRANS   = `TRN_IDLE;	
			M_HADDR    = 32'd0;	
			M_HWRITE   = 1'b0;					
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_SINGLE; 			
			M_HWDATA   = MYIP_output_data_r2;
		end
		
		`MYIP_STALL:
		begin        
			M_HBUSREQ  = 1'b0; 
		  M_HLOCK    = 1'b0; 
		  M_HTRANS   = `TRN_IDLE;	
			M_HADDR    = 32'd0;	
			M_HWRITE   = 1'b0;					
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_SINGLE; 			
			M_HWDATA   = MYIP_output_data_r2;
		end
		
    `MYIP_INST_INPUT_BURST16:
		begin
			M_HBUSREQ  = 1'b1;
		  M_HLOCK    = 1'b1;
		  M_HTRANS   = (burst_counter[3:0] == 4'd0)? `TRN_NONSEQ : `TRN_SEQ; 
			M_HADDR    = {ext_inst_input_addr_counter,2'd0} + MYIP_inst_src_start_address_r;
			M_HWRITE   = 1'b0;			  
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_INCR16;
			M_HWDATA   = MYIP_output_data_r2;
		end
		
		`MYIP_DATA_INPUT_BURST16:
		begin
			M_HBUSREQ  = 1'b1;
		  M_HLOCK    = 1'b1;
		  M_HTRANS   = (burst_counter[3:0] == 4'd0)? `TRN_NONSEQ : `TRN_SEQ; 
			M_HADDR    = {myip_rgb_addr_o,2'd0} + {ext_data_input_addr_counter,2'd0} + MYIP_data_src_start_address_r;
			M_HWRITE   = 1'b0;			  
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_INCR8;
			M_HWDATA   = MYIP_output_data_r2;
		end
		
		
    `MYIP_INPUT_BURST16_END:
		begin
			M_HBUSREQ  = 1'b1; 
		  M_HLOCK    = 1'b1; 
		  M_HTRANS   = `TRN_IDLE;	
			M_HADDR    = 32'd0;	
			M_HWRITE   = 1'b0;					
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_SINGLE; 			
			M_HWDATA   = MYIP_output_data_r2;
		end
		
		
		`MYIP_OUTPUT_BURST16:
		begin
			M_HBUSREQ  = 1'b1; 
			M_HLOCK    = 1'b1; 
		  M_HTRANS   = (burst_counter[2:0] == 3'd0)? `TRN_NONSEQ : `TRN_SEQ; 
			M_HADDR    = {myip_rgb_addr_o,2'd0} + {ext_data_output_addr_counter,2'd0} + MYIP_outdata_des_start_address_r;
			M_HWRITE   = 1'b1;			
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_INCR8;   	
			M_HWDATA   = MYIP_output_data_r2;
		end
		
		
    `MYIP_OUTPUT_BURST16_END:
		begin
			M_HBUSREQ  = 1'b1; 
		  M_HLOCK    = 1'b1; 
		  M_HTRANS   = `TRN_NONSEQ;	
			M_HADDR    = {myip_rgb_addr_o,2'd0} + {ext_data_output_addr_counter,2'd0} + MYIP_outdata_des_start_address_r;	
			M_HWRITE   = 1'b0;					
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_SINGLE; 			
			M_HWDATA   = MYIP_output_data_r2;
		end
			
		default:
		begin		
			M_HBUSREQ  = 1'b0;      
		  M_HLOCK    = 1'b0;    
		  M_HTRANS   = `TRN_IDLE;	  
			M_HADDR    = 32'd0;	
			M_HWRITE   = 1'b0;					
			M_HSIZE    = `SZ_WORD;        
			M_HBURST   = `BURST_SINGLE; 	
			M_HWDATA   = MYIP_output_data_r2;
		end
	endcase
end

////////////////////////////////////////////////////////
//========== myip Finite State Machine=============//
////////////////////////////////////////////////////////

always@(*)
begin
  case(current_state)
  	`MYIP_IDLE:
		begin
			burst_counter_acc = 4'd0;
			ext_inst_input_addr_counter_acc = 30'd0;
			ext_data_input_addr_counter_acc = 30'd0;
			ext_data_output_addr_counter_acc = 30'd0;
			
			if(!MYIP_start_r)
				next_state = `MYIP_IDLE;
			else
				next_state = `MYIP_WAIT;			
		end		
		
		`MYIP_STALL: begin
			burst_counter_acc = 4'd0;
			ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
			ext_data_input_addr_counter_acc = ext_data_input_addr_counter;	
			ext_data_output_addr_counter_acc = ext_data_output_addr_counter;
			if (MYIP_start_r==1'b1)
				next_state = `MYIP_WAIT;
			else 
				next_state = `MYIP_STALL;
		end
		
		
		`MYIP_WAIT:
		begin
			burst_counter_acc = 4'd0;
			
			if(M_HREADY == 1'b0 || M_HGRANT == 1'b0) begin
				next_state        = `MYIP_WAIT;			
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
				ext_data_input_addr_counter_acc = ext_data_input_addr_counter;	
				ext_data_output_addr_counter_acc = ext_data_output_addr_counter;	
			end
			else if (interrupt==1'b1) begin
				next_state        = `MYIP_STALL;			
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
				ext_data_input_addr_counter_acc = ext_data_input_addr_counter;	
				ext_data_output_addr_counter_acc = ext_data_output_addr_counter;
			end
			
			else if(MYIP_finish_r == 1'b1) begin
			  next_state        = `MYIP_IDLE;
			  ext_inst_input_addr_counter_acc = 30'd0;
			  ext_data_input_addr_counter_acc = 30'd0;
			  ext_data_output_addr_counter_acc = 30'd0;
			end
			else begin
				if ( out_require==1'b1 )
					next_state = `MYIP_OUTPUT_BURST16;
				else if ( in_inst_require==1'b1 )
					next_state = `MYIP_INST_INPUT_BURST16;		
				else if ( in_data_require==1'b1 )
					next_state = `MYIP_DATA_INPUT_BURST16;
        else 
          next_state        = `MYIP_WAIT;
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
				ext_data_input_addr_counter_acc =( in_data_require==1'b1 ) ? ext_data_input_addr_counter : 30'd0;	
				ext_data_output_addr_counter_acc = ext_data_output_addr_counter;	
			end
		end
		
		`MYIP_INST_INPUT_BURST16:
		begin
			ext_data_input_addr_counter_acc = 30'd0;
			ext_data_output_addr_counter_acc = 30'd0;
			if(M_HREADY == 1'b0 || M_HGRANT == 1'b0) 
			begin
				next_state        = `MYIP_INST_INPUT_BURST16;
				burst_counter_acc = burst_counter;
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;		
			end
			else
			begin
				if(burst_counter != 4'd15)
				begin
					next_state        = `MYIP_INST_INPUT_BURST16;
					burst_counter_acc = burst_counter + 1'b1;
					ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter + 1'b1;
				end
				else
				begin
					next_state        = `MYIP_INPUT_BURST16_END;
					burst_counter_acc = 4'd0;
					ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter + 1'b1;
				end		
			end
		end
		
		`MYIP_DATA_INPUT_BURST16:
		begin
			ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;
			ext_data_output_addr_counter_acc = 30'd0;
			if(M_HREADY == 1'b0 || M_HGRANT == 1'b0) 
			begin
				next_state        = `MYIP_DATA_INPUT_BURST16;
				burst_counter_acc = burst_counter;
				ext_data_input_addr_counter_acc = ext_data_input_addr_counter;
			end
			else
			begin
				if(burst_counter != 4'd7)
				begin
					next_state        = `MYIP_DATA_INPUT_BURST16;
					burst_counter_acc = burst_counter + 1'b1;
					ext_data_input_addr_counter_acc = ext_data_input_addr_counter + 1'b1;
				end
				else
				begin
					next_state        = `MYIP_INPUT_BURST16_END;
					burst_counter_acc = 4'd0;
					ext_data_input_addr_counter_acc = ext_data_input_addr_counter + 1'b1;
				end		
			end
		end
		
		`MYIP_INPUT_BURST16_END:
		begin
			burst_counter_acc = 4'd0;

			if(M_HREADY == 1'b0 || M_HGRANT == 1'b0) 			
			begin
				next_state        = `MYIP_INPUT_BURST16_END;			
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
				ext_data_input_addr_counter_acc = ext_data_input_addr_counter;	
				ext_data_output_addr_counter_acc = 30'd0;	
			end
			else			
			begin
				next_state = `MYIP_WAIT;
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
				ext_data_input_addr_counter_acc = ext_data_input_addr_counter;	
        ext_data_output_addr_counter_acc = 30'd0;
			end
		end
				
		
		`MYIP_OUTPUT_BURST16:
		begin
		
			ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
			ext_data_input_addr_counter_acc = 30'd0;	
			
			if(M_HREADY == 1'b0 || M_HGRANT == 1'b0) 
			begin
				next_state        = `MYIP_OUTPUT_BURST16;
				burst_counter_acc = burst_counter;   
        ext_data_output_addr_counter_acc = ext_data_output_addr_counter;
			end
			else
			begin
			  if(burst_counter != 4'd7)
			  begin
			  	next_state        = `MYIP_OUTPUT_BURST16;			
			  	burst_counter_acc = burst_counter + 1'b1;	
          ext_data_output_addr_counter_acc = ext_data_output_addr_counter + 1'b1;
			  end
			  else
			  begin
			  	next_state        = `MYIP_OUTPUT_BURST16_END;
			  	burst_counter_acc = 4'd0;
          ext_data_output_addr_counter_acc = ext_data_output_addr_counter + 1'b1;
			  end		
			end		
		end
				
		
		`MYIP_OUTPUT_BURST16_END:
		begin
			burst_counter_acc = 4'd0;

			if(M_HREADY == 1'b0 || M_HGRANT == 1'b0) 			
			begin
				next_state        = `MYIP_OUTPUT_BURST16_END;			
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
				ext_data_input_addr_counter_acc = 30'd0;	
        ext_data_output_addr_counter_acc = ext_data_output_addr_counter;
			end
			else			
			begin
				next_state = `MYIP_WAIT;
				ext_inst_input_addr_counter_acc = ext_inst_input_addr_counter;	
				ext_data_input_addr_counter_acc = 30'd0;	
        ext_data_output_addr_counter_acc = ext_data_output_addr_counter;
			end
		end		
		
		default:
		begin
			burst_counter_acc = 4'd0;
			ext_inst_input_addr_counter_acc = 30'd0;	
			ext_data_input_addr_counter_acc = 30'd0;	
			ext_data_output_addr_counter_acc = 30'd0;
			if(!MYIP_start_r)
				next_state = `MYIP_IDLE;
			else
				next_state = `MYIP_WAIT;			
		end		
	endcase
end

assign MYIP_finish_w = (MYIP_start_r == 1'b1)? 1'b0 : ((myip_rgb_finish_o == 1'b1 )? 1'b1 : MYIP_finish_r);
assign current_state_d1_w = (M_HREADY == 1'b1 && M_HGRANT == 1'b1) ? current_state : current_state_d1_r;

assign MYIP_output_data_w = myip_rgb_data_o;
assign MYIP_output_data_w2 = MYIP_output_data_r;

///////////////////////////////////////////
//==========Sequencial Block=============//
///////////////////////////////////////////

always@(posedge HCLK or negedge HRESETn)
begin
	if(!HRESETn)
	begin
		current_state                          <= `MYIP_IDLE;
		burst_counter                          <= 4'd0;
		// ext_input_addr_counter                 <= 30'd0;
		ext_inst_input_addr_counter            <= 30'd0;
		ext_data_input_addr_counter            <= 30'd0;
		ext_data_output_addr_counter            <= 30'd0;
		
		current_state_d1_r                     <= 4'd0;
		                              
		MYIP_start_r                           <= 1'b0;                       
    MYIP_status_r                          <= `MYIP_STATUS_VALID;	                    
    MYIP_outdata_des_start_address_r       <= 32'd0;  
    MYIP_inst_src_start_address_r          <= 32'd0;  
    MYIP_data_src_start_address_r          <= 32'd0;  
    MYIP_inst_number_r                     <= 32'd0; 
		MYIP_finish_r											     <= 1'b0;   
		MYIP_resp_r                            <= 1'b0;
                                  
    M_HRDATA_r                             <= 32'd0;    
		
		S_HREADYout                            <= 1'b0;
    
    MYIP_output_data_r                     <= 32'd0;
    MYIP_output_data_r2                    <= 32'd0;
   
   
	end
	else
	begin
		current_state                          <= next_state;
		burst_counter                          <= burst_counter_acc;
		// ext_input_addr_counter                 <= ext_input_addr_counter_acc;
		ext_inst_input_addr_counter            <= ext_inst_input_addr_counter_acc;
		ext_data_input_addr_counter            <= ext_data_input_addr_counter_acc;
		ext_data_output_addr_counter           <= ext_data_output_addr_counter_acc;
		
		current_state_d1_r                     <= current_state_d1_w;
		                                       
		MYIP_start_r                           <= MYIP_start_w;  
	  MYIP_status_r                          <= MYIP_status_w;	                       
	  MYIP_outdata_des_start_address_r       <= MYIP_outdata_des_start_address_w;  
	  MYIP_inst_src_start_address_r          <= MYIP_inst_src_start_address_w; 
	  MYIP_data_src_start_address_r          <= MYIP_data_src_start_address_w;         
		MYIP_inst_number_r                         <= MYIP_inst_number_w;                                                   
		MYIP_finish_r											     <= MYIP_finish_w;
		MYIP_resp_r                            <= MYIP_resp_w;
		                              
		M_HRDATA_r                             <= M_HRDATA_w;   
    
		S_HREADYout                            <= 1'b1;
    
    MYIP_output_data_r                     <= MYIP_output_data_w;
    // MYIP_output_data_r2                     <= MYIP_output_data_w2;
		if (M_HREADY)
			MYIP_output_data_r2                    <= myip_rgb_data_o;
    
	end
end


/////////////////////////////////////////////
//============IDCT IP==============//
/////////////////////////////////////////////



assign myip_clk_i            = HCLK;
assign myip_rst_i            = HRESETn;
assign myip_write_en_i       = ( ( current_state_d1_r == `MYIP_INST_INPUT_BURST16 || current_state_d1_r == `MYIP_DATA_INPUT_BURST16 ) && M_HREADY == 1'b1 && M_HGRANT == 1'b1)? 1'b1 : 1'b0;
assign myip_sys_data_in_i    = M_HRDATA;
assign myip_rgb_output_ack_i = (current_state == `MYIP_OUTPUT_BURST16 && M_HREADY == 1'b1 && M_HGRANT == 1'b1)? 1'b1 : 1'b0;

assign MYIP_ack = (myip_write_en_i | myip_rgb_output_ack_i);

Hydra_controller u_myip_top(
        .clk								(myip_clk_i) ,
        .rst_n  						(myip_rst_i) ,
        .start_i						(MYIP_start_r),            	//Input   1-bits
        .ack_i							(MYIP_ack),    		        	//Input   1-bits
        .data_in_i					(myip_sys_data_in_i),       //Input  32-bits  2-pixels

        .in_inst_require_o	(in_inst_require),       		//Output  1-bits
        .in_data_require_o	(in_data_require),       		//Output  1-bits
        .out_require_o			(out_require),      				//Output  1-bits
        .data_o					    (myip_rgb_data_o),         	//Output 32-bits
        .addr_o					    (myip_rgb_addr_o),
        .finish_o						(myip_rgb_finish_o),
				.interrupt_o        (interrupt),
        .Mem_dft_mode				(Mem_dft_mode),
				.Mem_wen						(Mem_wen_hydra)
        );

endmodule              
