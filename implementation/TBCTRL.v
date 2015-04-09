module TBCTRL (
  input HRESETn,
  input HCLK,
// input
  input HREADYin,
  input HREADYout,
  input HWRITEin,
  input HWRITEout,
  input HSEL,
  input HGRANT,

// Output
  output MAPSn,
  output MDPSn,
  output DENn,
  output SDPSn,
  output SRSn
);
// Master
wire  MasterReadData;
wire  SlaveAddrPhaseSel;
wire					MasterAddrPhaseSel;
reg					MasterDataPhaseSel;
reg					MRWSel;
reg    reg_HGRANT;

// Slave
reg SlaveDataPhaseSel;
reg RWSel;
//assign DENn= MDPSn & SDPSn;
assign DENn = (MDPSn)?SDPSn:MDPSn;


always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    reg_HGRANT  <= 1'b0;
  else
    reg_HGRANT <= HGRANT;
     
end 

// ----------------------------------------------------------
// ------ Master Control ------------------------------------
// ----------------------------------------------------------
// Control Logic
assign MAPSn = ~MasterAddrPhaseSel;
assign MDPSn = ~(MasterDataPhaseSel & MRWSel);
// Master Address Phase

assign MasterAddrPhaseSel = reg_HGRANT;


// Master Data Phase
assign MasterReadData  =  MasterDataPhaseSel & (~MRWSel); 


always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    MasterDataPhaseSel  <= 1'b1;
  else
    begin
      if  (HREADYin)
        MasterDataPhaseSel <= MasterAddrPhaseSel ;
    end 
end   

always @(posedge HCLK or negedge HRESETn)
begin
  if (!HRESETn)
    MRWSel <= 1'b0;
  else
  begin
    if (HREADYin)
      MRWSel <= HWRITEout;
  end
end
//---------END MASTER CONTROL -------------------------------

// ----------------------------------------------------------
// ------ Slave  Control ------------------------------------
// ----------------------------------------------------------
// Slave Address Phase
  assign SlaveAddrPhaseSel  = HSEL;  
  assign SDPSn   =   ~(SlaveDataPhaseSel & RWSel);
  assign SRSn   =  ~SlaveDataPhaseSel;

  always @(posedge HCLK or negedge HRESETn)
  begin
    if (!HRESETn)
      SlaveDataPhaseSel <= 1'b1;
    else
    begin
      if (HREADYin)
        SlaveDataPhaseSel <= SlaveAddrPhaseSel ;
      else 
       SlaveDataPhaseSel <= SlaveDataPhaseSel;
    end
  end  
  
 
// Read Write Select
  always @(posedge HCLK or negedge HRESETn)
  begin
    if (!HRESETn)
      RWSel <= 1'b0;
    else
    begin
      if (HREADYin)
        RWSel <= ~HWRITEin ;
      else 
        RWSel <=RWSel;
    end
  end
  
endmodule
