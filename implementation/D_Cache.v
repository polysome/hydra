//
//      CONFIDENTIAL  AND  PROPRIETARY SOFTWARE OF ARM Physical IP, INC.
//      
//      Copyright (c) 1993-2013  ARM Physical IP, Inc.  All  Rights Reserved.
//      
//      Use of this Software is subject to the terms and conditions  of the
//      applicable license agreement with ARM Physical IP, Inc.  In addition,
//      this Software is protected by patents, copyright law and international
//      treaties.
//      
//      The copyright notice(s) in this Software does not indicate actual or
//      intended publication of this Software.
//      
//      name:			Advantage Single-Port Register File Generator
//           			TSMC 90nm CLN90G Process
//      version:		2007Q2V1
//      comment:		
//      configuration:	 -instname "D_Cache" -words 32 -bits 128 -frequency 100 -ring_width 2.0 -mux 1 -write_mask off -wp_size 8 -top_layer "met5-9" -power_type rings -horiz met3 -vert met2 -redundancy off -rcols 1 -rrows 0 -bmux off -ema on -cust_comment "" -bus_notation on -left_bus_delim "[" -right_bus_delim "]" -pwr_gnd_rename "VDD:VDD,VSS:VSS" -prefix "" -pin_space 0.0 -name_case upper -check_instname on -diodes on -inside_ring_type VSS -drive 4 -asvm off -corners ff_1.1_-40.0,ff_1.1_125.0,tt_1.0_25.0,ss_0.9_125.0
//
//      Verilog model for Synchronous Single-Port Register File
//
//      Instance Name:              D_Cache
//      Words:                      32
//      Bits:                       128
//      Mux:                        1
//      Drive:                      4
//      Write Mask:                 Off
//      Extra Margin Adjustment:    On
//      Accelerated Retention Test: Off
//      Redundant Rows:             0
//      Redundant Columns:          0
//      Test Muxes                  Off
//
//      Creation Date:  2013-03-11 09:15:27Z
//      Version: 	2007Q2V1
//
//      Modeling Assumptions: This model supports full gate level simulation
//          including proper x-handling and timing check behavior.  Unit
//          delay timing is included in the model. Back-annotation of SDF
//          (v2.1) is supported.  SDF can be created utilyzing the delay
//          calculation views provided with this generator and supported
//          delay calculators.  All buses are modeled [MSB:LSB].  All 
//          ports are padded with Verilog primitives.
//
//      Modeling Limitations: None.
//
//      Known Bugs: None.
//
//      Known Work Arounds: N/A
//
`timescale 1 ns/1 ps
`celldefine
  module D_Cache (
                Q,
                CLK,
                CEN,
                WEN,
                A,
                D,
                EMA
                );
   parameter                BITS = 128;
   parameter                WORD_DEPTH = 32;
   parameter                ADDR_WIDTH = 5;
   parameter                WORDX = {BITS{1'bx}};
   parameter                WORD1 = {BITS{1'b1}};
   parameter                ADDRX = {ADDR_WIDTH{1'bx}};
   parameter                ADDR1 = {ADDR_WIDTH{1'b1}};
   parameter                WEN_WIDTH = 1;
   parameter                WP_SIZE    = 128 ;
   parameter                RCOLS = 0;
   parameter                MASKX = {WEN_WIDTH{1'bx}};
   parameter                MASK1 = {WEN_WIDTH{1'b1}};
   parameter                MASK0 = {WEN_WIDTH{1'b0}};
   parameter                MUX = 1;
   parameter                COL_ADDR_WIDTH = 0;
   parameter                RROWS = 0;
   parameter                UPM_WIDTH = 3;
   parameter                UPM0 = {UPM_WIDTH{1'b0}};
   parameter                RCA_WIDTH = 1;
   parameter                RED_COLUMNS = 1;
	
   output [127:0]           Q;
   input                    CLK;
   input                    CEN;
   input                    WEN;
   input [4:0]              A;
   input [127:0]            D;
   input [2:0]              EMA;

   reg [BITS+RED_COLUMNS-1:0]             mem [0:WORD_DEPTH-1];
   reg [BITS+RED_COLUMNS-1:0]             rows [(MUX*4)-1:0];   // added 2 bits for column redundancy


   reg                      NOT_CEN;
   reg                      NOT_WEN;
   reg                      NOT_A4;
   reg                      NOT_A3;
   reg                      NOT_A2;
   reg                      NOT_A1;
   reg                      NOT_A0;
   reg [ADDR_WIDTH-1:0]     NOT_A;
   reg                      NOT_D127;
   reg                      NOT_D126;
   reg                      NOT_D125;
   reg                      NOT_D124;
   reg                      NOT_D123;
   reg                      NOT_D122;
   reg                      NOT_D121;
   reg                      NOT_D120;
   reg                      NOT_D119;
   reg                      NOT_D118;
   reg                      NOT_D117;
   reg                      NOT_D116;
   reg                      NOT_D115;
   reg                      NOT_D114;
   reg                      NOT_D113;
   reg                      NOT_D112;
   reg                      NOT_D111;
   reg                      NOT_D110;
   reg                      NOT_D109;
   reg                      NOT_D108;
   reg                      NOT_D107;
   reg                      NOT_D106;
   reg                      NOT_D105;
   reg                      NOT_D104;
   reg                      NOT_D103;
   reg                      NOT_D102;
   reg                      NOT_D101;
   reg                      NOT_D100;
   reg                      NOT_D99;
   reg                      NOT_D98;
   reg                      NOT_D97;
   reg                      NOT_D96;
   reg                      NOT_D95;
   reg                      NOT_D94;
   reg                      NOT_D93;
   reg                      NOT_D92;
   reg                      NOT_D91;
   reg                      NOT_D90;
   reg                      NOT_D89;
   reg                      NOT_D88;
   reg                      NOT_D87;
   reg                      NOT_D86;
   reg                      NOT_D85;
   reg                      NOT_D84;
   reg                      NOT_D83;
   reg                      NOT_D82;
   reg                      NOT_D81;
   reg                      NOT_D80;
   reg                      NOT_D79;
   reg                      NOT_D78;
   reg                      NOT_D77;
   reg                      NOT_D76;
   reg                      NOT_D75;
   reg                      NOT_D74;
   reg                      NOT_D73;
   reg                      NOT_D72;
   reg                      NOT_D71;
   reg                      NOT_D70;
   reg                      NOT_D69;
   reg                      NOT_D68;
   reg                      NOT_D67;
   reg                      NOT_D66;
   reg                      NOT_D65;
   reg                      NOT_D64;
   reg                      NOT_D63;
   reg                      NOT_D62;
   reg                      NOT_D61;
   reg                      NOT_D60;
   reg                      NOT_D59;
   reg                      NOT_D58;
   reg                      NOT_D57;
   reg                      NOT_D56;
   reg                      NOT_D55;
   reg                      NOT_D54;
   reg                      NOT_D53;
   reg                      NOT_D52;
   reg                      NOT_D51;
   reg                      NOT_D50;
   reg                      NOT_D49;
   reg                      NOT_D48;
   reg                      NOT_D47;
   reg                      NOT_D46;
   reg                      NOT_D45;
   reg                      NOT_D44;
   reg                      NOT_D43;
   reg                      NOT_D42;
   reg                      NOT_D41;
   reg                      NOT_D40;
   reg                      NOT_D39;
   reg                      NOT_D38;
   reg                      NOT_D37;
   reg                      NOT_D36;
   reg                      NOT_D35;
   reg                      NOT_D34;
   reg                      NOT_D33;
   reg                      NOT_D32;
   reg                      NOT_D31;
   reg                      NOT_D30;
   reg                      NOT_D29;
   reg                      NOT_D28;
   reg                      NOT_D27;
   reg                      NOT_D26;
   reg                      NOT_D25;
   reg                      NOT_D24;
   reg                      NOT_D23;
   reg                      NOT_D22;
   reg                      NOT_D21;
   reg                      NOT_D20;
   reg                      NOT_D19;
   reg                      NOT_D18;
   reg                      NOT_D17;
   reg                      NOT_D16;
   reg                      NOT_D15;
   reg                      NOT_D14;
   reg                      NOT_D13;
   reg                      NOT_D12;
   reg                      NOT_D11;
   reg                      NOT_D10;
   reg                      NOT_D9;
   reg                      NOT_D8;
   reg                      NOT_D7;
   reg                      NOT_D6;
   reg                      NOT_D5;
   reg                      NOT_D4;
   reg                      NOT_D3;
   reg                      NOT_D2;
   reg                      NOT_D1;
   reg                      NOT_D0;
   reg [BITS-1:0]           NOT_D;
   reg                      NOT_EMA2;
   reg                      NOT_EMA1;
   reg                      NOT_EMA0;
   reg [UPM_WIDTH-1:0]      NOT_EMA;

   reg                      NOT_CLK_PER;
   reg                      NOT_CLK_MINH;
   reg                      NOT_CLK_MINL;

   reg                      LAST_NOT_CEN;
   reg                      LAST_NOT_WEN;
   reg [ADDR_WIDTH-1:0]     LAST_NOT_A;
   reg [BITS-1:0]           LAST_NOT_D;
   reg [UPM_WIDTH-1:0]      LAST_NOT_EMA;

   reg                      LAST_NOT_CLK_PER;
   reg                      LAST_NOT_CLK_MINH;
   reg                      LAST_NOT_CLK_MINL;
   wire [BITS-1:0]          _Q;
   wire                     _CLK;
   wire                     _CEN;
   wire                     _WEN;
   wire [ADDR_WIDTH-1:0]    _A;
   wire [BITS-1:0]          _D;
   wire [UPM_WIDTH-1:0]     _EMA;

   wire                     CEN_flag;
   wire                     TCEN_flag;
   wire                     flag;
   wire                     D_flag;
   wire                     cyc_flag;
   wire                     EMA2eq0andEMA1eq0andEMA0eq0;
   wire                     EMA2eq0andEMA1eq0andEMA0eq1;
   wire                     EMA2eq0andEMA1eq1andEMA0eq0;
   wire                     EMA2eq0andEMA1eq1andEMA0eq1;
   wire                     EMA2eq1andEMA1eq0andEMA0eq0;
   wire                     EMA2eq1andEMA1eq0andEMA0eq1;
   wire                     EMA2eq1andEMA1eq1andEMA0eq0;
   wire                     EMA2eq1andEMA1eq1andEMA0eq1;

   reg                      LATCHED_CEN;
   reg                      LATCHED_WEN;
   reg [ADDR_WIDTH-1:0]     LATCHED_A;
   reg [BITS-1:0]           LATCHED_D;
   reg [UPM_WIDTH-1:0]      LATCHED_EMA;

   reg [BITS-1:0]           Qi;
   reg [BITS-1:0]           LAST_Qi;

   reg [BITS-1:0]           dummy_qb;

   reg                      LAST_CLK;

   reg [BITS+RED_COLUMNS-1:0]           last_status [(MUX*2)-1:0];


   task update_notifier_buses;
   begin
      NOT_A = {
               NOT_A4,
               NOT_A3,
               NOT_A2,
               NOT_A1,
               NOT_A0};
      NOT_D = {
               NOT_D127,
               NOT_D126,
               NOT_D125,
               NOT_D124,
               NOT_D123,
               NOT_D122,
               NOT_D121,
               NOT_D120,
               NOT_D119,
               NOT_D118,
               NOT_D117,
               NOT_D116,
               NOT_D115,
               NOT_D114,
               NOT_D113,
               NOT_D112,
               NOT_D111,
               NOT_D110,
               NOT_D109,
               NOT_D108,
               NOT_D107,
               NOT_D106,
               NOT_D105,
               NOT_D104,
               NOT_D103,
               NOT_D102,
               NOT_D101,
               NOT_D100,
               NOT_D99,
               NOT_D98,
               NOT_D97,
               NOT_D96,
               NOT_D95,
               NOT_D94,
               NOT_D93,
               NOT_D92,
               NOT_D91,
               NOT_D90,
               NOT_D89,
               NOT_D88,
               NOT_D87,
               NOT_D86,
               NOT_D85,
               NOT_D84,
               NOT_D83,
               NOT_D82,
               NOT_D81,
               NOT_D80,
               NOT_D79,
               NOT_D78,
               NOT_D77,
               NOT_D76,
               NOT_D75,
               NOT_D74,
               NOT_D73,
               NOT_D72,
               NOT_D71,
               NOT_D70,
               NOT_D69,
               NOT_D68,
               NOT_D67,
               NOT_D66,
               NOT_D65,
               NOT_D64,
               NOT_D63,
               NOT_D62,
               NOT_D61,
               NOT_D60,
               NOT_D59,
               NOT_D58,
               NOT_D57,
               NOT_D56,
               NOT_D55,
               NOT_D54,
               NOT_D53,
               NOT_D52,
               NOT_D51,
               NOT_D50,
               NOT_D49,
               NOT_D48,
               NOT_D47,
               NOT_D46,
               NOT_D45,
               NOT_D44,
               NOT_D43,
               NOT_D42,
               NOT_D41,
               NOT_D40,
               NOT_D39,
               NOT_D38,
               NOT_D37,
               NOT_D36,
               NOT_D35,
               NOT_D34,
               NOT_D33,
               NOT_D32,
               NOT_D31,
               NOT_D30,
               NOT_D29,
               NOT_D28,
               NOT_D27,
               NOT_D26,
               NOT_D25,
               NOT_D24,
               NOT_D23,
               NOT_D22,
               NOT_D21,
               NOT_D20,
               NOT_D19,
               NOT_D18,
               NOT_D17,
               NOT_D16,
               NOT_D15,
               NOT_D14,
               NOT_D13,
               NOT_D12,
               NOT_D11,
               NOT_D10,
               NOT_D9,
               NOT_D8,
               NOT_D7,
               NOT_D6,
               NOT_D5,
               NOT_D4,
               NOT_D3,
               NOT_D2,
               NOT_D1,
               NOT_D0};
      NOT_EMA = {
               NOT_EMA2,
               NOT_EMA1,
               NOT_EMA0};
   end
   endtask


   task mem_cycle;
      inout [BITS-1:0] 	            q;
      inout [BITS-1:0] 	            other_q;
      input 			    cen;
      input [WEN_WIDTH-1:0] 	    wen;
      input [ADDR_WIDTH-1:0]        a;
      input [BITS-1:0]              d;
      input [UPM_WIDTH-1:0]         ema;
      input                         artn;
      input                         ten;
      input                         ben;
      input                         tcen;
      input [WEN_WIDTH-1:0]         twen;
      input [ADDR_WIDTH-1:0]        ta;
      input [BITS-1:0]              td;
      input                         rren;
      input                         rra;
      input [BITS-1:0]              cren;
      input [RCA_WIDTH-1:0]         rca;
      input                         contention_flag;
      input [BITS-1:0]              other_cren;
      input                         port;  // 0 for A port, 1 for B port
      
      integer 		    mask_section ;
      integer 		    lsb ;
      integer 		    msb ;
      reg 		    CENi;
      reg [WEN_WIDTH-1:0]   WENi;
      reg [ADDR_WIDTH-1:0]  Ai;
      reg [BITS-1:0] 	    Di;
      reg 		    ValidDummyPinsi;

      begin
	 CENi = ten ? cen : tcen;
	 Ai = ten ? a : ta;
	 WENi = ten ? wen : twen;
	 Di = ten ? d : td;
	 ValidDummyPinsi = (^({ema,artn}) !== 1'bx);
	 
	 if ( (artn !== 1'b1) & (WENi !== MASK1) & (WENi !== MASK0))
           begin
              $display("ARTN is active and all bits of WEN are not active or inactive");
              $display("Setting WEN bus to x");
	      WENi = MASKX;
	   end
	 if (!valid_cren(cren))
	   begin
              $display("CREN is in an invalid state");
              $display("Setting CREN bus to x");
	      cren = WORDX;
	   end

	 for (mask_section=0;mask_section<WEN_WIDTH; mask_section=mask_section+1)
	 begin
	    lsb = (mask_section)*(WP_SIZE) ;
	    msb = BITS <= (lsb+WP_SIZE-1) ? (BITS-1) : (lsb+WP_SIZE-1) ;
	    casez({WENi[mask_section],CENi,ValidDummyPinsi})
	      3'b101: begin
		 read_mem(q,other_q,Ai,Di,rren,rra,cren,1'b0,
                          msb,lsb,0,contention_flag,port);
	      end
	      3'b001: begin
		 write_mem(other_q,Ai,Di,rren,rra,cren,1'b0,
                           msb,lsb,0,contention_flag,other_cren,port);
		 write_thru(q,Ai,Di,rren,rra,cren,1'b0,
                            msb,lsb,0);
	      end
	      3'b?1?: ;
              3'b10?,
	      3'b1x?: begin
		 read_mem(q,other_q,Ai,Di,rren,rra,cren,1'b0,
                          msb,lsb,1,contention_flag,port);
	      end
              3'b00?,
	      3'b0x?: begin
		 write_mem(other_q,Ai,Di,rren,rra,cren,1'b0,
                           msb,lsb,1,contention_flag,other_cren,port);
		 write_thru(q,Ai,Di,rren,rra,cren,1'b0,
                            msb,lsb,1);
	      end
              3'bx0?,
	      3'bxx?: begin
		 write_mem(other_q,Ai,Di,rren,rra,cren,1'b0,
                           msb,lsb,1,contention_flag,other_cren,port);
		 read_mem(q,other_q,Ai,Di,rren,rra,cren,1'b0,
                          msb,lsb,1,contention_flag,port);
	      end
	    endcase 
	 end
      end
   endtask

   task read_mem;
      inout [BITS-1:0] q;
      inout [BITS-1:0] other_q;
      input [ADDR_WIDTH-1:0] a;
      input [BITS-1:0] d;
      input rren;
      input radd;
      input [BITS-1:0] cren;
      input [RCA_WIDTH-1:0] rca;
      input msb;
      input lsb;
      input xout;
      input contention;
      input port;
      integer msb;
      integer lsb;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [BITS+RED_COLUMNS-1:0] other_status;
      reg [BITS+RED_COLUMNS-1:0] status;
      integer m;
      integer n;
      begin
	 if (rren === 1'bx)
	   begin
	      for (n=lsb; n<=msb; n=n+1) q[n] = 1'bx ;
              x_mem;
              x_rows;
	   end
	 else
	   begin
	      if (!valid_address(a,rren,radd))
		begin
		   for (n=lsb; n<=msb; n=n+1) q[n] = 1'bx ;
		   if (rren === 1'b1)
		     begin
			x_mem;
		     end
		   else if (rren === 1'b0)
		     begin
                        casez({radd,1'b0})
                           2'bxx: x_rows;
                           2'bx?: begin
                                    x_row(0,1'b0);
                                    x_row(1,1'b0);
                                  end
                           2'b?x: begin
                                    x_row(radd,0);
                                    x_row(radd,1);
                                  end
                           default:
			          x_row(radd,1'b0);
                        endcase
		     end
		end
	      else
		begin
		   if (rren === 1'b1)
		     tmpdata = mem[a];
		   else if (rren === 1'b0)
		     tmpdata = rows[{1'b0,radd}];
		   status = last_status[port];
		   other_status = last_status[!port];
		   for (n=lsb; n<=msb; n=n+1)
		   begin
		      if (cren[n] === 1'b1)
			begin
			   if ((other_status[n] === 1'b0) & contention)
			     begin
				tmpdata[n] = 1'bx;
				q[n] = 1'bx;
			     end
			   else
			     begin
				q[n] = xout ? 1'bx : tmpdata[n];
				status[n] = 1'b1;
			     end
			end
		      else if (cren[n] === 1'b0)
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
				if ((other_status[n+rca+1] === 1'b0) & contention)
				  begin
				     tmpdata[n+rca+1] = 1'bx;
			             q[n] = 1'bx;
				  end
				else
				  begin
			             q[n] = xout ? 1'bx : tmpdata[n+rca+1];
				     status[n+rca+1] = 1'b1;
				  end
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
                             begin
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
				   if ((other_status[n+m+1] === 1'b0) & contention)
				     tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b1;
				end
			        q[n] = 1'bx;
                             end
                           else
                             begin
				if ((other_status[n+1] === 1'b0) & contention)
				  begin
				     tmpdata[n+1] = 1'bx;
			             q[n] = 1'bx;
				  end
				else
				  begin
			             q[n] = xout ? 1'bx : tmpdata[n+1];
				     status[n+1] = 1'b1;
				  end
                             end
			end
		      else
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
				if ((other_status[n] === 1'b0) & contention)
				  tmpdata[n] = 1'bx;
				if ((other_status[n+rca+1] === 1'b0) & contention)
				  tmpdata[n+rca+1] = 1'bx;
				status[n] = 1'b1;
				status[n+rca+1] = 1'b1;
				q[n] = 1'bx;
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
			     begin
				if ((other_status[n] === 1'b0) & contention)
				  tmpdata[n] = 1'bx;
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
				   if ((other_status[n+m+1] === 1'b0) & contention)
				     tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b1;
				end
				status[n] = 1'b1;
				q[n] = 1'bx;
			     end 
			   else
			     begin
				if ((other_status[n] === 1'b0) & contention)
				  tmpdata[n] = 1'bx;
				if ((other_status[n+1] === 1'b0) & contention)
				  tmpdata[n+1] = 1'bx;
				q[n] = 1'bx;
				status[n] = 1'b1;
				status[n+1] = 1'b1;
			     end
			end
		   end
		   if (rren === 1'b1)
		     mem[a] = tmpdata;
		   else if (rren === 1'b0)
		     rows[{1'b0,radd}] = tmpdata;
		   last_status[port] = status;
		   if (msb == BITS-1)
		     begin
			if (rren === 1'b1)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_mem(a,BITS+m,tmpdata[BITS+m]);
                             end
                          end
			else if (rren === 1'b0)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_rows(a,BITS+m,tmpdata[BITS+m],radd,1'b0);
                             end
                          end
			update_status(status,port);
		     end
		end
	   end
      end	      
   endtask

   task write_mem;
      inout [BITS-1:0] other_q;
      input [ADDR_WIDTH-1:0] a;
      input [BITS-1:0] d;
      input rren;
      input radd;
      input [BITS-1:0] cren;
      input [RCA_WIDTH-1:0] rca;
      input msb;
      input lsb;
      input xout;
      input contention;
      input [BITS-1:0] other_cren;
      input port;
      integer msb;
      integer lsb;
      integer m;
      integer n;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [BITS+RED_COLUMNS-1:0] other_status;
      reg [BITS+RED_COLUMNS-1:0] status;
      reg [ADDR_WIDTH-1:0] tmpaddr;
      begin
	 if (rren === 1'bx)
	   begin
	      x_mem;
	      x_rows;
	   end
	 else
	   begin
	      if (!valid_address(a,rren,radd))
		begin
		   if (rren === 1'b1)
		     begin
			x_mem;
		     end
		   else if (rren === 1'b0)
		     begin
                        casez({radd,1'b0})
                           2'bxx: x_rows;
                           2'bx?: begin
                                    x_row(0,1'b0);
                                    x_row(1,1'b0);
                                  end
                           2'b?x: begin
                                    x_row(radd,0);
                                    x_row(radd,1);
                                  end
                           default:
			          x_row(radd,1'b0);
                        endcase
		     end
		end
	      else
		begin
		   if (rren === 1'b1)
		     tmpdata = mem[a];
		   else if (rren === 1'b0)
		     tmpdata = rows[{1'b0,radd}];
		   status = last_status[port];
		   other_status = last_status[!port];
		   for (n=lsb; n<=msb; n=n+1)
		   begin
		      if (cren[n] === 1'b1)
			begin
			   if ((other_status[n] === 1'b0) & contention)
			     tmpdata[n] = 1'bx;
			   else if ((other_status[n] === 1'b1) & contention)
			     begin
				tmpdata[n] = 1'bx;
				if (other_cren[n] === 1'b1)
				  other_q[n] = 1'bx;
				else if (other_cren[n-1] === 1'b0)
				  other_q[n-1] = 1'bx;
			     end
			   else
			     begin
				tmpdata[n] = xout ? 1'bx : d[n];
				status[n] = 1'b0;
			     end
			   if ((n < BITS-1) & (cren[n+1] === 1'b0))
                             begin
				if ((other_status[n+1] === 1'b0) & contention)
				  tmpdata[n+1] = 1'bx;
				else if ((other_status[n+1] === 1'b1) & contention)
				  begin
				     tmpdata[n+1] = 1'bx;
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				     else if (other_cren[n+1] === 1'b1)
				       other_q[n+1] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[n+1] = xout ? 1'bx : d[n];
				     status[n+1] = 1'b0;
				  end
                             end
			   else if ((n < BITS-1) & (cren[n+1] === 1'bx))
                             begin
                                tmpdata[n+1] = 1'bx;
				status[n+1] = 1'b0;
				if ((other_status[n+1] === 1'b1) & contention)
				  if (other_cren[n] === 1'b0)
				    other_q[n] = 1'bx;
				  else if (other_cren[n+1] === 1'b1)
				    other_q[n+1] = 1'bx;
                             end
			end
		      else if (cren[n] === 1'b0)
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
				if ((other_status[n+rca+1] === 1'b0) & contention)
				  tmpdata[n+rca+1] = 1'bx;
				else if ((other_status[n+rca+1] === 1'b1) & contention)
				  begin
				     tmpdata[n+rca+1] = 1'bx;
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[n+rca+1] = xout ? 1'bx : d[n];
				     status[n+rca+1] = 1'b0;
				  end
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
                             begin
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
                                   tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b0;
				   if ((other_status[n+m+1] === 1'b1) & contention)
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				end
                             end
                           else
                             begin
				if ((other_status[n+1] === 1'b0) & contention)
				  tmpdata[n+1] = 1'bx;
				else if ((other_status[n+1] === 1'b1) & contention)
				  begin
				     tmpdata[n+1] = 1'bx;
				     if (other_cren[n] === 1'b0)
				       other_q[n] = 1'bx;
				     else if (other_cren[n+1] === 1'b1)
				       other_q[n+1] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[n+1] = xout ? 1'bx : d[n];
				     status[n+1] = 1'b0;
				  end
                             end
			   if (n === 0)
                             begin
				if ((other_status[0] === 1'b0) & contention)
				  tmpdata[0] = 1'bx;
				else if ((other_status[0] === 1'b1) & contention)
				  begin
				     tmpdata[0] = 1'bx;
				     if (other_cren[0] === 1'b1)
				       other_q[0] = 1'bx;
				  end
				else
				  begin
                                     tmpdata[0] = xout ? 1'bx : 1'b0;
				     status[0] = 1'b0;
				  end
			     end
		        end
		      else
			begin
                           if ((n == BITS-1) & (^(rca) !== 1'bx))
                             begin
                                tmpdata[n] = 1'bx;
                                tmpdata[n+rca+1] = 1'bx;
				status[n] = 1'b0;
				status[n+rca+1] = 1'b0;
				if ((other_status[n] === 1'b1) & contention)
				  if (other_cren[n] === 1'b1)
				    other_q[n] = 1'bx;
				  else if (other_cren[n-1] === 1'b0)
				    other_q[n-1] = 1'bx;
				if ((other_status[n+rca+1] === 1'b1) & contention)
				  other_q[n] = 1'bx;
                             end
                           else if ((n == BITS-1) & (^(rca) === 1'bx))
                             begin
                                tmpdata[n] = 1'bx;
				status[n] = 1'b0;
				for (m=0; m<RED_COLUMNS; m=m+1)
				begin
                                   tmpdata[n+m+1] = 1'bx;
				   status[n+m+1] = 1'b0;
                                   if ((other_status[n+m+1] === 1'b1) & contention)
				     other_q[n] = 1'bx;
				end
				if ((other_status[n] === 1'b1) & contention)
				  if (other_cren[n] === 1'b1)
				    other_q[n] = 1'bx;
				  else if (other_cren[n-1] === 1'b0)
				    other_q[n-1] = 1'bx;
                             end
                           else
                             begin
                                tmpdata[n] = 1'bx;
                                tmpdata[n+1] = 1'bx;
				status[n] = 1'b0;
				status[n+1] = 1'b0;
				if ((other_status[n] === 1'b1) & contention)
				  if (other_cren[n] === 1'b1)
				    other_q[n] = 1'bx;
				  else if (other_cren[n-1] === 1'b0)
				    other_q[n-1] = 1'bx;
				if ((other_status[n+1] === 1'b1) & contention)
				  if (other_cren[n+1] === 1'b1)
				    other_q[n+1] = 1'bx;
				  else if (other_cren[n] === 1'b0)
				    other_q[n] = 1'bx;
                             end
			end
		   end
		   if (rren === 1'b1)
		     mem[a]=tmpdata;
		   else if (rren === 1'b0)
		     rows[{1'b0,radd}] = tmpdata;
		   last_status[port] = status;
		   // copy the redundent columns to all all combinations of ymux addresses
		   if (msb == BITS-1)
		     begin
			if (rren === 1'b1)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_mem(a,BITS+m,tmpdata[BITS+m]);
                             end
                          end
			else if (rren === 1'b0)
                          begin
			     for (m=0; m<RED_COLUMNS; m=m+1)
			     begin
				replace_bit_in_rows(a,BITS+m,tmpdata[BITS+m],radd,1'b0);
                             end
                          end
			update_status(status,port);
		     end		     
		end
	   end
      end
   endtask

   task write_thru;
      inout [BITS-1:0] q;
      input [ADDR_WIDTH-1:0] a;
      input [BITS-1:0] d;
      input rren;
      input radd;
      input [BITS-1:0] cren;
      input [RCA_WIDTH-1:0] rca;
      input msb;
      input lsb;
      input xout;
      integer msb;
      integer lsb;
      integer n;
      begin
         if (^cren !== 1'bx)
	   for (n=lsb;n<=msb;n=n+1) q[n] = xout ? 1'bx : d[n] ;
         else
	   for (n=lsb;n<=msb;n=n+1) q[n] = 1'bx ;
      end
   endtask

   task update_last_notifiers;
   begin
      LAST_NOT_CEN = NOT_CEN;
      LAST_NOT_WEN = NOT_WEN;
      LAST_NOT_A = NOT_A;
      LAST_NOT_D = NOT_D;
      LAST_NOT_EMA = NOT_EMA;
      LAST_NOT_CLK_PER = NOT_CLK_PER;
      LAST_NOT_CLK_MINH = NOT_CLK_MINH;
      LAST_NOT_CLK_MINL = NOT_CLK_MINL;
   end
   endtask

   task latch_inputs;
   begin
      LATCHED_CEN = _CEN;
      LATCHED_WEN = _WEN;
      LATCHED_A = _A;
      LATCHED_D = _D;
      LATCHED_EMA = _EMA;
   end
   endtask

   task x_inputs;
      integer n;
   begin
	 LATCHED_CEN = (NOT_CEN!==LAST_NOT_CEN) ? 1'bx : LATCHED_CEN ;
	 LATCHED_WEN = (NOT_WEN!==LAST_NOT_WEN) ? 1'bx : LATCHED_WEN ;
	 for (n=0; n<ADDR_WIDTH; n=n+1)
	 begin
	    LATCHED_A[n] = (NOT_A[n]!==LAST_NOT_A[n]) ? 1'bx : LATCHED_A[n] ;
	 end
	 for (n=0; n<BITS; n=n+1)
	 begin
	    LATCHED_D[n] = (NOT_D[n]!==LAST_NOT_D[n]) ? 1'bx : LATCHED_D[n] ;
	 end
	 for (n=0; n<UPM_WIDTH; n=n+1)
	 begin
	    LATCHED_EMA[n] = (NOT_EMA[n]!==LAST_NOT_EMA[n]) ? 1'bx : LATCHED_EMA[n] ;
	 end
   end
   endtask

   task update_status;
      input [BITS+RED_COLUMNS-1:0] val;
      input port;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      integer n;
      begin
	 for (n=0; n<=MUX-1; n=n+1)
	 begin
	    tmpdata = last_status[port];
	    tmpdata[BITS+RED_COLUMNS-1:BITS] = val[BITS+RED_COLUMNS-1:BITS];
	    last_status[port] = tmpdata;
	 end
      end
   endtask // update_status

   task clear_status;
      input port;
      reg tmpaddr;
      integer n;
      begin
	 for (n=0; n<=MUX-1; n=n+1)
	 begin
	    tmpaddr = port;
	    last_status[tmpaddr] = {WORDX,{RED_COLUMNS{1'bx}}};
	 end
      end
   endtask // clear_status

   task replace_bit_in_mem;
      input [ADDR_WIDTH-1:0] a;
      input pos;
      input data;
      integer pos;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      reg [ADDR_WIDTH-1:0] tmpaddr;
      integer n;
      begin
	 tmpdata = mem[a];
	 tmpdata[pos] = data;
	 mem[a] = tmpdata;
      end
   endtask // replace_bit_in_mem


   task replace_bit_in_rows;
      input [ADDR_WIDTH-1:0] a;
      input pos;
      input data;
      input radd;
      input bank_address;
      integer pos;
      reg [BITS+RED_COLUMNS-1:0] tmpdata;
      integer n;
      begin
	 tmpdata = rows[{bank_address,radd}];
	 tmpdata[pos] = data;
	 rows[{bank_address,radd}] = tmpdata;
      end
   endtask // replace_bit_in_rows

   task x_mem;
      integer n;
   begin
      for (n=0; n<WORD_DEPTH; n=n+1)
	 mem[n]={WORDX,{RED_COLUMNS{1'bx}}}; // add 2 bits for column redundancy
   end
   endtask

   task x_rows;
      integer n;
   begin
      for (n=0; n<MUX*4; n=n+1)
	 rows[n]={WORDX,{RED_COLUMNS{1'bx}}}; // add 2 bits for column redundancy
   end
   endtask

   task x_row;
      input radd;
      input bank_address;
      integer n;
      reg [COL_ADDR_WIDTH+1:0] tmpaddr;
      begin
	 for (n=0; n<MUX; n=n+1)
	 begin
	    tmpaddr = n;
	    tmpaddr[COL_ADDR_WIDTH] = radd;
            tmpaddr[COL_ADDR_WIDTH+1] = bank_address;
	    rows[tmpaddr]={WORDX,{RED_COLUMNS{1'bx}}}; // add 2 bit for column redundancy
	 end
      end
   endtask // x_rows

   task process_violations;
   begin
      if ((NOT_CLK_PER!==LAST_NOT_CLK_PER) ||
	  (NOT_CLK_MINH!==LAST_NOT_CLK_MINH) ||
	  (NOT_CLK_MINL!==LAST_NOT_CLK_MINL))
	 begin
            if (LATCHED_CEN !== 1'b1)
               begin
		  x_mem;
                  Qi = WORDX ;
	       end
	 end
      else
	 begin
	    update_notifier_buses;
	    x_inputs;
            mem_cycle(Qi,
                      dummy_qb,
                      LATCHED_CEN,
	      	      LATCHED_WEN,
                      LATCHED_A,
                      LATCHED_D,
		      LATCHED_EMA,
		      1'b1,
                      1'b1,
                      1'b1,
                      1'b1,
                      MASK1,
                      ADDR1,
                      WORD1,
                      1'b1,
                      1'b1,
                      WORD1,
                      1'b1,
                      1'b0,
                      WORD1,
                      0
                      );

	 end
      update_last_notifiers;
   end
   endtask

   function valid_address;
      input [ADDR_WIDTH-1:0] a;
      input rren;
      input radd;
   begin
      if (rren === 1'b1)
	valid_address = (^(a) !== 1'bx);
      else if (rren === 1'b0)
	valid_address = (^{radd} !== 1'bx);
      else
	valid_address = 0;
   end
   endfunction

   function valid_cren;
      input [BITS-1:0] cren;
      reg [BITS-1:0] data;
      begin
         data = cren;
         while (data[0] == 1'b1)
           data = data >> 1;
	 if (~|data === 1'b1)
	   valid_cren = 1;
	 else
	   valid_cren = 0;
      end
   endfunction // valid_cren

   function is_contention;
      input [ADDR_WIDTH-1:0] aa;
      input [ADDR_WIDTH-1:0] ab;
      input [ADDR_WIDTH-1:0] taa;
      input [ADDR_WIDTH-1:0] tab;
      input rrena;
      input rrenb;
      input tena;
      input tenb;
      input rraa;
      input rrab;
      input [BITS-1:0] crena;
      input [BITS-1:0] crenb;
      input [RCA_WIDTH-1:0] rcaa;
      input [RCA_WIDTH-1:0] rcab;
      input [WEN_WIDTH-1:0] wena;
      input [WEN_WIDTH-1:0] wenb;
      input [WEN_WIDTH-1:0] twena;
      input [WEN_WIDTH-1:0] twenb;
      input cena;
      input cenb;
      input tcena;
      input tcenb;
      input artna;
      input artnb;
      reg [ADDR_WIDTH-1:0] adda;
      reg [ADDR_WIDTH-1:0] addb;
      reg [ADDR_WIDTH-1:COL_ADDR_WIDTH] row_adda;
      reg [ADDR_WIDTH-1:COL_ADDR_WIDTH] row_addb;
      reg add_colision;
      reg col_add_colision;
      reg row_add_colision;
      reg rra_colision;
      reg rca_colision;
      reg both_ports_reading;
      reg [WEN_WIDTH-1:0] wenai;
      reg [WEN_WIDTH-1:0] wenbi;
			    
      begin
	 wenai = (tena ? wena : twena);
	 wenbi = (tenb ? wenb : twenb);
	 if ( (artna !== 1'b1) & (wenai !== MASK1) & (wenai !== MASK0))
	   wenai = MASKX;
	 if ( (artnb !== 1'b1) & (wenbi !== MASK1) & (wenbi !== MASK0))
	   wenbi = MASKX;
	 if (!valid_cren(crena))
	   crena = WORDX;
	 if (!valid_cren(crenb))
	   crenb = WORDX;

	 col_add_colision = 1'b1;
	 rra_colision = (rraa == rrab) | ((rraa == rrab) === 1'bx);
	 adda = (tena ? aa : taa);
	 addb = (tenb ? ab : tab);
	 add_colision = (adda == addb) | (^adda === 1'bx) | (^addb === 1'bx);
	 
	 row_adda = (tena ? aa[ADDR_WIDTH-1:COL_ADDR_WIDTH] : taa[ADDR_WIDTH-1:COL_ADDR_WIDTH]);
	 row_addb = (tenb ? ab[ADDR_WIDTH-1:COL_ADDR_WIDTH] : tab[ADDR_WIDTH-1:COL_ADDR_WIDTH]);
	 row_add_colision = (row_adda == row_addb) | (^row_adda === 1'bx) | (^row_addb === 1'bx);
	 rca_colision = 1'b1;
	 both_ports_reading = (wenai === MASK1) & 
			      (wenbi === MASK1);

	 is_contention =
			// if either rrena or rrenb are unkown the whole memory is corrupted.
			(((rrena === 1'bx) |
			  (rrenb === 1'bx) |
			  // in redundant row array
			  ((rrena !== 1'b1) & (rrenb !== 1'b1) & ((rraa === 1'bx) | (rrab === 1'bx))) |
			  ((rrena !== 1'b1) & (rrenb !== 1'b1) & col_add_colision & rra_colision) |
			  // in normal array
			  ((rrena !== 1'b0) & (rrenb !== 1'b0) & add_colision) |
			  // redundant column in normal array
			  ((rrena !== 1'b0) & (rrenb !== 1'b0) & row_add_colision &
			   (crena[BITS-1] !== 1'b1) & (crenb[BITS-1] !== 1'b1) & rca_colision) |
			  // redundant column in rednundant row
			  ((rrena !== 1'b1) & (rrenb !== 1'b1) & rra_colision &
			   (crena[BITS-1] !== 1'b1) & (crenb[BITS-1] !== 1'b1) & 
			   ((wenai[WEN_WIDTH-1] !== 1'b1) | (wenbi[WEN_WIDTH-1] !== 1'b1)) & 
			   rca_colision)) &
			 !both_ports_reading &
			 ((tena ? cena : tcena) !== 1'b1) &
			 ((tenb ? cenb : tcenb) !== 1'b1)) ;
      end
   endfunction

   buf (Q[127], _Q[127]);
   buf (Q[126], _Q[126]);
   buf (Q[125], _Q[125]);
   buf (Q[124], _Q[124]);
   buf (Q[123], _Q[123]);
   buf (Q[122], _Q[122]);
   buf (Q[121], _Q[121]);
   buf (Q[120], _Q[120]);
   buf (Q[119], _Q[119]);
   buf (Q[118], _Q[118]);
   buf (Q[117], _Q[117]);
   buf (Q[116], _Q[116]);
   buf (Q[115], _Q[115]);
   buf (Q[114], _Q[114]);
   buf (Q[113], _Q[113]);
   buf (Q[112], _Q[112]);
   buf (Q[111], _Q[111]);
   buf (Q[110], _Q[110]);
   buf (Q[109], _Q[109]);
   buf (Q[108], _Q[108]);
   buf (Q[107], _Q[107]);
   buf (Q[106], _Q[106]);
   buf (Q[105], _Q[105]);
   buf (Q[104], _Q[104]);
   buf (Q[103], _Q[103]);
   buf (Q[102], _Q[102]);
   buf (Q[101], _Q[101]);
   buf (Q[100], _Q[100]);
   buf (Q[99], _Q[99]);
   buf (Q[98], _Q[98]);
   buf (Q[97], _Q[97]);
   buf (Q[96], _Q[96]);
   buf (Q[95], _Q[95]);
   buf (Q[94], _Q[94]);
   buf (Q[93], _Q[93]);
   buf (Q[92], _Q[92]);
   buf (Q[91], _Q[91]);
   buf (Q[90], _Q[90]);
   buf (Q[89], _Q[89]);
   buf (Q[88], _Q[88]);
   buf (Q[87], _Q[87]);
   buf (Q[86], _Q[86]);
   buf (Q[85], _Q[85]);
   buf (Q[84], _Q[84]);
   buf (Q[83], _Q[83]);
   buf (Q[82], _Q[82]);
   buf (Q[81], _Q[81]);
   buf (Q[80], _Q[80]);
   buf (Q[79], _Q[79]);
   buf (Q[78], _Q[78]);
   buf (Q[77], _Q[77]);
   buf (Q[76], _Q[76]);
   buf (Q[75], _Q[75]);
   buf (Q[74], _Q[74]);
   buf (Q[73], _Q[73]);
   buf (Q[72], _Q[72]);
   buf (Q[71], _Q[71]);
   buf (Q[70], _Q[70]);
   buf (Q[69], _Q[69]);
   buf (Q[68], _Q[68]);
   buf (Q[67], _Q[67]);
   buf (Q[66], _Q[66]);
   buf (Q[65], _Q[65]);
   buf (Q[64], _Q[64]);
   buf (Q[63], _Q[63]);
   buf (Q[62], _Q[62]);
   buf (Q[61], _Q[61]);
   buf (Q[60], _Q[60]);
   buf (Q[59], _Q[59]);
   buf (Q[58], _Q[58]);
   buf (Q[57], _Q[57]);
   buf (Q[56], _Q[56]);
   buf (Q[55], _Q[55]);
   buf (Q[54], _Q[54]);
   buf (Q[53], _Q[53]);
   buf (Q[52], _Q[52]);
   buf (Q[51], _Q[51]);
   buf (Q[50], _Q[50]);
   buf (Q[49], _Q[49]);
   buf (Q[48], _Q[48]);
   buf (Q[47], _Q[47]);
   buf (Q[46], _Q[46]);
   buf (Q[45], _Q[45]);
   buf (Q[44], _Q[44]);
   buf (Q[43], _Q[43]);
   buf (Q[42], _Q[42]);
   buf (Q[41], _Q[41]);
   buf (Q[40], _Q[40]);
   buf (Q[39], _Q[39]);
   buf (Q[38], _Q[38]);
   buf (Q[37], _Q[37]);
   buf (Q[36], _Q[36]);
   buf (Q[35], _Q[35]);
   buf (Q[34], _Q[34]);
   buf (Q[33], _Q[33]);
   buf (Q[32], _Q[32]);
   buf (Q[31], _Q[31]);
   buf (Q[30], _Q[30]);
   buf (Q[29], _Q[29]);
   buf (Q[28], _Q[28]);
   buf (Q[27], _Q[27]);
   buf (Q[26], _Q[26]);
   buf (Q[25], _Q[25]);
   buf (Q[24], _Q[24]);
   buf (Q[23], _Q[23]);
   buf (Q[22], _Q[22]);
   buf (Q[21], _Q[21]);
   buf (Q[20], _Q[20]);
   buf (Q[19], _Q[19]);
   buf (Q[18], _Q[18]);
   buf (Q[17], _Q[17]);
   buf (Q[16], _Q[16]);
   buf (Q[15], _Q[15]);
   buf (Q[14], _Q[14]);
   buf (Q[13], _Q[13]);
   buf (Q[12], _Q[12]);
   buf (Q[11], _Q[11]);
   buf (Q[10], _Q[10]);
   buf (Q[9], _Q[9]);
   buf (Q[8], _Q[8]);
   buf (Q[7], _Q[7]);
   buf (Q[6], _Q[6]);
   buf (Q[5], _Q[5]);
   buf (Q[4], _Q[4]);
   buf (Q[3], _Q[3]);
   buf (Q[2], _Q[2]);
   buf (Q[1], _Q[1]);
   buf (Q[0], _Q[0]);
   buf (_CLK, CLK);
   buf (_CEN, CEN);
   buf (_WEN, WEN);
   buf (_A[4], A[4]);
   buf (_A[3], A[3]);
   buf (_A[2], A[2]);
   buf (_A[1], A[1]);
   buf (_A[0], A[0]);
   buf (_D[127], D[127]);
   buf (_D[126], D[126]);
   buf (_D[125], D[125]);
   buf (_D[124], D[124]);
   buf (_D[123], D[123]);
   buf (_D[122], D[122]);
   buf (_D[121], D[121]);
   buf (_D[120], D[120]);
   buf (_D[119], D[119]);
   buf (_D[118], D[118]);
   buf (_D[117], D[117]);
   buf (_D[116], D[116]);
   buf (_D[115], D[115]);
   buf (_D[114], D[114]);
   buf (_D[113], D[113]);
   buf (_D[112], D[112]);
   buf (_D[111], D[111]);
   buf (_D[110], D[110]);
   buf (_D[109], D[109]);
   buf (_D[108], D[108]);
   buf (_D[107], D[107]);
   buf (_D[106], D[106]);
   buf (_D[105], D[105]);
   buf (_D[104], D[104]);
   buf (_D[103], D[103]);
   buf (_D[102], D[102]);
   buf (_D[101], D[101]);
   buf (_D[100], D[100]);
   buf (_D[99], D[99]);
   buf (_D[98], D[98]);
   buf (_D[97], D[97]);
   buf (_D[96], D[96]);
   buf (_D[95], D[95]);
   buf (_D[94], D[94]);
   buf (_D[93], D[93]);
   buf (_D[92], D[92]);
   buf (_D[91], D[91]);
   buf (_D[90], D[90]);
   buf (_D[89], D[89]);
   buf (_D[88], D[88]);
   buf (_D[87], D[87]);
   buf (_D[86], D[86]);
   buf (_D[85], D[85]);
   buf (_D[84], D[84]);
   buf (_D[83], D[83]);
   buf (_D[82], D[82]);
   buf (_D[81], D[81]);
   buf (_D[80], D[80]);
   buf (_D[79], D[79]);
   buf (_D[78], D[78]);
   buf (_D[77], D[77]);
   buf (_D[76], D[76]);
   buf (_D[75], D[75]);
   buf (_D[74], D[74]);
   buf (_D[73], D[73]);
   buf (_D[72], D[72]);
   buf (_D[71], D[71]);
   buf (_D[70], D[70]);
   buf (_D[69], D[69]);
   buf (_D[68], D[68]);
   buf (_D[67], D[67]);
   buf (_D[66], D[66]);
   buf (_D[65], D[65]);
   buf (_D[64], D[64]);
   buf (_D[63], D[63]);
   buf (_D[62], D[62]);
   buf (_D[61], D[61]);
   buf (_D[60], D[60]);
   buf (_D[59], D[59]);
   buf (_D[58], D[58]);
   buf (_D[57], D[57]);
   buf (_D[56], D[56]);
   buf (_D[55], D[55]);
   buf (_D[54], D[54]);
   buf (_D[53], D[53]);
   buf (_D[52], D[52]);
   buf (_D[51], D[51]);
   buf (_D[50], D[50]);
   buf (_D[49], D[49]);
   buf (_D[48], D[48]);
   buf (_D[47], D[47]);
   buf (_D[46], D[46]);
   buf (_D[45], D[45]);
   buf (_D[44], D[44]);
   buf (_D[43], D[43]);
   buf (_D[42], D[42]);
   buf (_D[41], D[41]);
   buf (_D[40], D[40]);
   buf (_D[39], D[39]);
   buf (_D[38], D[38]);
   buf (_D[37], D[37]);
   buf (_D[36], D[36]);
   buf (_D[35], D[35]);
   buf (_D[34], D[34]);
   buf (_D[33], D[33]);
   buf (_D[32], D[32]);
   buf (_D[31], D[31]);
   buf (_D[30], D[30]);
   buf (_D[29], D[29]);
   buf (_D[28], D[28]);
   buf (_D[27], D[27]);
   buf (_D[26], D[26]);
   buf (_D[25], D[25]);
   buf (_D[24], D[24]);
   buf (_D[23], D[23]);
   buf (_D[22], D[22]);
   buf (_D[21], D[21]);
   buf (_D[20], D[20]);
   buf (_D[19], D[19]);
   buf (_D[18], D[18]);
   buf (_D[17], D[17]);
   buf (_D[16], D[16]);
   buf (_D[15], D[15]);
   buf (_D[14], D[14]);
   buf (_D[13], D[13]);
   buf (_D[12], D[12]);
   buf (_D[11], D[11]);
   buf (_D[10], D[10]);
   buf (_D[9], D[9]);
   buf (_D[8], D[8]);
   buf (_D[7], D[7]);
   buf (_D[6], D[6]);
   buf (_D[5], D[5]);
   buf (_D[4], D[4]);
   buf (_D[3], D[3]);
   buf (_D[2], D[2]);
   buf (_D[1], D[1]);
   buf (_D[0], D[0]);
   buf (_EMA[2], EMA[2]);
   buf (_EMA[1], EMA[1]);
   buf (_EMA[0], EMA[0]);

   assign _Q = Qi ;
   assign CEN_flag = 1'b1;          // use this for cen
   assign flag = !_CEN;             // use this for normal mission-mode inputs
   assign D_flag = !(_CEN || _WEN);
   assign cyc_flag = !_CEN;         // use this for non-muxed inputs.
   assign EMA2eq0andEMA1eq0andEMA0eq0 = !_EMA[2] && !_EMA[1] && !_EMA[0];
   assign EMA2eq0andEMA1eq0andEMA0eq1 = !_EMA[2] && !_EMA[1] && _EMA[0];
   assign EMA2eq0andEMA1eq1andEMA0eq0 = !_EMA[2] && _EMA[1] && !_EMA[0];
   assign EMA2eq0andEMA1eq1andEMA0eq1 = !_EMA[2] && _EMA[1] && _EMA[0];
   assign EMA2eq1andEMA1eq0andEMA0eq0 = _EMA[2] && !_EMA[1] && !_EMA[0];
   assign EMA2eq1andEMA1eq0andEMA0eq1 = _EMA[2] && !_EMA[1] && _EMA[0];
   assign EMA2eq1andEMA1eq1andEMA0eq0 = _EMA[2] && _EMA[1] && !_EMA[0];
   assign EMA2eq1andEMA1eq1andEMA0eq1 = _EMA[2] && _EMA[1] && _EMA[0];


   always @(
	    NOT_CEN or
	    NOT_WEN or
	    NOT_A4 or
	    NOT_A3 or
	    NOT_A2 or
	    NOT_A1 or
	    NOT_A0 or
	    NOT_D127 or
	    NOT_D126 or
	    NOT_D125 or
	    NOT_D124 or
	    NOT_D123 or
	    NOT_D122 or
	    NOT_D121 or
	    NOT_D120 or
	    NOT_D119 or
	    NOT_D118 or
	    NOT_D117 or
	    NOT_D116 or
	    NOT_D115 or
	    NOT_D114 or
	    NOT_D113 or
	    NOT_D112 or
	    NOT_D111 or
	    NOT_D110 or
	    NOT_D109 or
	    NOT_D108 or
	    NOT_D107 or
	    NOT_D106 or
	    NOT_D105 or
	    NOT_D104 or
	    NOT_D103 or
	    NOT_D102 or
	    NOT_D101 or
	    NOT_D100 or
	    NOT_D99 or
	    NOT_D98 or
	    NOT_D97 or
	    NOT_D96 or
	    NOT_D95 or
	    NOT_D94 or
	    NOT_D93 or
	    NOT_D92 or
	    NOT_D91 or
	    NOT_D90 or
	    NOT_D89 or
	    NOT_D88 or
	    NOT_D87 or
	    NOT_D86 or
	    NOT_D85 or
	    NOT_D84 or
	    NOT_D83 or
	    NOT_D82 or
	    NOT_D81 or
	    NOT_D80 or
	    NOT_D79 or
	    NOT_D78 or
	    NOT_D77 or
	    NOT_D76 or
	    NOT_D75 or
	    NOT_D74 or
	    NOT_D73 or
	    NOT_D72 or
	    NOT_D71 or
	    NOT_D70 or
	    NOT_D69 or
	    NOT_D68 or
	    NOT_D67 or
	    NOT_D66 or
	    NOT_D65 or
	    NOT_D64 or
	    NOT_D63 or
	    NOT_D62 or
	    NOT_D61 or
	    NOT_D60 or
	    NOT_D59 or
	    NOT_D58 or
	    NOT_D57 or
	    NOT_D56 or
	    NOT_D55 or
	    NOT_D54 or
	    NOT_D53 or
	    NOT_D52 or
	    NOT_D51 or
	    NOT_D50 or
	    NOT_D49 or
	    NOT_D48 or
	    NOT_D47 or
	    NOT_D46 or
	    NOT_D45 or
	    NOT_D44 or
	    NOT_D43 or
	    NOT_D42 or
	    NOT_D41 or
	    NOT_D40 or
	    NOT_D39 or
	    NOT_D38 or
	    NOT_D37 or
	    NOT_D36 or
	    NOT_D35 or
	    NOT_D34 or
	    NOT_D33 or
	    NOT_D32 or
	    NOT_D31 or
	    NOT_D30 or
	    NOT_D29 or
	    NOT_D28 or
	    NOT_D27 or
	    NOT_D26 or
	    NOT_D25 or
	    NOT_D24 or
	    NOT_D23 or
	    NOT_D22 or
	    NOT_D21 or
	    NOT_D20 or
	    NOT_D19 or
	    NOT_D18 or
	    NOT_D17 or
	    NOT_D16 or
	    NOT_D15 or
	    NOT_D14 or
	    NOT_D13 or
	    NOT_D12 or
	    NOT_D11 or
	    NOT_D10 or
	    NOT_D9 or
	    NOT_D8 or
	    NOT_D7 or
	    NOT_D6 or
	    NOT_D5 or
	    NOT_D4 or
	    NOT_D3 or
	    NOT_D2 or
	    NOT_D1 or
	    NOT_D0 or
	    NOT_EMA2 or
	    NOT_EMA1 or
	    NOT_EMA0 or
	    NOT_CLK_PER or
	    NOT_CLK_MINH or
	    NOT_CLK_MINL
	    )
      begin
         process_violations;
      end

   always @( _CLK )
      begin
         casez({LAST_CLK,_CLK})
	   2'b01: begin
	      latch_inputs;
              clear_status(0);
              mem_cycle(Qi,
                        dummy_qb,
                        LATCHED_CEN,
	      	        LATCHED_WEN,
                        LATCHED_A,
                        LATCHED_D,
		        LATCHED_EMA,
		        1'b1,
                        1'b1,
                        1'b1,
                        1'b1,
                        MASK1,
                        ADDR1,
                        WORD1,
                        1'b1,
                        1'b1,
                        WORD1,
                        1'b1,
                        1'b0,
                        WORD1,
                        0
                       );
	   end

	   2'b10,
	   2'bx?,
	   2'b00,
	   2'b11: ;

	   2'b?x: begin
	      x_mem;
              Qi = WORDX ;
	   end
	   
	 endcase
	 LAST_CLK = _CLK;
      end


   specify
      $setuphold(posedge CLK &&& CEN_flag, posedge CEN, 1.000, 0.500, NOT_CEN);
      $setuphold(posedge CLK &&& CEN_flag, negedge CEN, 1.000, 0.500, NOT_CEN);
      $setuphold(posedge CLK &&& flag, posedge WEN, 1.000, 0.500, NOT_WEN);
      $setuphold(posedge CLK &&& flag, negedge WEN, 1.000, 0.500, NOT_WEN);
      $setuphold(posedge CLK &&& flag, posedge A[4], 1.000, 0.500, NOT_A4);
      $setuphold(posedge CLK &&& flag, negedge A[4], 1.000, 0.500, NOT_A4);
      $setuphold(posedge CLK &&& flag, posedge A[3], 1.000, 0.500, NOT_A3);
      $setuphold(posedge CLK &&& flag, negedge A[3], 1.000, 0.500, NOT_A3);
      $setuphold(posedge CLK &&& flag, posedge A[2], 1.000, 0.500, NOT_A2);
      $setuphold(posedge CLK &&& flag, negedge A[2], 1.000, 0.500, NOT_A2);
      $setuphold(posedge CLK &&& flag, posedge A[1], 1.000, 0.500, NOT_A1);
      $setuphold(posedge CLK &&& flag, negedge A[1], 1.000, 0.500, NOT_A1);
      $setuphold(posedge CLK &&& flag, posedge A[0], 1.000, 0.500, NOT_A0);
      $setuphold(posedge CLK &&& flag, negedge A[0], 1.000, 0.500, NOT_A0);
      $setuphold(posedge CLK &&& D_flag, posedge D[127], 1.000, 0.500, NOT_D127);
      $setuphold(posedge CLK &&& D_flag, negedge D[127], 1.000, 0.500, NOT_D127);
      $setuphold(posedge CLK &&& D_flag, posedge D[126], 1.000, 0.500, NOT_D126);
      $setuphold(posedge CLK &&& D_flag, negedge D[126], 1.000, 0.500, NOT_D126);
      $setuphold(posedge CLK &&& D_flag, posedge D[125], 1.000, 0.500, NOT_D125);
      $setuphold(posedge CLK &&& D_flag, negedge D[125], 1.000, 0.500, NOT_D125);
      $setuphold(posedge CLK &&& D_flag, posedge D[124], 1.000, 0.500, NOT_D124);
      $setuphold(posedge CLK &&& D_flag, negedge D[124], 1.000, 0.500, NOT_D124);
      $setuphold(posedge CLK &&& D_flag, posedge D[123], 1.000, 0.500, NOT_D123);
      $setuphold(posedge CLK &&& D_flag, negedge D[123], 1.000, 0.500, NOT_D123);
      $setuphold(posedge CLK &&& D_flag, posedge D[122], 1.000, 0.500, NOT_D122);
      $setuphold(posedge CLK &&& D_flag, negedge D[122], 1.000, 0.500, NOT_D122);
      $setuphold(posedge CLK &&& D_flag, posedge D[121], 1.000, 0.500, NOT_D121);
      $setuphold(posedge CLK &&& D_flag, negedge D[121], 1.000, 0.500, NOT_D121);
      $setuphold(posedge CLK &&& D_flag, posedge D[120], 1.000, 0.500, NOT_D120);
      $setuphold(posedge CLK &&& D_flag, negedge D[120], 1.000, 0.500, NOT_D120);
      $setuphold(posedge CLK &&& D_flag, posedge D[119], 1.000, 0.500, NOT_D119);
      $setuphold(posedge CLK &&& D_flag, negedge D[119], 1.000, 0.500, NOT_D119);
      $setuphold(posedge CLK &&& D_flag, posedge D[118], 1.000, 0.500, NOT_D118);
      $setuphold(posedge CLK &&& D_flag, negedge D[118], 1.000, 0.500, NOT_D118);
      $setuphold(posedge CLK &&& D_flag, posedge D[117], 1.000, 0.500, NOT_D117);
      $setuphold(posedge CLK &&& D_flag, negedge D[117], 1.000, 0.500, NOT_D117);
      $setuphold(posedge CLK &&& D_flag, posedge D[116], 1.000, 0.500, NOT_D116);
      $setuphold(posedge CLK &&& D_flag, negedge D[116], 1.000, 0.500, NOT_D116);
      $setuphold(posedge CLK &&& D_flag, posedge D[115], 1.000, 0.500, NOT_D115);
      $setuphold(posedge CLK &&& D_flag, negedge D[115], 1.000, 0.500, NOT_D115);
      $setuphold(posedge CLK &&& D_flag, posedge D[114], 1.000, 0.500, NOT_D114);
      $setuphold(posedge CLK &&& D_flag, negedge D[114], 1.000, 0.500, NOT_D114);
      $setuphold(posedge CLK &&& D_flag, posedge D[113], 1.000, 0.500, NOT_D113);
      $setuphold(posedge CLK &&& D_flag, negedge D[113], 1.000, 0.500, NOT_D113);
      $setuphold(posedge CLK &&& D_flag, posedge D[112], 1.000, 0.500, NOT_D112);
      $setuphold(posedge CLK &&& D_flag, negedge D[112], 1.000, 0.500, NOT_D112);
      $setuphold(posedge CLK &&& D_flag, posedge D[111], 1.000, 0.500, NOT_D111);
      $setuphold(posedge CLK &&& D_flag, negedge D[111], 1.000, 0.500, NOT_D111);
      $setuphold(posedge CLK &&& D_flag, posedge D[110], 1.000, 0.500, NOT_D110);
      $setuphold(posedge CLK &&& D_flag, negedge D[110], 1.000, 0.500, NOT_D110);
      $setuphold(posedge CLK &&& D_flag, posedge D[109], 1.000, 0.500, NOT_D109);
      $setuphold(posedge CLK &&& D_flag, negedge D[109], 1.000, 0.500, NOT_D109);
      $setuphold(posedge CLK &&& D_flag, posedge D[108], 1.000, 0.500, NOT_D108);
      $setuphold(posedge CLK &&& D_flag, negedge D[108], 1.000, 0.500, NOT_D108);
      $setuphold(posedge CLK &&& D_flag, posedge D[107], 1.000, 0.500, NOT_D107);
      $setuphold(posedge CLK &&& D_flag, negedge D[107], 1.000, 0.500, NOT_D107);
      $setuphold(posedge CLK &&& D_flag, posedge D[106], 1.000, 0.500, NOT_D106);
      $setuphold(posedge CLK &&& D_flag, negedge D[106], 1.000, 0.500, NOT_D106);
      $setuphold(posedge CLK &&& D_flag, posedge D[105], 1.000, 0.500, NOT_D105);
      $setuphold(posedge CLK &&& D_flag, negedge D[105], 1.000, 0.500, NOT_D105);
      $setuphold(posedge CLK &&& D_flag, posedge D[104], 1.000, 0.500, NOT_D104);
      $setuphold(posedge CLK &&& D_flag, negedge D[104], 1.000, 0.500, NOT_D104);
      $setuphold(posedge CLK &&& D_flag, posedge D[103], 1.000, 0.500, NOT_D103);
      $setuphold(posedge CLK &&& D_flag, negedge D[103], 1.000, 0.500, NOT_D103);
      $setuphold(posedge CLK &&& D_flag, posedge D[102], 1.000, 0.500, NOT_D102);
      $setuphold(posedge CLK &&& D_flag, negedge D[102], 1.000, 0.500, NOT_D102);
      $setuphold(posedge CLK &&& D_flag, posedge D[101], 1.000, 0.500, NOT_D101);
      $setuphold(posedge CLK &&& D_flag, negedge D[101], 1.000, 0.500, NOT_D101);
      $setuphold(posedge CLK &&& D_flag, posedge D[100], 1.000, 0.500, NOT_D100);
      $setuphold(posedge CLK &&& D_flag, negedge D[100], 1.000, 0.500, NOT_D100);
      $setuphold(posedge CLK &&& D_flag, posedge D[99], 1.000, 0.500, NOT_D99);
      $setuphold(posedge CLK &&& D_flag, negedge D[99], 1.000, 0.500, NOT_D99);
      $setuphold(posedge CLK &&& D_flag, posedge D[98], 1.000, 0.500, NOT_D98);
      $setuphold(posedge CLK &&& D_flag, negedge D[98], 1.000, 0.500, NOT_D98);
      $setuphold(posedge CLK &&& D_flag, posedge D[97], 1.000, 0.500, NOT_D97);
      $setuphold(posedge CLK &&& D_flag, negedge D[97], 1.000, 0.500, NOT_D97);
      $setuphold(posedge CLK &&& D_flag, posedge D[96], 1.000, 0.500, NOT_D96);
      $setuphold(posedge CLK &&& D_flag, negedge D[96], 1.000, 0.500, NOT_D96);
      $setuphold(posedge CLK &&& D_flag, posedge D[95], 1.000, 0.500, NOT_D95);
      $setuphold(posedge CLK &&& D_flag, negedge D[95], 1.000, 0.500, NOT_D95);
      $setuphold(posedge CLK &&& D_flag, posedge D[94], 1.000, 0.500, NOT_D94);
      $setuphold(posedge CLK &&& D_flag, negedge D[94], 1.000, 0.500, NOT_D94);
      $setuphold(posedge CLK &&& D_flag, posedge D[93], 1.000, 0.500, NOT_D93);
      $setuphold(posedge CLK &&& D_flag, negedge D[93], 1.000, 0.500, NOT_D93);
      $setuphold(posedge CLK &&& D_flag, posedge D[92], 1.000, 0.500, NOT_D92);
      $setuphold(posedge CLK &&& D_flag, negedge D[92], 1.000, 0.500, NOT_D92);
      $setuphold(posedge CLK &&& D_flag, posedge D[91], 1.000, 0.500, NOT_D91);
      $setuphold(posedge CLK &&& D_flag, negedge D[91], 1.000, 0.500, NOT_D91);
      $setuphold(posedge CLK &&& D_flag, posedge D[90], 1.000, 0.500, NOT_D90);
      $setuphold(posedge CLK &&& D_flag, negedge D[90], 1.000, 0.500, NOT_D90);
      $setuphold(posedge CLK &&& D_flag, posedge D[89], 1.000, 0.500, NOT_D89);
      $setuphold(posedge CLK &&& D_flag, negedge D[89], 1.000, 0.500, NOT_D89);
      $setuphold(posedge CLK &&& D_flag, posedge D[88], 1.000, 0.500, NOT_D88);
      $setuphold(posedge CLK &&& D_flag, negedge D[88], 1.000, 0.500, NOT_D88);
      $setuphold(posedge CLK &&& D_flag, posedge D[87], 1.000, 0.500, NOT_D87);
      $setuphold(posedge CLK &&& D_flag, negedge D[87], 1.000, 0.500, NOT_D87);
      $setuphold(posedge CLK &&& D_flag, posedge D[86], 1.000, 0.500, NOT_D86);
      $setuphold(posedge CLK &&& D_flag, negedge D[86], 1.000, 0.500, NOT_D86);
      $setuphold(posedge CLK &&& D_flag, posedge D[85], 1.000, 0.500, NOT_D85);
      $setuphold(posedge CLK &&& D_flag, negedge D[85], 1.000, 0.500, NOT_D85);
      $setuphold(posedge CLK &&& D_flag, posedge D[84], 1.000, 0.500, NOT_D84);
      $setuphold(posedge CLK &&& D_flag, negedge D[84], 1.000, 0.500, NOT_D84);
      $setuphold(posedge CLK &&& D_flag, posedge D[83], 1.000, 0.500, NOT_D83);
      $setuphold(posedge CLK &&& D_flag, negedge D[83], 1.000, 0.500, NOT_D83);
      $setuphold(posedge CLK &&& D_flag, posedge D[82], 1.000, 0.500, NOT_D82);
      $setuphold(posedge CLK &&& D_flag, negedge D[82], 1.000, 0.500, NOT_D82);
      $setuphold(posedge CLK &&& D_flag, posedge D[81], 1.000, 0.500, NOT_D81);
      $setuphold(posedge CLK &&& D_flag, negedge D[81], 1.000, 0.500, NOT_D81);
      $setuphold(posedge CLK &&& D_flag, posedge D[80], 1.000, 0.500, NOT_D80);
      $setuphold(posedge CLK &&& D_flag, negedge D[80], 1.000, 0.500, NOT_D80);
      $setuphold(posedge CLK &&& D_flag, posedge D[79], 1.000, 0.500, NOT_D79);
      $setuphold(posedge CLK &&& D_flag, negedge D[79], 1.000, 0.500, NOT_D79);
      $setuphold(posedge CLK &&& D_flag, posedge D[78], 1.000, 0.500, NOT_D78);
      $setuphold(posedge CLK &&& D_flag, negedge D[78], 1.000, 0.500, NOT_D78);
      $setuphold(posedge CLK &&& D_flag, posedge D[77], 1.000, 0.500, NOT_D77);
      $setuphold(posedge CLK &&& D_flag, negedge D[77], 1.000, 0.500, NOT_D77);
      $setuphold(posedge CLK &&& D_flag, posedge D[76], 1.000, 0.500, NOT_D76);
      $setuphold(posedge CLK &&& D_flag, negedge D[76], 1.000, 0.500, NOT_D76);
      $setuphold(posedge CLK &&& D_flag, posedge D[75], 1.000, 0.500, NOT_D75);
      $setuphold(posedge CLK &&& D_flag, negedge D[75], 1.000, 0.500, NOT_D75);
      $setuphold(posedge CLK &&& D_flag, posedge D[74], 1.000, 0.500, NOT_D74);
      $setuphold(posedge CLK &&& D_flag, negedge D[74], 1.000, 0.500, NOT_D74);
      $setuphold(posedge CLK &&& D_flag, posedge D[73], 1.000, 0.500, NOT_D73);
      $setuphold(posedge CLK &&& D_flag, negedge D[73], 1.000, 0.500, NOT_D73);
      $setuphold(posedge CLK &&& D_flag, posedge D[72], 1.000, 0.500, NOT_D72);
      $setuphold(posedge CLK &&& D_flag, negedge D[72], 1.000, 0.500, NOT_D72);
      $setuphold(posedge CLK &&& D_flag, posedge D[71], 1.000, 0.500, NOT_D71);
      $setuphold(posedge CLK &&& D_flag, negedge D[71], 1.000, 0.500, NOT_D71);
      $setuphold(posedge CLK &&& D_flag, posedge D[70], 1.000, 0.500, NOT_D70);
      $setuphold(posedge CLK &&& D_flag, negedge D[70], 1.000, 0.500, NOT_D70);
      $setuphold(posedge CLK &&& D_flag, posedge D[69], 1.000, 0.500, NOT_D69);
      $setuphold(posedge CLK &&& D_flag, negedge D[69], 1.000, 0.500, NOT_D69);
      $setuphold(posedge CLK &&& D_flag, posedge D[68], 1.000, 0.500, NOT_D68);
      $setuphold(posedge CLK &&& D_flag, negedge D[68], 1.000, 0.500, NOT_D68);
      $setuphold(posedge CLK &&& D_flag, posedge D[67], 1.000, 0.500, NOT_D67);
      $setuphold(posedge CLK &&& D_flag, negedge D[67], 1.000, 0.500, NOT_D67);
      $setuphold(posedge CLK &&& D_flag, posedge D[66], 1.000, 0.500, NOT_D66);
      $setuphold(posedge CLK &&& D_flag, negedge D[66], 1.000, 0.500, NOT_D66);
      $setuphold(posedge CLK &&& D_flag, posedge D[65], 1.000, 0.500, NOT_D65);
      $setuphold(posedge CLK &&& D_flag, negedge D[65], 1.000, 0.500, NOT_D65);
      $setuphold(posedge CLK &&& D_flag, posedge D[64], 1.000, 0.500, NOT_D64);
      $setuphold(posedge CLK &&& D_flag, negedge D[64], 1.000, 0.500, NOT_D64);
      $setuphold(posedge CLK &&& D_flag, posedge D[63], 1.000, 0.500, NOT_D63);
      $setuphold(posedge CLK &&& D_flag, negedge D[63], 1.000, 0.500, NOT_D63);
      $setuphold(posedge CLK &&& D_flag, posedge D[62], 1.000, 0.500, NOT_D62);
      $setuphold(posedge CLK &&& D_flag, negedge D[62], 1.000, 0.500, NOT_D62);
      $setuphold(posedge CLK &&& D_flag, posedge D[61], 1.000, 0.500, NOT_D61);
      $setuphold(posedge CLK &&& D_flag, negedge D[61], 1.000, 0.500, NOT_D61);
      $setuphold(posedge CLK &&& D_flag, posedge D[60], 1.000, 0.500, NOT_D60);
      $setuphold(posedge CLK &&& D_flag, negedge D[60], 1.000, 0.500, NOT_D60);
      $setuphold(posedge CLK &&& D_flag, posedge D[59], 1.000, 0.500, NOT_D59);
      $setuphold(posedge CLK &&& D_flag, negedge D[59], 1.000, 0.500, NOT_D59);
      $setuphold(posedge CLK &&& D_flag, posedge D[58], 1.000, 0.500, NOT_D58);
      $setuphold(posedge CLK &&& D_flag, negedge D[58], 1.000, 0.500, NOT_D58);
      $setuphold(posedge CLK &&& D_flag, posedge D[57], 1.000, 0.500, NOT_D57);
      $setuphold(posedge CLK &&& D_flag, negedge D[57], 1.000, 0.500, NOT_D57);
      $setuphold(posedge CLK &&& D_flag, posedge D[56], 1.000, 0.500, NOT_D56);
      $setuphold(posedge CLK &&& D_flag, negedge D[56], 1.000, 0.500, NOT_D56);
      $setuphold(posedge CLK &&& D_flag, posedge D[55], 1.000, 0.500, NOT_D55);
      $setuphold(posedge CLK &&& D_flag, negedge D[55], 1.000, 0.500, NOT_D55);
      $setuphold(posedge CLK &&& D_flag, posedge D[54], 1.000, 0.500, NOT_D54);
      $setuphold(posedge CLK &&& D_flag, negedge D[54], 1.000, 0.500, NOT_D54);
      $setuphold(posedge CLK &&& D_flag, posedge D[53], 1.000, 0.500, NOT_D53);
      $setuphold(posedge CLK &&& D_flag, negedge D[53], 1.000, 0.500, NOT_D53);
      $setuphold(posedge CLK &&& D_flag, posedge D[52], 1.000, 0.500, NOT_D52);
      $setuphold(posedge CLK &&& D_flag, negedge D[52], 1.000, 0.500, NOT_D52);
      $setuphold(posedge CLK &&& D_flag, posedge D[51], 1.000, 0.500, NOT_D51);
      $setuphold(posedge CLK &&& D_flag, negedge D[51], 1.000, 0.500, NOT_D51);
      $setuphold(posedge CLK &&& D_flag, posedge D[50], 1.000, 0.500, NOT_D50);
      $setuphold(posedge CLK &&& D_flag, negedge D[50], 1.000, 0.500, NOT_D50);
      $setuphold(posedge CLK &&& D_flag, posedge D[49], 1.000, 0.500, NOT_D49);
      $setuphold(posedge CLK &&& D_flag, negedge D[49], 1.000, 0.500, NOT_D49);
      $setuphold(posedge CLK &&& D_flag, posedge D[48], 1.000, 0.500, NOT_D48);
      $setuphold(posedge CLK &&& D_flag, negedge D[48], 1.000, 0.500, NOT_D48);
      $setuphold(posedge CLK &&& D_flag, posedge D[47], 1.000, 0.500, NOT_D47);
      $setuphold(posedge CLK &&& D_flag, negedge D[47], 1.000, 0.500, NOT_D47);
      $setuphold(posedge CLK &&& D_flag, posedge D[46], 1.000, 0.500, NOT_D46);
      $setuphold(posedge CLK &&& D_flag, negedge D[46], 1.000, 0.500, NOT_D46);
      $setuphold(posedge CLK &&& D_flag, posedge D[45], 1.000, 0.500, NOT_D45);
      $setuphold(posedge CLK &&& D_flag, negedge D[45], 1.000, 0.500, NOT_D45);
      $setuphold(posedge CLK &&& D_flag, posedge D[44], 1.000, 0.500, NOT_D44);
      $setuphold(posedge CLK &&& D_flag, negedge D[44], 1.000, 0.500, NOT_D44);
      $setuphold(posedge CLK &&& D_flag, posedge D[43], 1.000, 0.500, NOT_D43);
      $setuphold(posedge CLK &&& D_flag, negedge D[43], 1.000, 0.500, NOT_D43);
      $setuphold(posedge CLK &&& D_flag, posedge D[42], 1.000, 0.500, NOT_D42);
      $setuphold(posedge CLK &&& D_flag, negedge D[42], 1.000, 0.500, NOT_D42);
      $setuphold(posedge CLK &&& D_flag, posedge D[41], 1.000, 0.500, NOT_D41);
      $setuphold(posedge CLK &&& D_flag, negedge D[41], 1.000, 0.500, NOT_D41);
      $setuphold(posedge CLK &&& D_flag, posedge D[40], 1.000, 0.500, NOT_D40);
      $setuphold(posedge CLK &&& D_flag, negedge D[40], 1.000, 0.500, NOT_D40);
      $setuphold(posedge CLK &&& D_flag, posedge D[39], 1.000, 0.500, NOT_D39);
      $setuphold(posedge CLK &&& D_flag, negedge D[39], 1.000, 0.500, NOT_D39);
      $setuphold(posedge CLK &&& D_flag, posedge D[38], 1.000, 0.500, NOT_D38);
      $setuphold(posedge CLK &&& D_flag, negedge D[38], 1.000, 0.500, NOT_D38);
      $setuphold(posedge CLK &&& D_flag, posedge D[37], 1.000, 0.500, NOT_D37);
      $setuphold(posedge CLK &&& D_flag, negedge D[37], 1.000, 0.500, NOT_D37);
      $setuphold(posedge CLK &&& D_flag, posedge D[36], 1.000, 0.500, NOT_D36);
      $setuphold(posedge CLK &&& D_flag, negedge D[36], 1.000, 0.500, NOT_D36);
      $setuphold(posedge CLK &&& D_flag, posedge D[35], 1.000, 0.500, NOT_D35);
      $setuphold(posedge CLK &&& D_flag, negedge D[35], 1.000, 0.500, NOT_D35);
      $setuphold(posedge CLK &&& D_flag, posedge D[34], 1.000, 0.500, NOT_D34);
      $setuphold(posedge CLK &&& D_flag, negedge D[34], 1.000, 0.500, NOT_D34);
      $setuphold(posedge CLK &&& D_flag, posedge D[33], 1.000, 0.500, NOT_D33);
      $setuphold(posedge CLK &&& D_flag, negedge D[33], 1.000, 0.500, NOT_D33);
      $setuphold(posedge CLK &&& D_flag, posedge D[32], 1.000, 0.500, NOT_D32);
      $setuphold(posedge CLK &&& D_flag, negedge D[32], 1.000, 0.500, NOT_D32);
      $setuphold(posedge CLK &&& D_flag, posedge D[31], 1.000, 0.500, NOT_D31);
      $setuphold(posedge CLK &&& D_flag, negedge D[31], 1.000, 0.500, NOT_D31);
      $setuphold(posedge CLK &&& D_flag, posedge D[30], 1.000, 0.500, NOT_D30);
      $setuphold(posedge CLK &&& D_flag, negedge D[30], 1.000, 0.500, NOT_D30);
      $setuphold(posedge CLK &&& D_flag, posedge D[29], 1.000, 0.500, NOT_D29);
      $setuphold(posedge CLK &&& D_flag, negedge D[29], 1.000, 0.500, NOT_D29);
      $setuphold(posedge CLK &&& D_flag, posedge D[28], 1.000, 0.500, NOT_D28);
      $setuphold(posedge CLK &&& D_flag, negedge D[28], 1.000, 0.500, NOT_D28);
      $setuphold(posedge CLK &&& D_flag, posedge D[27], 1.000, 0.500, NOT_D27);
      $setuphold(posedge CLK &&& D_flag, negedge D[27], 1.000, 0.500, NOT_D27);
      $setuphold(posedge CLK &&& D_flag, posedge D[26], 1.000, 0.500, NOT_D26);
      $setuphold(posedge CLK &&& D_flag, negedge D[26], 1.000, 0.500, NOT_D26);
      $setuphold(posedge CLK &&& D_flag, posedge D[25], 1.000, 0.500, NOT_D25);
      $setuphold(posedge CLK &&& D_flag, negedge D[25], 1.000, 0.500, NOT_D25);
      $setuphold(posedge CLK &&& D_flag, posedge D[24], 1.000, 0.500, NOT_D24);
      $setuphold(posedge CLK &&& D_flag, negedge D[24], 1.000, 0.500, NOT_D24);
      $setuphold(posedge CLK &&& D_flag, posedge D[23], 1.000, 0.500, NOT_D23);
      $setuphold(posedge CLK &&& D_flag, negedge D[23], 1.000, 0.500, NOT_D23);
      $setuphold(posedge CLK &&& D_flag, posedge D[22], 1.000, 0.500, NOT_D22);
      $setuphold(posedge CLK &&& D_flag, negedge D[22], 1.000, 0.500, NOT_D22);
      $setuphold(posedge CLK &&& D_flag, posedge D[21], 1.000, 0.500, NOT_D21);
      $setuphold(posedge CLK &&& D_flag, negedge D[21], 1.000, 0.500, NOT_D21);
      $setuphold(posedge CLK &&& D_flag, posedge D[20], 1.000, 0.500, NOT_D20);
      $setuphold(posedge CLK &&& D_flag, negedge D[20], 1.000, 0.500, NOT_D20);
      $setuphold(posedge CLK &&& D_flag, posedge D[19], 1.000, 0.500, NOT_D19);
      $setuphold(posedge CLK &&& D_flag, negedge D[19], 1.000, 0.500, NOT_D19);
      $setuphold(posedge CLK &&& D_flag, posedge D[18], 1.000, 0.500, NOT_D18);
      $setuphold(posedge CLK &&& D_flag, negedge D[18], 1.000, 0.500, NOT_D18);
      $setuphold(posedge CLK &&& D_flag, posedge D[17], 1.000, 0.500, NOT_D17);
      $setuphold(posedge CLK &&& D_flag, negedge D[17], 1.000, 0.500, NOT_D17);
      $setuphold(posedge CLK &&& D_flag, posedge D[16], 1.000, 0.500, NOT_D16);
      $setuphold(posedge CLK &&& D_flag, negedge D[16], 1.000, 0.500, NOT_D16);
      $setuphold(posedge CLK &&& D_flag, posedge D[15], 1.000, 0.500, NOT_D15);
      $setuphold(posedge CLK &&& D_flag, negedge D[15], 1.000, 0.500, NOT_D15);
      $setuphold(posedge CLK &&& D_flag, posedge D[14], 1.000, 0.500, NOT_D14);
      $setuphold(posedge CLK &&& D_flag, negedge D[14], 1.000, 0.500, NOT_D14);
      $setuphold(posedge CLK &&& D_flag, posedge D[13], 1.000, 0.500, NOT_D13);
      $setuphold(posedge CLK &&& D_flag, negedge D[13], 1.000, 0.500, NOT_D13);
      $setuphold(posedge CLK &&& D_flag, posedge D[12], 1.000, 0.500, NOT_D12);
      $setuphold(posedge CLK &&& D_flag, negedge D[12], 1.000, 0.500, NOT_D12);
      $setuphold(posedge CLK &&& D_flag, posedge D[11], 1.000, 0.500, NOT_D11);
      $setuphold(posedge CLK &&& D_flag, negedge D[11], 1.000, 0.500, NOT_D11);
      $setuphold(posedge CLK &&& D_flag, posedge D[10], 1.000, 0.500, NOT_D10);
      $setuphold(posedge CLK &&& D_flag, negedge D[10], 1.000, 0.500, NOT_D10);
      $setuphold(posedge CLK &&& D_flag, posedge D[9], 1.000, 0.500, NOT_D9);
      $setuphold(posedge CLK &&& D_flag, negedge D[9], 1.000, 0.500, NOT_D9);
      $setuphold(posedge CLK &&& D_flag, posedge D[8], 1.000, 0.500, NOT_D8);
      $setuphold(posedge CLK &&& D_flag, negedge D[8], 1.000, 0.500, NOT_D8);
      $setuphold(posedge CLK &&& D_flag, posedge D[7], 1.000, 0.500, NOT_D7);
      $setuphold(posedge CLK &&& D_flag, negedge D[7], 1.000, 0.500, NOT_D7);
      $setuphold(posedge CLK &&& D_flag, posedge D[6], 1.000, 0.500, NOT_D6);
      $setuphold(posedge CLK &&& D_flag, negedge D[6], 1.000, 0.500, NOT_D6);
      $setuphold(posedge CLK &&& D_flag, posedge D[5], 1.000, 0.500, NOT_D5);
      $setuphold(posedge CLK &&& D_flag, negedge D[5], 1.000, 0.500, NOT_D5);
      $setuphold(posedge CLK &&& D_flag, posedge D[4], 1.000, 0.500, NOT_D4);
      $setuphold(posedge CLK &&& D_flag, negedge D[4], 1.000, 0.500, NOT_D4);
      $setuphold(posedge CLK &&& D_flag, posedge D[3], 1.000, 0.500, NOT_D3);
      $setuphold(posedge CLK &&& D_flag, negedge D[3], 1.000, 0.500, NOT_D3);
      $setuphold(posedge CLK &&& D_flag, posedge D[2], 1.000, 0.500, NOT_D2);
      $setuphold(posedge CLK &&& D_flag, negedge D[2], 1.000, 0.500, NOT_D2);
      $setuphold(posedge CLK &&& D_flag, posedge D[1], 1.000, 0.500, NOT_D1);
      $setuphold(posedge CLK &&& D_flag, negedge D[1], 1.000, 0.500, NOT_D1);
      $setuphold(posedge CLK &&& D_flag, posedge D[0], 1.000, 0.500, NOT_D0);
      $setuphold(posedge CLK &&& D_flag, negedge D[0], 1.000, 0.500, NOT_D0);
      $setuphold(posedge CLK &&& cyc_flag, posedge EMA[2], 1.000, 0.500, NOT_EMA2);
      $setuphold(posedge CLK &&& cyc_flag, negedge EMA[2], 1.000, 0.500, NOT_EMA2);
      $setuphold(posedge CLK &&& cyc_flag, posedge EMA[1], 1.000, 0.500, NOT_EMA1);
      $setuphold(posedge CLK &&& cyc_flag, negedge EMA[1], 1.000, 0.500, NOT_EMA1);
      $setuphold(posedge CLK &&& cyc_flag, posedge EMA[0], 1.000, 0.500, NOT_EMA0);
      $setuphold(posedge CLK &&& cyc_flag, negedge EMA[0], 1.000, 0.500, NOT_EMA0);


      $width(posedge CLK, 1.000, 0, NOT_CLK_MINH);
      $width(negedge CLK, 1.000, 0, NOT_CLK_MINL);
`ifdef NO_SDTC
      $period(posedge CLK, 3.000, NOT_CLK_PER);
`else
      $period(posedge CLK &&& EMA2eq0andEMA1eq0andEMA0eq0, 3.000, NOT_CLK_PER);
      $period(posedge CLK &&& EMA2eq0andEMA1eq0andEMA0eq1, 3.000, NOT_CLK_PER);
      $period(posedge CLK &&& EMA2eq0andEMA1eq1andEMA0eq0, 3.000, NOT_CLK_PER);
      $period(posedge CLK &&& EMA2eq0andEMA1eq1andEMA0eq1, 3.000, NOT_CLK_PER);
      $period(posedge CLK &&& EMA2eq1andEMA1eq0andEMA0eq0, 3.000, NOT_CLK_PER);
      $period(posedge CLK &&& EMA2eq1andEMA1eq0andEMA0eq1, 3.000, NOT_CLK_PER);
      $period(posedge CLK &&& EMA2eq1andEMA1eq1andEMA0eq0, 3.000, NOT_CLK_PER);
      $period(posedge CLK &&& EMA2eq1andEMA1eq1andEMA0eq1, 3.000, NOT_CLK_PER);
`endif

      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[127])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[126])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[125])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[124])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[123])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[122])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[121])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[120])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[119])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[118])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[117])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[116])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[115])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[114])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[113])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[112])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[111])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[110])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[109])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[108])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[107])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[106])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[105])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[104])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[103])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[102])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[101])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[100])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[99])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[98])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[97])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[96])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[95])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[94])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[93])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[92])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[91])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[90])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[89])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[88])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[87])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[86])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[85])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[84])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[83])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[82])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[81])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[80])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[79])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[78])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[77])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[76])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[75])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[74])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[73])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[72])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[71])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[70])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[69])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[68])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[67])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[66])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[65])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[64])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[63])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[62])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[61])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[60])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[59])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[58])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[57])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[56])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[55])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[54])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[53])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[52])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[51])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[50])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[49])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[48])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[47])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[46])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[45])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[44])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[43])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[42])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[41])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[40])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[39])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[38])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[37])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[36])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[35])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[34])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[33])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[32])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[31])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[30])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[29])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[28])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[27])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[26])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[25])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[24])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[23])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[22])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[21])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[20])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[19])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[18])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[17])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[16])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[15])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[14])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[13])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[12])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[11])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[10])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[9])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[8])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[7])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[6])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[5])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[4])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[3])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[2])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[1])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[0])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[0])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[0])=(1.000, 1.000);
      if ((EMA[2] == 1'b0) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[0])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b0))
	(CLK => Q[0])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b0) && (EMA[0] == 1'b1))
	(CLK => Q[0])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b0))
	(CLK => Q[0])=(1.000, 1.000);
      if ((EMA[2] == 1'b1) && (EMA[1] == 1'b1) && (EMA[0] == 1'b1))
	(CLK => Q[0])=(1.000, 1.000);

   endspecify

endmodule
`endcelldefine
