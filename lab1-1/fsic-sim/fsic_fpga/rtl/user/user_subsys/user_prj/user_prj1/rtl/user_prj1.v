// This code snippet was auto generated by xls2vlog.py from source file: ./user_project_wrapper.xlsx
// User: josh
// Date: Sep-22-23



module USER_PRJ1 #( parameter pUSER_PROJECT_SIDEBAND_WIDTH   = 5,
          parameter pADDR_WIDTH   = 12,
                   parameter pDATA_WIDTH   = 32
                 )
(
  output wire                        awready,
  output wire                        arready,
  output wire                        wready,
  output wire                        rvalid,
  output wire  [(pDATA_WIDTH-1) : 0] rdata,
  input  wire                        awvalid,
  input  wire                [11: 0] awaddr,
  input  wire                        arvalid,
  input  wire                [11: 0] araddr,
  input  wire                        wvalid,
  input  wire                 [3: 0] wstrb,
  input  wire  [(pDATA_WIDTH-1) : 0] wdata,
  input  wire                        rready,
  input  wire                        ss_tvalid,
  input  wire  [(pDATA_WIDTH-1) : 0] ss_tdata,
  input  wire                 [1: 0] ss_tuser,
    `ifdef USER_PROJECT_SIDEBAND_SUPPORT
  input  wire                 [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] ss_tupsb,
  `endif
  input  wire                 [3: 0] ss_tstrb,
  input  wire                 [3: 0] ss_tkeep,
  input  wire                        ss_tlast,
  input  wire                        sm_tready,
  output wire                        ss_tready,
  output wire                        sm_tvalid,
  output wire  [(pDATA_WIDTH-1) : 0] sm_tdata,
  output wire                 [2: 0] sm_tid,
  `ifdef USER_PROJECT_SIDEBAND_SUPPORT
  output  wire                 [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] sm_tupsb,
  `endif
  output wire                 [3: 0] sm_tstrb,
  output wire                 [3: 0] sm_tkeep,
  output wire                        sm_tlast,
  output wire                        low__pri_irq,
  output wire                        High_pri_req,
  output wire                [23: 0] la_data_o,
  input  wire                        axi_clk,
  input  wire                        axis_clk,
  input  wire                        axi_reset_n,
  input  wire                        axis_rst_n,
  input  wire                        user_clock2,
  input  wire                        uck2_rst_n
);


/////assign awready       = 1'b0;
/////assign arready       = 1'b0;
/////assign wready        = 1'b0;
/////assign rvalid        = 1'b0;
/////assign rdata         = {pDATA_WIDTH{1'b0}};
/////assign ss_tready     = 1'b0;
/////assign sm_tvalid     = 1'b0;
/////assign sm_tdata      = {pDATA_WIDTH{1'b0}};
assign sm_tid        = 3'b0;
/////`ifdef USER_PROJECT_SIDEBAND_SUPPORT
/////  assign sm_tupsb      = 5'b0;
/////`endif
/////assign sm_tstrb      = 4'b0;
/////assign sm_tkeep      = 1'b0;
/////assign sm_tlast      = 1'b0;
assign low__pri_irq  = 1'b0;
assign High_pri_req  = 1'b0;
assign la_data_o     = 24'b0;

//*********************************************************//
//                                                         //
//                      Start DIY                          //
//                                                         //
//                                                         //
//*********************************************************//


`ifdef USER_PROJECT_SIDEBAND_SUPPORT
  reg [pUSER_PROJECT_SIDEBAND_WIDTH-1: 0] sm_tupsb_reg;
`endif
reg [3:0] sm_tstrb_reg;
reg [3:0] sm_tkeep_reg;

`ifdef USER_PROJECT_SIDEBAND_SUPPORT
	assign sm_tupsb = sm_tupsb_reg;
`endif
assign sm_tstrb = sm_tstrb_reg;
assign sm_tkeep = sm_tkeep_reg;

always@(posedge axis_clk or negedge axis_rst_n) begin
    if(~axis_rst_n) begin
        `ifdef USER_PROJECT_SIDEBAND_SUPPORT
          sm_tupsb_reg <= 5'b0;
        `endif
        sm_tstrb_reg <= 4'b0;
        sm_tkeep_reg <= 0;
    end
    else if(ss_tvalid & ss_tready) begin
        `ifdef USER_PROJECT_SIDEBAND_SUPPORT
          sm_tupsb_reg <= ss_tupsb;
        `endif
        sm_tstrb_reg <= ss_tstrb;
        sm_tkeep_reg <= ss_tkeep;
    end
    else begin
        `ifdef USER_PROJECT_SIDEBAND_SUPPORT
          sm_tupsb_reg <= sm_tupsb_reg;
        `endif
        sm_tstrb_reg <= sm_tstrb_reg;
        sm_tkeep_reg <= sm_tkeep_reg;
    end
end


  // ram for tap
    wire                     tap_WE_merge;
    wire                     tap_RE;
    wire [(pDATA_WIDTH-1):0] tap_Di;
    wire [(pADDR_WIDTH-1):0] tap_A_shifted;
    wire [(pDATA_WIDTH-1):0] tap_Do;
    
    // ram for data RAM
    wire                     data_WE_merge;
    wire                     data_RE;
    wire [(pDATA_WIDTH-1):0] data_Di;
    wire [(pADDR_WIDTH-1):0] data_A_shifted;
    wire [(pDATA_WIDTH-1):0] data_Do;

  
  fir fir_U0(
        .awready(awready),
        .wready(wready),
        .awvalid(awvalid),
        .awaddr(awaddr),
        .wvalid(wvalid),
        .wdata(wdata),
        .arready(arready),
        .rready(rready),
        .arvalid(arvalid),
        .araddr(araddr),
        .rvalid(rvalid),
        .rdata(rdata),
        .ss_tvalid(ss_tvalid),
        .ss_tdata(ss_tdata),
        .ss_tlast(ss_tlast),
        .ss_tready(ss_tready),
        .sm_tready(sm_tready),
        .sm_tvalid(sm_tvalid),
        .sm_tdata(sm_tdata),
        .sm_tlast(sm_tlast),

        // ram for tap
        .tap_WE_merge(tap_WE_merge),
        .tap_RE(tap_RE),
        .tap_Di(tap_Di),
        .tap_A_shifted(tap_A_shifted),
        .tap_Do(tap_Do),

        // ram for data
        .data_WE_merge(data_WE_merge),
        .data_RE(data_RE),
        .data_Di(data_Di),
        .data_A_shifted(data_A_shifted),
        .data_Do(data_Do),

        .axis_clk(axis_clk),
        .axis_rst_n(axis_rst_n)

    );
    
    // RAM for tap
    bram11 tap_RAM (
        .clk(axis_clk),
        .we(tap_WE_merge),
        .re(tap_RE),
        .waddr(tap_A_shifted),
        .raddr(tap_A_shifted),
        .wdi(tap_Di),
        .rdo(tap_Do)
    );

    // RAM for data
    bram11 data_RAM(
        .clk(axis_clk),
        .we(data_WE_merge),
        .re(data_RE),
        .waddr(data_A_shifted),
        .raddr(data_A_shifted),
        .wdi(data_Di),
        .rdo(data_Do)
    );
    

//*********************************************************//
//                                                         //
//                      End DIY                            //
//                                                         //
//                                                         //
//*********************************************************//


endmodule // USER_PRJ1
