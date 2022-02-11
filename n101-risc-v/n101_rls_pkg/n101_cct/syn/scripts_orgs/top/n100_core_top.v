//=====================================================================
//
//--  #     # #     #  #####  #       #######   ###
//--  ##    # #     # #     # #       #          #
//--  # #   # #     # #       #       #          #
//--  #  #  # #     # #       #       #####      #
//--  #   # # #     # #       #       #          #
//--  #    ## #     # #     # #       #          #
//--  #     #  #####   #####  ####### #######   ###
//
//=====================================================================
//
//
// Description:
//  The CORE-WRAPPER module to implement CPUs and some closely coupled logic
//
// ====================================================================



`include "n100_defines.v"

    //

module n100_core_top (

  input scanmode ,

 `ifdef N100_HAS_DEBUG//{

 `ifndef N100_HAS_NDSE//{
  //////////////////////////////////////////////////////////
  // The interface to debug-module
  input  jtag_TCK    ,
  input  jtag_TMS_in ,
  input  jtag_TDI    ,
  output jtag_TDO    ,
  output jtag_DRV_TDO,
  output jtag_TMS_out,
  output jtag_DRV_TMS,
  output jtag_BK_TMS ,

      // Debug-Model indication 
      //   High value indicating currently the core is running under debug-mode
  output hart_halted,
  input  i_dbg_stop,    
  output ndmreset,
 `ifdef N100_DBG_TIMEOUT //{
      // The toggle signal to dbg_timeout, treated as async.
      // Use low speed oscillator to lower the power.
  input  dbg_toggle_a,
     
 `endif //}N100_DBG_TIMEOUT


 `endif//N100_HAS_NDSE//}


  `ifdef N100_HAS_NDSE//{
    `ifdef N100_HAS_DEBUG_PRIVATE //{

     `ifdef N100_JTAG_TWOWIRE
  input  sdp_tckc,
  input  sdb_tmsc_in,
  output sdb_tmsc_out ,
  output sdp_tmsc_out_en,
    `endif // N100_JTAG_TWOWIRE

    `ifndef N100_JTAG_TWOWIRE
  input  jtag_tck,
  input  jtag_tms,
  input  jtag_tdi,
  output jtag_tdo,
  output jtag_tdo_en,
    `endif // N100_JTAG_TWOWIRE

  input  disable_ext_debugger,
  output dbg_srst_req,
     `endif//N100_HAS_DEBUG_PRIVATE}

    `ifndef N100_HAS_DEBUG_PRIVATE //{
  input  debugint, //Debug interrupt
  output hart_unavail, // This signal indicates that the processor is not
                       //   available for accesses by the external debugger.
                       //   The processor could be in the reset or some kind of
                       //   power-gating state.
  output hart_under_reset, // This signal indicates that the processor is under reset.
  input  resethaltreq,
     `endif//N100_HAS_DEBUG_PRIVATE}
  output hart_halted, //   High value indicating currently the core is under
                      //     debug-mode (or called halted mode)
  `ifndef N100_TMR_PRIVATE //{
  output dbg_stoptime, // This signal indicates that the processor is in Debug
                   //   Mode and timers should stop counting. This signal 
                   //   is controllable by dcsr.STOPTIME.
  `endif//N100_TMR_PRIVATE}
  `endif//N100_HAS_NDSE}
  `endif//N100_HAS_DEBUG}

  `ifdef N100_TRACE_ITF//{ 
  output trace_ivalid,// This signal indicates that an instruction has retired or trapped (exception).
  output trace_iexception, // This signal indicates that an instruction has trapped (exception).
  output trace_interrupt, // This signal indicates that the exception was an interrupt.
  output [`N100_XLEN-1:0] trace_cause, // This signal indicates the cause of an exception
  output [`N100_XLEN-1:0] trace_tval, // This signal indicates the exception data
  output [`N100_XLEN-1:0] trace_iaddr, // This signal indicates the address of the instruction
  output [`N100_XLEN-1:0] trace_instr, // This signal indicates the instruction
  output [1:0] trace_priv, // This signal indicates the privilege mode during execution
  `endif//N100_TRACE_ITF}



  //////////////////////////////////////////////////////////////
  // The Always-on Clock: This clock is to drive these always-on modules, for example:
  //     The CORE-TOP glue logics, 
  //     Part of Private-Interrupt-Controller, 
  //     The cycle-counter inside core
  //     Debug relevant logics
 // input  core_clk_aon,
      
  // The Main Clock: This clock is to drive majority of the CPU, and also the 
  //   root of several clock gater, such as:
  //     The CORE-TOP glue logics, 
  //     Part of Private-Interrupt-Controller, 
  //     The cycle-counter inside core
  input  core_clk,

  // The system reset (active-low reset signal, treated as async)
  //   * This will reset the entire CORE-TOP except the Debug relevant logics
  input  core_reset_n,
  
  // The Power-on reset (active-low reset signal, treated as async)
  //   * This will reset the entire CORE-TOP include the Debug relevant logics
  input  por_reset_n,

  // The test mode signal
  input reset_bypass,// This will bypass the rst syncer for test purpose
                   // Note: por_reset_n is the only reset used during this reset_bypass signal asserted
  input clkgate_bypass, // This will bypass the clock gater for test purpose

  
  ///////////////////////////////////////////
      // The NMI (Non-maskable interrupts) 
  //input  nmi,
      
`ifdef N100_HAS_NDSE
  ///////////////////////////////////////////
      // The external IRQ from system level PLIC
  input  meip,
`endif//N100_HAS_NDSE
  
  ///////////////////////////////////////////
      // The software IRQ from system level


    `ifndef N100_TMR_PRIVATE //{

  ///////////////////////////////////////////
      // The timer IRQ from system level
  input  mtip,
  input  msip,
    `endif//N100_TMR_PRIVATE}
  
    `ifdef N100_TMR_PRIVATE //{
      `ifdef N100_MSIP_COEXIST
  input  msip_coex,
      `endif//N100_MSIP_COEXIST}
    `endif//N100_TMR_PRIVATE}

    `ifdef N100_TMR_PRIVATE //{
  ///////////////////////////////////////////
      // The toggle signal to mtime
  input  mtime_toggle_a,

    `endif//N100_TMR_PRIVATE}

    `ifdef N100_HAS_CLIC//{
  ///////////////////////////////////////////
      // The IRQ to CLIC
      //   Note: this clic_irq signal index is from 1 to CLIC_IRQ_NUM
  input [`N100_CLIC_IRQ_NUM-1:0] clic_irq,
    `endif//N100_HAS_CLIC//}

  ///////////////////////////////////////////
  // Bus Parity Level 
`ifdef N100_HAS_BUS_PARITY //{
  input              bptylvl,   
`endif//N100_HAS_BUS_PARITY}

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The ILM Master Interface 
     `ifdef N100_HAS_ILM //{

  `ifdef N100_LM_ITF_TYPE_SRAM //{
  output              ilm_cs,  
  output [`N100_ILM_RAM_AW-1:0] ilm_addr, 
  output [`N100_ILM_RAM_MW-1:0] ilm_byte_we,
  output [`N100_ILM_RAM_DW-1:0] ilm_wdata,          
  input  [`N100_ILM_RAM_DW-1:0] ilm_rdata,
  output              clk_ilm_ram,
  `endif//}
  
  `ifdef N100_LM_ITF_TYPE_AHBL //{
      // Do not support the burst and lock transactions
  output [1:0]       ilm_htrans,   // Only IDLE, NONSEQUENTIAL
  output             ilm_hwrite,
  output             ilm_hmastlock,
  output [`N100_ILM_DATA_WIDTH-1:0] ilm_hwdata,   
  output [`N100_ILM_ADDR_WIDTH-1:0]ilm_haddr,    
  output [2:0]       ilm_hsize, // All 32bits (3'b10) in this interface   
  output [2:0]       ilm_hburst, // All SINGLE (3'b000) in this interface   
  output [3:0]       ilm_hprot, //  HPROT[3:2] Always indicates cacheable (bit3 == 1) and non-bufferable (bit2 == 0) on this bus.
                                      //  
                                      //  HPROT[0] Always indicate this is instruction access (1'b0)
  //output [1:0]       ilm_hattri,//  Output Memory attributes. Always 01 for this bus (non-shareable, allocate)
  //output [1:0]       ilm_master,//  Indicate the instruction fetch under debug-mode (2'b01) or regular instruction fetch (2'b10).
                                      //    other values will not be seen on this interface
  input  [`N100_ILM_DATA_WIDTH-1:0]ilm_hrdata,   
  input  [1:0]       ilm_hresp, // Only support response OKAY or ERROR, hence the hresp[1] bit is ignored
  input              ilm_hready,   
       `ifdef N100_HAS_BUS_PARITY//{
  output [1:0]       ilm_hcmdbpty,
  output [3:0]       ilm_hwdatabpty,
  output [3:0]       ilm_haddrbpty,
  input  [3:0]       ilm_hrdatabpty,
  input              ilm_hrspbpty,
  output             ilm_phfatal,
       `endif//N100_HAS_BUS_PARITY}
  `endif//}
  
 // //INTERNAL_CODE_BEGIN
 // `ifdef N100_LM_ITF_TYPE_SRAM //{
 //     // Do not support the burst and lock transactions
 // output             ilm_icb_cmd_valid, 
 // input              ilm_icb_cmd_ready, 
 // output [`N100_ILM_ADDR_WIDTH-1:0]    ilm_icb_cmd_addr, 
 // output [2-1:0]  ilm_icb_cmd_size,
 // output             ilm_icb_cmd_dmode, 
 // output             ilm_icb_cmd_mmode, 

 // input              ilm_icb_rsp_valid, 
 // output             ilm_icb_rsp_ready, 
 // input              ilm_icb_rsp_err,
 // input  [`N100_ILM_DATA_WIDTH-1:0]    ilm_icb_rsp_rdata, 
 // `endif//}
 // //INTERNAL_CODE_END
      `endif//N100_HAS_ILM}

  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The DLM Master Interface 
     `ifdef N100_HAS_DLM //{

  `ifdef N100_LM_ITF_TYPE_SRAM //{
  output              dlm_cs,  
  output [`N100_DLM_RAM_AW-1:0] dlm_addr, 
  output [`N100_DLM_RAM_MW-1:0] dlm_byte_we,
  output [`N100_DLM_RAM_DW-1:0] dlm_wdata,          
  input  [`N100_DLM_RAM_DW-1:0] dlm_rdata,
  output              clk_dlm_ram,
  `endif//}

  `ifdef N100_LM_ITF_TYPE_AHBL //{
      // Do not support the burst and lock transactions
  output [1:0]       dlm_htrans,   // Only IDLE, NONSEQUENTIAL
  output             dlm_hwrite,   
  output             dlm_hmastlock,
  output [`N100_DLM_ADDR_WIDTH-1:0]dlm_haddr,    
  output [2:0]       dlm_hsize,    // Can be 8, 16, or 32 bits
  output [2:0]       dlm_hburst,   // All INCR (3'b001) in this interface
  output [3:0]       dlm_hprot, //  HPROT[3:2] Always indicates cacheable (bit3 == 1) and non-bufferable (bit2 == 0) on this bus.
                                      //  HPROT[1] indicate the machine-mode (1'b1) or user-mode (1'b0) access
                                      //  HPROT[0] Always indicate this is data access (1'b1)
  //output [1:0]       dlm_hattri,//  Output Memory attributes. Always 01 for this bus (non-shareable, allocate)
  output [1:0]       dlm_master,//  Indicate the data access under debug-mode (2'b01) or regular data-access(2'b00).
                                      //    other values will not be seen on this interface
  output [`N100_DLM_DATA_WIDTH-1:0]dlm_hwdata,   
  input  [`N100_DLM_DATA_WIDTH-1:0]dlm_hrdata,   
  input  [1:0]       dlm_hresp,   // Only support response OKAY or ERROR, hence the hresp[1] bit is ignored
  input              dlm_hready,  
       `ifdef N100_HAS_BUS_PARITY//{
  output [1:0]       dlm_hcmdbpty,
  output [3:0]       dlm_hwdatabpty,
  output [3:0]       dlm_haddrbpty,
  input  [3:0]       dlm_hrdatabpty,
  input              dlm_hrspbpty,
  output             dlm_phfatal,
       `endif//N100_HAS_BUS_PARITY}
  `endif//}
  
  ////INTERNAL_CODE_BEGIN
  //`ifdef N100_LM_ITF_TYPE_ICB //{
  //    // Do not support the burst and lock transactions
  //output             dlm_icb_cmd_valid, 
  //input              dlm_icb_cmd_ready, 
  //output [1-1:0]     dlm_icb_cmd_read, 
  //output [`N100_DLM_ADDR_WIDTH-1:0]    dlm_icb_cmd_addr, 
  //output [`N100_DLM_DATA_WIDTH-1:0]    dlm_icb_cmd_wdata, 
  //output [`N100_DLM_WMSK_WIDTH-1:0]  dlm_icb_cmd_wmask,
  //output [2-1:0]  dlm_icb_cmd_size,
  //output             dlm_icb_cmd_dmode, 
  //output             dlm_icb_cmd_mmode, 

  //input              dlm_icb_rsp_valid, 
  //output             dlm_icb_rsp_ready, 
  //input              dlm_icb_rsp_err,
  //input  [`N100_DLM_DATA_WIDTH-1:0]    dlm_icb_rsp_rdata, 
  //`endif//}
  ////INTERNAL_CODE_END
      `endif//N100_HAS_DLM}

  `ifdef N100_HAS_ICACHE //{
    // The signal to disable I-Cache initialization process
  input                            icache_disable_init,

  output                           icache_tag0_cs,  
  output                           icache_tag0_we,  
  output [`N100_ICACHE_TAG_RAM_AW-1:0] icache_tag0_addr, 
  output [`N100_ICACHE_TAG_RAM_DW-1:0] icache_tag0_wdata,          
  input  [`N100_ICACHE_TAG_RAM_DW-1:0] icache_tag0_rdata,
  output                       clk_icache_tag0,

  output                           icache_data0_cs,  
  output                           icache_data0_we,  
  output [`N100_ICACHE_DATA_RAM_AW-1:0] icache_data0_addr, 
  output [`N100_ICACHE_DATA_RAM_DW-1:0] icache_data0_wdata,          
  input  [`N100_ICACHE_DATA_RAM_DW-1:0] icache_data0_rdata,
  output                       clk_icache_data0,

       `ifdef N100_ICACHE_2WAYS//{
  output                           icache_tag1_cs,  
  output                           icache_tag1_we,  
  output [`N100_ICACHE_TAG_RAM_AW-1:0] icache_tag1_addr, 
  output [`N100_ICACHE_TAG_RAM_DW-1:0] icache_tag1_wdata,          
  input  [`N100_ICACHE_TAG_RAM_DW-1:0] icache_tag1_rdata,
  output                       clk_icache_tag1,

  
  output                           icache_data1_cs,  
  output                           icache_data1_we,  
  output [`N100_ICACHE_DATA_RAM_AW-1:0] icache_data1_addr, 
  output [`N100_ICACHE_DATA_RAM_DW-1:0] icache_data1_wdata,          
  input  [`N100_ICACHE_DATA_RAM_DW-1:0] icache_data1_rdata,
  output                       clk_icache_data1,

      `endif//}
  `endif//N100_HAS_ICACHE}


  `ifdef N100_HAS_MEM_ITF //{
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The System Memory Interface
  //
//  //INTERNAL_CODE_BEGIN
//      `ifdef N100_MEM_TYPE_ICB //{
//  output                         mem_icb_cmd_valid,
//  input                          mem_icb_cmd_ready,
//  output [`N100_ADDR_SIZE-1:0]   mem_icb_cmd_addr, 
//  output                         mem_icb_cmd_read, 
//  output                         mem_icb_cmd_dmode, 
//  output                         mem_icb_cmd_mmode, 
//  output [`N100_XLEN-1:0]        mem_icb_cmd_wdata,
//  output [`N100_XLEN_MW-1:0]      mem_icb_cmd_wmask,
//  output [2:0]                   mem_icb_cmd_burst,
//  output [1:0]                   mem_icb_cmd_beat,
//  output                         mem_icb_cmd_lock,
//  output                         mem_icb_cmd_excl,
//  output [1:0]                   mem_icb_cmd_size,
//  
//  input                          mem_icb_rsp_valid,
//  output                         mem_icb_rsp_ready,
//  input                          mem_icb_rsp_err  ,
//  input                          mem_icb_rsp_excl_ok,
//  input  [`N100_XLEN-1:0]        mem_icb_rsp_rdata,
//      `endif//}
//  //INTERNAL_CODE_END
      `ifdef N100_MEM_TYPE_ICB //{
  //    * Bus cmd channel
  output                         mem_icb_cmd_valid,
  input                          mem_icb_cmd_ready,
  output [`N100_ADDR_SIZE-1:0]   mem_icb_cmd_addr, 
  output                         mem_icb_cmd_read, 
  output [`N100_XLEN-1:0]        mem_icb_cmd_wdata,
  output [`N100_XLEN_MW-1:0]     mem_icb_cmd_wmask,
//  output [2:0]                   mem_icb_cmd_burst,
//  output [1:0]                   mem_icb_cmd_beat,
//  output                         mem_icb_cmd_lock,
//  output                         mem_icb_cmd_excl,
  output [1:0]                   mem_icb_cmd_size,
  output [3:0]                   mem_icb_cmd_hprot,
//  output                         mem_icb_cmd_mmode, 
  output                         mem_icb_cmd_dmode, 
  //
  //    * Bus RSP channel
  input                          mem_icb_rsp_valid,
  output                         mem_icb_rsp_ready,
  input                          mem_icb_rsp_err  ,
//  input                          mem_icb_rsp_excl_ok,
  input  [`N100_XLEN-1:0]        mem_icb_rsp_rdata,
      `endif//N100_MEM_TYPE_ICB}

      `ifdef N100_MEM_TYPE_AHBL //{
        `ifdef N100_HAS_NDSE
          `ifdef N100_MEM_CLOCK_RATIO
  input                            bus_clk_en,
          `endif//N100_MEM_CLOCK_RATIO
        `endif//N100_HAS_NDSE

  output [1:0]                     htrans, // Can be IDLE, NONSEQUENTIAL, OR SEQUENTIAL (if Cache is configured) 
  output                           hwrite,   
  output [`N100_ADDR_SIZE    -1:0] haddr,    
  output [2:0]                     hsize,  //Can be 8, 16, or 32 bits  
  output [2:0]                     hburst, // If instruction fetch not from I-Cache, it is SINGLE (3'b000) 
                                                    // If data access not from D-Cache, it is INCR (3'b001) 
                                                    // If instruction fetch from I-Cache, it is INCR8 (3'b101) (8-beat incrementing burst) 
                                                    //   since the ICache Line-Size is 32Bytes long
                                                    // If data access from D-Cache, it is WRAP8 (3'b100)  (8-beat wrapping burst) 
                                                    //   since the DCache Line-Size is 32Bytes long
  output                           hmastlock,   
  output [`N100_XLEN    -1:0]      hwdata,   
  output [3:0]                     hprot, 
                                      //  HPROT[3:2] 
                                      //     --- If instruction fetch not from I-Cache, indicates non-cacheable (bit3 == 0) and
                                      //           non-bufferable (bit2 == 0) on this bus.
                                      //     --- If data access not from D-Cache, indicates non-cacheable (bit3 == 0) and
                                      //           non-bufferable (bit2 == 0) on this bus.
                                      //     --- If instruction fetch from I-Cache, indicates cacheable (bit3 == 1) and
                                      //           bufferable (bit2 == 1) on this bus.
                                      //     --- If data access from D-Cache, indicates cacheable (bit3 == 1) and
                                      //           bufferable (bit2 == 1) on this bus.
                                      //  HPROT[1] Indicate the machine-mode (1'b1) or user-mode (1'b0) access
                                      //  HPROT[0] Indicate this is instruction access (1'b0) or data-access (1'b1)
  //output [1:0]                     hattri, // Output Memory attributes. Bit 0 = Allocate, Bit 1 = shareable. Always 11 for this bus (shareable, allocate)
  output [1:0]                     master,
                                      //  Indicate the access under debug-mode (2'b01) 
                                      //    or regular data-access(2'b00).
                                      //    or regular instruction-fetch(2'b10).
                                      //    other values will not be seen on this interface
  input  [`N100_XLEN    -1:0]      hrdata,   
  input  [1:0]                     hresp,  // Only support response OKAY or ERROR, hence the hresp[1] bit is ignored
  input                            hready,   
       `ifdef N100_HAS_BUS_PARITY//{
  output [1:0]                     hcmdbpty,
  output [3:0]                     hwdatabpty,
  output [3:0]                     haddrbpty,
  input  [3:0]                     hrdatabpty,
  input                            hrspbpty,
  output                           phfatal,
       `endif//N100_HAS_BUS_PARITY}
      `endif//N100_MEM_TYPE_AHBL}
  `endif//N100_HAS_MEM_ITF}

  `ifdef N100_HAS_PPI //{
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The Private Peripheral Interface
  //
 // //INTERNAL_CODE_BEGIN
 //     `ifdef N100_PPI_TYPE_ICB //{
 // //    * Bus cmd channel
 // output                         ppi_icb_cmd_valid,
 // input                          ppi_icb_cmd_ready,
 // output [`N100_ADDR_SIZE-1:0]   ppi_icb_cmd_addr, 
 // output                         ppi_icb_cmd_read, 
 // output                         ppi_icb_cmd_dmode, 
 // output                         ppi_icb_cmd_mmode, 
 // output [`N100_XLEN-1:0]        ppi_icb_cmd_wdata,
 // output [`N100_XLEN_MW-1:0]      ppi_icb_cmd_wmask,
 // //
 // //    * Bus RSP channel
 // input                          ppi_icb_rsp_valid,
 // output                         ppi_icb_rsp_ready,
 // input                          ppi_icb_rsp_err  ,
 // input  [`N100_XLEN-1:0]        ppi_icb_rsp_rdata,
 //     `endif//}
 // //INTERNAL_CODE_END

      `ifdef N100_PPI_TYPE_APB //{
  output [`N100_PPI_ADDR_WIDTH-1:0]   ppi_paddr,
  output                        ppi_pwrite,
  output                        ppi_psel,
  output                        ppi_dmode,
  output                        ppi_penable,
  output [2:0]                  ppi_pprot,
  output [3:0]                  ppi_pstrobe,
  output [32-1:0]               ppi_pwdata,
  input  [32-1:0]               ppi_prdata,
  input                         ppi_pready ,
  input                         ppi_pslverr,
      `endif//}

  `endif//N100_HAS_PPI}

  `ifdef N100_HAS_FIO //{
  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The ICB Interface to Fast I/O
  //
  //    * Bus cmd channel
  output                        fio_cmd_valid,
  output [`N100_FIO_ADDR_WIDTH-1:0]   fio_cmd_addr, 
  output                        fio_cmd_read, 
  output                        fio_cmd_dmode, 
  output                        fio_cmd_mmode, 
  output [`N100_XLEN-1:0]        fio_cmd_wdata,
  output [`N100_XLEN_MW-1:0]      fio_cmd_wmask,
  //
  //    * Bus RSP channel
  input                         fio_rsp_err  ,
  input  [`N100_XLEN-1:0]        fio_rsp_rdata,
  `endif//N100_HAS_FIO}


  //////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////
  // The LM Slave Interface 
      `ifdef N100_HAS_LM_SLAVE//{

  `ifdef N100_LM_SALVE_AHBL //{
  input              slv_huser,
  input              slv_hsel,   
  input  [1:0]       slv_htrans,   
  input              slv_hwrite,   
  input  [`N100_ADDR_SIZE    -1:0]slv_haddr,    
  input  [2:0]       slv_hsize,    
  input  [`N100_XLEN-1:0]slv_hwdata,   

  output  [`N100_XLEN-1:0]slv_hrdata,   
  output [1:0]       slv_hresp,    
  input              slv_hready_in,   
  output             slv_hready_out,   
  `endif//}

  `ifdef N100_LM_SALVE_ICB //{
  // External ICB
  input             slv_icb_cmd_valid, 
  output            slv_icb_cmd_ready, 
  input  [`N100_ADDR_SIZE-1:0]   slv_icb_cmd_addr,
  input             slv_icb_cmd_read, 
  input  [`N100_XLEN-1:0]   slv_icb_cmd_wdata, 
  input  [ 4-1:0]   slv_icb_cmd_wmask, 
  input  [ 2-1:0]   slv_icb_cmd_size, 

  output            slv_icb_rsp_valid, 
  input             slv_icb_rsp_ready, 
  output            slv_icb_rsp_err,   
  output [`N100_XLEN-1:0]   slv_icb_rsp_rdata, 
  `endif//}
      `endif//N100_HAS_LM_SLAVE}


  ///////////////////////////////////////////
      // The Event signals
  output tx_evt,// The send-out event signal as a pulse
  input  rx_evt,// The recieve-in event signal as a pulse


  ///////////////////////////////////////
      // WFI indication 
      //   If this is high, then indicating currently the core is enter into sleep mode after executed a WFI instruction
  output core_wfi_mode, 

      // The SoC can utilize this signal to differentiate several different Sleep mode
      //   If sleep_value is 0, then it is sleep-mode 0
      //   If sleep_value is 1, then it is sleep-mode 1




 
  
  //////////////////////////////////////////
  ///    // The inspection signals used to monitor some internal state
  ///output [`N100_PC_SIZE-1:0] inspect_pc,
  ///output inspect_mem_cmd_valid,
  ///output inspect_mem_cmd_ready,
  ///output inspect_mem_rsp_valid,
  ///output inspect_mem_rsp_ready,
  ///output inspect_clk     ,


 
//  `ifdef N100_HAS_ITCM//{
//  //////////////////////////////////////////////////////////////
//  //////////////////////////////////////////////////////////////
//  // External-agent ICB to ITCM
//  //    * Bus cmd channel
//  input                          ext2itcm_icb_cmd_valid,
//  output                         ext2itcm_icb_cmd_ready,
//  input  [`N100_ITCM_ADDR_WIDTH-1:0]   ext2itcm_icb_cmd_addr, 
//  input                          ext2itcm_icb_cmd_read, 
//  input  [`N100_XLEN-1:0]        ext2itcm_icb_cmd_wdata,
//  input  [`N100_XLEN_MW-1:0]      ext2itcm_icb_cmd_wmask,
//  //
//  //    * Bus RSP channel
//  output                         ext2itcm_icb_rsp_valid,
//  input                          ext2itcm_icb_rsp_ready,
//  output                         ext2itcm_icb_rsp_err  ,
//  output [`N100_XLEN-1:0]        ext2itcm_icb_rsp_rdata,
//  `endif//N100_HAS_ITCM}
//
//  `ifdef N100_HAS_DTCM//{
//  //////////////////////////////////////////////////////////////
//  //////////////////////////////////////////////////////////////
//  // External-agent ICB to DTCM
//  //    * Bus cmd channel
//  input                          ext2dtcm_icb_cmd_valid,
//  output                         ext2dtcm_icb_cmd_ready,
//  input  [`N100_DTCM_ADDR_WIDTH-1:0]   ext2dtcm_icb_cmd_addr, 
//  input                          ext2dtcm_icb_cmd_read, 
//  input  [`N100_XLEN-1:0]        ext2dtcm_icb_cmd_wdata,
//  input  [`N100_XLEN_MW-1:0]      ext2dtcm_icb_cmd_wmask,
//  //
//  //    * Bus RSP channel
//  output                         ext2dtcm_icb_rsp_valid,
//  input                          ext2dtcm_icb_rsp_ready,
//  output                         ext2dtcm_icb_rsp_err  ,
//  output [`N100_XLEN-1:0]        ext2dtcm_icb_rsp_rdata,
//  `endif//N100_HAS_DTCM}
  
//  `ifdef N100_HAS_TCM //{
//    // The PMU control signal from PMU to control the TCM Shutdown
//  input tcm_sd,
//    // The PMU control signal from PMU to control the TCM Deep-Sleep
//  input tcm_ds,
//  `endif//N100_HAS_TCM//}


  `ifdef N100_HAS_NICE //{
      // The NICE interface
    input nice_mem_holdup  , //O: nice occupys the memory. for avoid of dead-loop®
    //input nice_rsp_err_irq  , //O: nice occupys the memory. for avoid of dead-loop®
    // nice_req interface
    output nice_req_valid  , //O: handshake flag, cmd is valid
    input  nice_req_ready  , //I: handshake flag, cmd is accepted.
    output [`N100_XLEN-1:0] nice_req_inst  , // O: inst sent to nice. 
    output [`N100_XLEN-1:0] nice_req_rs1   , // O: rs op 1.
    output [`N100_XLEN-1:0] nice_req_rs2   , // O: rs op 2.
    output nice_req_mmode  , //O: mmode 

    // icb_cmd_rsp interface
    // for one cycle insn, the rsp data is valid at the same time of insn, so
    // the handshake flags is useless.
    input                   nice_rsp_1cyc_type    , //I: current insn is one cycle.
    input [`N100_XLEN-1:0]  nice_rsp_1cyc_dat    , //I: one cycle result write-back val.
    input                   nice_rsp_1cyc_err,
     
                                              
    input                   nice_rsp_multicyc_valid , //I: current insn is multi-cycle.
    output                  nice_rsp_multicyc_ready , //O:                             
    input  [`N100_XLEN-1:0] nice_rsp_multicyc_dat   , //I: one cycle result write-back val.
    input                   nice_rsp_multicyc_err,

    // lsu_req interface                                         
    input  nice_icb_cmd_valid  , //I: nice access main-mem req valid.
    output nice_icb_cmd_ready  ,// O: nice access req is accepted.
    input [`N100_XLEN-1:0]  nice_icb_cmd_addr   , //I : nice access main-mem address.
    input  nice_icb_cmd_read   , //I: nice access type. 
    input [`N100_XLEN-1:0]  nice_icb_cmd_wdata  ,//I: nice write data.
    input [1:0] nice_icb_cmd_size   , //I: data size input.
    input  nice_icb_cmd_mmode  , //I: mmode 

    // lsu_rsp interface                                         
    output nice_icb_rsp_valid  , //O: main core responds result to nice.
    input  nice_icb_rsp_ready  ,// I: respond result is accepted.
    output [`N100_XLEN-1:0]  nice_icb_rsp_rdata  ,// O: rsp data.
    output nice_icb_rsp_err    , // O : err flag

  `endif//N100_HAS_NICE}

  `ifdef N100_HAS_LOCKSTEP //{
    input  lockstep_en,        
    input  lockstep_chck_en,        
    output lockstep_mis    ,     // lockstep mismatch output
    output [3:0]  lockstep_mis_cause  , // lockstep mismatch cause
  `endif//N100_HAS_LOCKSTEP}

  `ifdef N100_HAS_SCP //{
    input  scp_en ,        
    input  [31:0] trng_i ,        // need sync in SoC
    input  trng_vld_i ,        
  `endif//N100_HAS_SCP}

  ///////////////////////////////////////
  input  [`N100_XLEN-1:0] hart_id,// The hart ID indication  

  ///////////////////////////////////////
  input  [`N100_PC_SIZE-1:0] reset_vector, // The reset PC value

  output core_sleep_value 
  );



 `ifdef N100_HAS_DEBUG//{
 `ifndef N100_HAS_NDSE//{
          wire jtag_TCK_scan = scanmode ? core_clk : jtag_TCK;
 `endif//N100_HAS_NDSE//}
  `ifdef N100_HAS_NDSE//{
    `ifdef N100_HAS_DEBUG_PRIVATE //{
    `ifndef N100_JTAG_TWOWIRE
          wire jtag_tck_scan = scanmode ? core_clk : jtag_tck;
    `endif N100_JTAG_TWOWIRE
    `endif N100_HAS_DEBUG_PRIVATE //{
  `endif//N100_HAS_NDSE}
  `endif//N100_HAS_DEBUG}
  wire reset_bypass_scan = scanmode ? scanmode : reset_bypass;
  wire clkgate_bypass_scan = scanmode ? scanmode : clkgate_bypass;
  wire core_reset_n_scan = scanmode ? por_reset_n : core_reset_n;


 n100_core_wrapper u_n100_core_wrapper(

 `ifdef N100_HAS_DEBUG//{

 `ifndef N100_HAS_NDSE//{
  .jtag_TCK                           (jtag_TCK                ),
  .jtag_TMS_in                        (jtag_TMS_in             ),
  .jtag_TDI                           (jtag_TDI                ),
  .jtag_TDO                           (jtag_TDO                ),
  .jtag_DRV_TDO                       (jtag_DRV_TDO            ),
  .jtag_TMS_out                       (jtag_TMS_out            ),
  .jtag_DRV_TMS                       (jtag_DRV_TMS            ),
  .jtag_BK_TMS                        (jtag_BK_TMS             ),
  .hart_halted                        (hart_halted             ),
  .i_dbg_stop                         (i_dbg_stop              ),
  .ndmreset                           (ndmreset                ),
 `ifdef N100_DBG_TIMEOUT //{
  .dbg_toggle_a                       (dbg_toggle_a            ),
 `endif //} N100_DBG_TIMEOUT
 `endif//N100_HAS_NDSE//}             
  `ifdef N100_HAS_NDSE//{             
    `ifdef N100_HAS_DEBUG_PRIVATE //{
     `ifdef N100_JTAG_TWOWIRE       
  .sdp_tckc                           (sdp_tckc                ),
  .sdb_tmsc_in                        (sdb_tmsc_in             ),
  .sdb_tmsc_out                       (sdb_tmsc_out            ),
  .sdp_tmsc_out_en                    (sdp_tmsc_out_en         ),
    `endif // N100_JTAG_TWOWIRE      
    `ifndef N100_JTAG_TWOWIRE         
  .jtag_tck                           (jtag_tck                ),
  .jtag_tms                           (jtag_tms                ),
  .jtag_tdi                           (jtag_tdi                ),
  .jtag_tdo                           (jtag_tdo                ),
  .jtag_tdo_en                        (jtag_tdo_en             ),
    `endif // N100_JTAG_TWOWIRE     
  .disable_ext_debugger               (disable_ext_debugger    ),
  .dbg_srst_req                       (dbg_srst_req            ),
     `endif//N100_HAS_DEBUG_PRIVATE}  
    `ifndef N100_HAS_DEBUG_PRIVATE //{
  .debugint                           (debugint                ),
  .hart_unavail                       (hart_unavail            ),
  .hart_under_reset                   (hart_under_reset        ),
  .resethaltreq                       (resethaltreq            ),
     `endif//N100_HAS_DEBUG_PRIVATE}  
  .hart_halted                        (hart_halted             ),
  `ifndef N100_TMR_PRIVATE //{       
  .dbg_stoptime                       (dbg_stoptime            ),
  `endif//N100_TMR_PRIVATE}           
  `endif//N100_HAS_NDSE}              
  `endif//N100_HAS_DEBUG}             
  `ifdef N100_TRACE_ITF//{           
  .trace_ivalid                       (trace_ivalid            ),
  .trace_iexception                   (trace_iexception        ),
  .trace_interrupt                    (trace_interrupt         ),
  .trace_cause                        (trace_cause             ),
  .trace_tval                         (trace_tval              ),
  .trace_iaddr                        (trace_iaddr             ),
  .trace_instr                        (trace_instr             ),
  .trace_priv                         (trace_priv              ),
  `endif//N100_TRACE_ITF}           
  .core_clk_aon                       (core_clk                ),
  .core_clk                           (core_clk                ),
  .core_reset_n                       (core_reset_n            ),
  .por_reset_n                        (por_reset_n             ),
  .reset_bypass                       (reset_bypass            ),
  .clkgate_bypass                     (clkgate_bypass          ),
  //.nmi                                (nmi                     ),
`ifdef N100_HAS_NDSE                  
  .meip                               (meip                    ),
`endif//N100_HAS_NDSE              
    `ifndef N100_TMR_PRIVATE //{  
  .mtip                               (mtip                    ),
  .msip                               (msip                    ),
    `endif//N100_TMR_PRIVATE}    
    `ifdef N100_TMR_PRIVATE //{ 
      `ifdef N100_MSIP_COEXIST 
  .msip_coex                          (msip_coex               ),
      `endif//N100_MSIP_COEXIST}      
    `endif//N100_TMR_PRIVATE}        
    `ifdef N100_TMR_PRIVATE //{       
  .mtime_toggle_a                     (mtime_toggle_a          ),
    `endif//N100_TMR_PRIVATE}        
    `ifdef N100_HAS_CLIC//{         
  .clic_irq                           (clic_irq                ),
    `endif//N100_HAS_CLIC//}       
`ifdef N100_HAS_BUS_PARITY //{    
  .bptylvl                            (bptylvl                 ),
`endif//N100_HAS_BUS_PARITY}     
     `ifdef N100_HAS_ILM //{    
  `ifdef N100_LM_ITF_TYPE_SRAM //{    
  .ilm_cs                             (ilm_cs                  ),
  .ilm_addr                           (ilm_addr                ),
  .ilm_byte_we                        (ilm_byte_we             ),
  .ilm_wdata                          (ilm_wdata               ),
  .ilm_rdata                          (ilm_rdata               ),
  .clk_ilm_ram                        (clk_ilm_ram             ),
  `endif//}                          
  `ifdef N100_LM_ITF_TYPE_AHBL //{  
  .ilm_htrans                         (ilm_htrans              ),
  .ilm_hwrite                         (ilm_hwrite              ),
  .ilm_hmastlock                      (ilm_hmastlock           ),
  .ilm_hwdata                         (ilm_hwdata              ),
  .ilm_haddr                          (ilm_haddr               ),
  .ilm_hsize                          (ilm_hsize               ),
  .ilm_hburst                         (ilm_hburst              ),
  .ilm_hprot                          (ilm_hprot               ),
  .ilm_hrdata                         (ilm_hrdata              ),
  .ilm_hresp                          (ilm_hresp               ),
  .ilm_hready                         (ilm_hready              ),
       `ifdef N100_HAS_BUS_PARITY//{  
  .ilm_hcmdbpty                       (ilm_hcmdbpty            ),
  .ilm_hwdatabpty                     (ilm_hwdatabpty          ),
  .ilm_haddrbpty                      (ilm_haddrbpty           ),
  .ilm_hrdatabpty                     (ilm_hrdatabpty          ),
  .ilm_hrspbpty                       (ilm_hrspbpty            ),
  .ilm_phfatal                        (ilm_phfatal             ),
       `endif//N100_HAS_BUS_PARITY}  
  `endif//}                         
      `endif//N100_HAS_ILM}        
     `ifdef N100_HAS_DLM //{      
  `ifdef N100_LM_ITF_TYPE_SRAM //{
  .dlm_cs                             (dlm_cs                  ),
  .dlm_addr                           (dlm_addr                ),
  .dlm_byte_we                        (dlm_byte_we             ),
  .dlm_wdata                          (dlm_wdata               ),
  .dlm_rdata                          (dlm_rdata               ),
  .clk_dlm_ram                        (clk_dlm_ram             ),
  `endif//}                           
  `ifdef N100_LM_ITF_TYPE_AHBL //{    
  .dlm_htrans                         (dlm_htrans              ),
  .dlm_hwrite                         (dlm_hwrite              ),
  .dlm_hmastlock                      (dlm_hmastlock           ),
  .dlm_haddr                          (dlm_haddr               ),
  .dlm_hsize                          (dlm_hsize               ),
  .dlm_hburst                         (dlm_hburst              ),
  .dlm_hprot                          (dlm_hprot               ),
  .dlm_master                         (dlm_master              ),
  .dlm_hwdata                         (dlm_hwdata              ),
  .dlm_hrdata                         (dlm_hrdata              ),
  .dlm_hresp                          (dlm_hresp               ),
  .dlm_hready                         (dlm_hready              ),
       `ifdef N100_HAS_BUS_PARITY//{ 
  .dlm_hcmdbpty                       (dlm_hcmdbpty            ),
  .dlm_hwdatabpty                     (dlm_hwdatabpty          ),
  .dlm_haddrbpty                      (dlm_haddrbpty           ),
  .dlm_hrdatabpty                     (dlm_hrdatabpty          ),
  .dlm_hrspbpty                       (dlm_hrspbpty            ),
  .dlm_phfatal                        (dlm_phfatal             ),
       `endif//N100_HAS_BUS_PARITY}  
  `endif//}                           
      `endif//N100_HAS_DLM}         
  `ifdef N100_HAS_ICACHE //{       
  .icache_disable_init                (icache_disable_init     ),
  .icache_tag0_cs                     (icache_tag0_cs          ),
  .icache_tag0_we                     (icache_tag0_we          ),
  .icache_tag0_addr                   (icache_tag0_addr        ),
  .icache_tag0_wdata                  (icache_tag0_wdata       ),
  .icache_tag0_rdata                  (icache_tag0_rdata       ),
  .clk_icache_tag0                    (clk_icache_tag0         ),
  .icache_data0_cs                    (icache_data0_cs         ),
  .icache_data0_we                    (icache_data0_we         ),
  .icache_data0_addr                  (icache_data0_addr       ),
  .icache_data0_wdata                 (icache_data0_wdata      ),
  .icache_data0_rdata                 (icache_data0_rdata      ),
  .clk_icache_data0                   (clk_icache_data0        ),
       `ifdef N100_ICACHE_2WAYS//{    
  .icache_tag1_cs                     (icache_tag1_cs          ),
  .icache_tag1_we                     (icache_tag1_we          ),
  .icache_tag1_addr                   (icache_tag1_addr        ),
  .icache_tag1_wdata                  (icache_tag1_wdata       ),
  .icache_tag1_rdata                  (icache_tag1_rdata       ),
  .clk_icache_tag1                    (clk_icache_tag1         ),
  .icache_data1_cs                    (icache_data1_cs         ),
  .icache_data1_we                    (icache_data1_we         ),
  .icache_data1_addr                  (icache_data1_addr       ),
  .icache_data1_wdata                 (icache_data1_wdata      ),
  .icache_data1_rdata                 (icache_data1_rdata      ),
  .clk_icache_data1                   (clk_icache_data1        ),
      `endif//}                      
  `endif//N100_HAS_ICACHE}          
  `ifdef N100_HAS_MEM_ITF //{      

      `ifdef N100_MEM_TYPE_ICB //{
    .mem_icb_cmd_valid     (mem_icb_cmd_valid),
    .mem_icb_cmd_ready     (mem_icb_cmd_ready),
    .mem_icb_cmd_addr      (mem_icb_cmd_addr ),
//    .mem_icb_cmd_mmode     (mem_icb_cmd_mmode),
    .mem_icb_cmd_dmode     (mem_icb_cmd_dmode),
    .mem_icb_cmd_read      (mem_icb_cmd_read ),
    .mem_icb_cmd_wdata     (mem_icb_cmd_wdata),
    .mem_icb_cmd_wmask     (mem_icb_cmd_wmask),
//    .mem_icb_cmd_lock      (mem_icb_cmd_lock ),
//    .mem_icb_cmd_excl      (mem_icb_cmd_excl ),
    .mem_icb_cmd_size      (mem_icb_cmd_size ),
    .mem_icb_cmd_hprot     (mem_icb_cmd_hprot),
//    .mem_icb_cmd_burst     (mem_icb_cmd_burst),
//    .mem_icb_cmd_beat      (mem_icb_cmd_beat ),
    
    .mem_icb_rsp_valid     (mem_icb_rsp_valid),
    .mem_icb_rsp_ready     (mem_icb_rsp_ready),
    .mem_icb_rsp_err       (mem_icb_rsp_err  ),
//    .mem_icb_rsp_excl_ok   (mem_icb_rsp_excl_ok  ),
    .mem_icb_rsp_rdata     (mem_icb_rsp_rdata),
      `endif//N100_MEM_TYPE_ICB}

      `ifdef N100_MEM_TYPE_AHBL //{   
        `ifdef N100_HAS_NDSE         
          `ifdef N100_MEM_CLOCK_RATIO 
  .bus_clk_en                         (bus_clk_en              ),
          `endif//N100_MEM_CLOCK_RATIO
        `endif//N100_HAS_NDSE        
  .htrans                             (htrans                  ),
  .hwrite                             (hwrite                  ),
  .haddr                              (haddr                   ),
  .hsize                              (hsize                   ),
  .hburst                             (hburst                  ),
  .hmastlock                          (hmastlock               ),
  .hwdata                             (hwdata                  ),
  .hprot                              (hprot                   ),
  .master                             (master                  ),
  .hrdata                             (hrdata                  ),
  .hresp                              (hresp                   ),
  .hready                             (hready                  ),
       `ifdef N100_HAS_BUS_PARITY//{  
  .hcmdbpty                           (hcmdbpty                ),
  .hwdatabpty                         (hwdatabpty              ),
  .haddrbpty                          (haddrbpty               ),
  .hrdatabpty                         (hrdatabpty              ),
  .hrspbpty                           (hrspbpty                ),
  .phfatal                            (phfatal                 ),
       `endif//N100_HAS_BUS_PARITY}  
      `endif//N100_MEM_TYPE_AHBL}   
  `endif//N100_HAS_MEM_ITF}        
  `ifdef N100_HAS_PPI //{         
      `ifdef N100_PPI_TYPE_APB //{    
  .ppi_paddr                          (ppi_paddr               ),
  .ppi_pwrite                         (ppi_pwrite              ),
  .ppi_psel                           (ppi_psel                ),
  .ppi_dmode                          (ppi_dmode               ),
  .ppi_penable                        (ppi_penable             ),
  .ppi_pprot                          (ppi_pprot               ),
  .ppi_pstrobe                        (ppi_pstrobe             ),
  .ppi_pwdata                         (ppi_pwdata              ),
  .ppi_prdata                         (ppi_prdata              ),
  .ppi_pready                         (ppi_pready              ),
  .ppi_pslverr                        (ppi_pslverr             ),
      `endif//}                       
  `endif//N100_HAS_PPI}              
  `ifdef N100_HAS_FIO //{           
  .fio_cmd_valid                      (fio_cmd_valid           ),
  .fio_cmd_addr                       (fio_cmd_addr            ),
  .fio_cmd_read                       (fio_cmd_read            ),
  .fio_cmd_dmode                      (fio_cmd_dmode           ),
  .fio_cmd_mmode                      (fio_cmd_mmode           ),
  .fio_cmd_wdata                      (fio_cmd_wdata           ),
  .fio_cmd_wmask                      (fio_cmd_wmask           ),
  .fio_rsp_err                        (fio_rsp_err             ),
  .fio_rsp_rdata                      (fio_rsp_rdata           ),
  `endif//N100_HAS_FIO}               
      `ifdef N100_HAS_LM_SLAVE//{    
  `ifdef N100_LM_SALVE_AHBL //{     
  .slv_huser                          (slv_huser               ),
  .slv_hsel                           (slv_hsel                ),
  .slv_htrans                         (slv_htrans              ),
  .slv_hwrite                         (slv_hwrite              ),
  .slv_haddr                          (slv_haddr               ),
  .slv_hsize                          (slv_hsize               ),
  .slv_hwdata                         (slv_hwdata              ),
  .slv_hrdata                         (slv_hrdata              ),
  .slv_hresp                          (slv_hresp               ),
  .slv_hready_in                      (slv_hready_in           ),
  .slv_hready_out                     (slv_hready_out          ),
  `endif//}                           
  `ifdef N100_LM_SALVE_ICB //{       
  .slv_icb_cmd_valid                  (slv_icb_cmd_valid       ),
  .slv_icb_cmd_ready                  (slv_icb_cmd_ready       ),
  .slv_icb_cmd_addr                   (slv_icb_cmd_addr        ),
  .slv_icb_cmd_read                   (slv_icb_cmd_read        ),
  .slv_icb_cmd_wdata                  (slv_icb_cmd_wdata       ),
  .slv_icb_cmd_wmask                  (slv_icb_cmd_wmask       ),
  .slv_icb_cmd_size                   (slv_icb_cmd_size        ),
  .slv_icb_rsp_valid                  (slv_icb_rsp_valid       ),
  .slv_icb_rsp_ready                  (slv_icb_rsp_ready       ),
  .slv_icb_rsp_err                    (slv_icb_rsp_err         ),
  .slv_icb_rsp_rdata                  (slv_icb_rsp_rdata       ),
  `endif//}                         
      `endif//N100_HAS_LM_SLAVE}   
  .tx_evt                             (tx_evt                  ),
  .rx_evt                             (rx_evt                  ),
  .core_wfi_mode                      (core_wfi_mode           ),
  `ifdef N100_HAS_NICE //{        
    .nice_mem_holdup                  (nice_mem_holdup       ),
    .nice_req_valid                   (nice_req_valid        ),
    .nice_req_ready                   (nice_req_ready        ),
    .nice_req_inst                    (nice_req_inst         ),
    .nice_req_rs1                     (nice_req_rs1          ),
    .nice_req_rs2                     (nice_req_rs2          ),
    .nice_req_mmode                   (nice_req_mmode        ),
    .nice_rsp_1cyc_type               (nice_rsp_1cyc_type    ),
    .nice_rsp_1cyc_dat                (nice_rsp_1cyc_dat     ),
    .nice_rsp_1cyc_err                (nice_rsp_1cyc_err     ),
    .nice_rsp_multicyc_valid          (nice_rsp_multicyc_valid),
    .nice_rsp_multicyc_ready          (nice_rsp_multicyc_read),
    .nice_rsp_multicyc_dat            (nice_rsp_multicyc_dat ),
    .nice_rsp_multicyc_err            (nice_rsp_multicyc_err ),
    .nice_icb_cmd_valid               (nice_icb_cmd_valid    ),
    .nice_icb_cmd_ready               (nice_icb_cmd_ready    ),
    .nice_icb_cmd_addr                (nice_icb_cmd_addr     ),
    .nice_icb_cmd_read                (nice_icb_cmd_read     ),
    .nice_icb_cmd_wdata               (nice_icb_cmd_wdata    ),
    .nice_icb_cmd_size                (nice_icb_cmd_size     ),
    .nice_icb_cmd_mmode               (nice_icb_cmd_mmode    ),
    .nice_icb_rsp_valid               (nice_icb_rsp_valid    ),
    .nice_icb_rsp_ready               (nice_icb_rsp_ready    ),
    .nice_icb_rsp_rdata               (nice_icb_rsp_rdata    ),
    .nice_icb_rsp_err                 (nice_icb_rsp_err      ),
  `endif//N100_HAS_NICE}              
  `ifdef N100_HAS_LOCKSTEP //{        
    .lockstep_en                      (lockstep_en           ),
    .lockstep_chck_en                 (lockstep_chck_en      ),
    .lockstep_mis                     (lockstep_mis          ),
    .lockstep_mis_cause               (lockstep_mis_cause    ),
  `endif//N100_HAS_LOCKSTEP}         
  `ifdef N100_HAS_SCP //{           
    .scp_en                           (scp_en                ),
    .trng_i                           (trng_i                ),
    .trng_vld_i                       (trng_vld_i            ),
  `endif//N100_HAS_SCP}            
  .hart_id                            (hart_id                 ),
  .reset_vector                       (reset_vector            ),
  .core_sleep_value                   (core_sleep_value        )
  );

endmodule
