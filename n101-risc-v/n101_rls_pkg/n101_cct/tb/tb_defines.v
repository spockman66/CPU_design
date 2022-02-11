
   //****************************************************************************************************
  // HACK-HERE:
  //  If you integrate the N100 core into your SoC, you can hack here to change the path to your SoC path
  `define CPU_SOC_TOP  tb_top.u_n100_soc_top
  `define CPU_CORE_WRAPPER `CPU_SOC_TOP.u_n100_subsys_top.u_n100_subsys_main.u_n100_core_wrapper
  `define CPU_CORE_TOP `CPU_SOC_TOP.u_n100_subsys_top.u_n100_subsys_main.u_n100_core_wrapper.u_n100_core
  `define CPU_CORE `CPU_CORE_TOP.u_n100_ucore
  `define TMR_TOP `CPU_CORE_TOP.u_n100_tmr_top
  `define TMR_MAIN `TMR_TOP.u_n100_tmr_main
  `define CLIC_TOP `CPU_CORE_TOP.u_n100_clic_top
  `define LSU `CPU_CORE.u_n100_lsu
  `define EXU `CPU_CORE.u_n100_exu
  `define EXU_EXCP `EXU.u_n100_exu_commit.u_n100_exu_excp
  `define REGFILE  `EXU.u_n100_exu_regfile
  `define IFU `CPU_CORE.u_n100_ifu
  `define IFU_ICBCTRL `IFU.u_n100_ifu_icbctrl
  `define BIU `CPU_CORE.u_n100_biu
  `define ICACHE `IFU.u_n100_icache
  `define CMT   `EXU.u_n100_exu_commit
  `define EXCP  `CMT.u_n100_exu_excp
  `define DBG   `CPU_CORE_WRAPPER.u_n100_dbg_top
  `define DBG_CSR `CPU_CORE_TOP.u_n100_dbg_csr
`ifndef N100_HAS_DEBUG_NEW//{
  `define DBG_DM `CPU_CORE_WRAPPER.u_n100_dbg_top.u_n100_debug_subsystem.n100_dm
`endif//N100_HAS_DEBUG_NEW}
`ifdef N100_HAS_DEBUG_NEW//{
  `define DBG_DM `CPU_CORE_WRAPPER.u_n100_dbg_top.u_n100_dbg.n100_dm
`endif//N100_HAS_DEBUG_NEW}
  `define CSR   `EXU.u_n100_exu_csr
  `define DECODE   `EXU.u_n100_exu_decode
  `define SUB_TOP `CPU_SOC_TOP.u_n100_subsys_top
  `define SUB_MAIN `SUB_TOP.u_n100_subsys_main
  `define SUB_LM `SUB_MAIN.u_n100_subsys_lm
  `ifdef N100_HAS_ILM
  `define ILM_CTRL `CPU_CORE_TOP.u_n100_ilm_ctrl
  `define ILM_SRAM `SUB_LM.u_n100_ilm_ram.u_n100_ilm_gnrl_ram.u_n100_sim_ram
    `ifdef N100_HAS_ECC
     `define ILM_ICB_ECC_CTRL `ILM_CTRL.u_ilm_icb_ecc_ctrl
    `endif
  `endif
  `ifdef N100_HAS_DLM
  `define DLM_CTRL `CPU_CORE_TOP.u_n100_dlm_ctrl
  `define DLM_SRAM `SUB_LM.u_n100_dlm_ram.u_n100_dlm_gnrl_ram.u_n100_sim_ram
    `ifdef N100_HAS_ECC
     `define DLM_ICB_ECC_CTRL `DLM_CTRL.u_dlm_icb_ecc_ctrl
    `endif
  `endif
  `define DLM_CTRL `CPU_CORE_TOP.u_n100_dlm_ctrl
  `define LSUAGU `EXU.u_n100_exu_alu.u_n100_exu_alu_lsuagu
  `ifdef N100_HAS_SCP//{
  `define FAKE_INSTR_GEN `CPU_CORE.u_n205_fake_instr_gen
  `endif //N100_HAS_SCP}
 
`ifdef N100_HAS_LOCKSTEP//{
  `define LOCKSTEP `CPU_SOC_TOP.u_n100_subsys_top.u_n100_subsys_main.u_n100_core_wrapper.u_n100_lockstep_cmp
  `define SLV_CPU_CORE_TOP `CPU_SOC_TOP.u_n100_subsys_top.u_n100_subsys_main.u_n100_core_wrapper.u_n100_core_slave
  `define SLV_CPU_CORE `SLV_CPU_CORE_TOP.u_n100_ucore
  `define SLV_TMR_TOP `SLV_CPU_CORE_TOP.u_n100_tmr_top
  `define SLV_TMR_MAIN `SLV_TMR_TOP.u_n100_tmr_main
  `define SLV_CLIC_TOP `SLV_CPU_CORE_TOP.u_n100_clic_top
  `define SLV_LSU `SLV_CPU_CORE.u_n100_lsu
  `define SLV_EXU `SLV_CPU_CORE.u_n100_exu
  `define SLV_EXU_EXCP `SLV_EXU.u_n100_exu_commit.u_n100_exu_excp
  `define SLV_REGFILE  `SLV_EXU.u_n100_exu_regfile
  `define SLV_IFU `SLV_CPU_CORE.u_n100_ifu
  `define SLV_IFU_ICBCTRL `SLV_IFU.u_n100_ifu_icbctrl
  `define SLV_BIU `SLV_CPU_CORE.u_n100_biu
  `define SLV_ICACHE `SLV_IFU.u_n100_icache
  `define SLV_CMT   `SLV_EXU.u_n100_exu_commit
  `define SLV_EXCP  `SLV_CMT.u_n100_exu_excp
  `define SLV_DBG_CSR `SLV_CPU_CORE_TOP.u_n100_dbg_csr
  `define SLV_CSR   `SLV_EXU.u_n100_exu_csr
  `define SLV_DECODE   `SLV_EXU.u_n100_exu_decode
  `ifdef N100_HAS_ILM
  `define SLV_ILM_CTRL `SLV_CPU_CORE_TOP.u_n100_ilm_ctrl
    `ifdef N100_HAS_ECC
     `define SLV_ILM_ICB_ECC_CTRL `SLV_ILM_CTRL.u_ilm_icb_ecc_ctrl
    `endif
  `endif
  `ifdef N100_HAS_DLM
  `define SLV_DLM_CTRL `SLV_CPU_CORE_TOP.u_n100_dlm_ctrl
    `ifdef N100_HAS_ECC
     `define SLV_DLM_ICB_ECC_CTRL `SLV_DLM_CTRL.u_dlm_icb_ecc_ctrl
    `endif
  `endif
  `define SLV_DLM_CTRL `SLV_CPU_CORE_TOP.u_n100_dlm_ctrl
  `define SLV_LSUAGU `SLV_EXU.u_n100_exu_alu.u_n100_exu_alu_lsuagu
  `ifdef N100_HAS_SCP//{
  `define SLV_FAKE_INSTR_GEN `SLV_CPU_CORE.u_n205_fake_instr_gen
  `endif //N100_HAS_SCP}
`endif//N100_HAS_LOCKSTEP}
  // HACK-HERE:

  //  If you integrate the N100 core into your SoC, you can hack here to change the path to your ILM and DLM path, this path is used to initialize the ILM to run the tests
  `define ILM_MEM  `SUB_TOP.u_n100_subsys_main.u_n100_subsys_lm.u_n100_ilm_ram.u_n100_ilm_gnrl_ram.u_n100_sim_ram.mem_r
  `define DLM_MEM  `SUB_TOP.u_n100_subsys_main.u_n100_subsys_lm.u_n100_dlm_ram.u_n100_dlm_gnrl_ram.u_n100_sim_ram.mem_r
  //
  //****************************************************************************************************
  
  `define TB_IRQ_SWITCH(tb_irq)                                                \
  initial                                                                      \
     begin                                                                     \
     #100                                                                      \
     @(chk_1st_setmtvec)                                                       \
     forever begin                                                             \
       repeat ($urandom_range(200, 300)) @(negedge tb_clk) tb_irq = 1'b1;        \
       repeat ($urandom_range(5000, 20000)) @(negedge tb_clk) tb_irq = 1'b0;     \
       if(stop_assert_irq) begin                                               \
          break;                                                               \
       end                                                                     \
     end                                                                       \
   end                                                                         \



  `define TB_IRQ_SWITCHS(tb_irq,chk_x_irq_mret)                                \
  initial begin                                                                \
     #100                                                                      \
     tb_irq = 1'b0;                                                            \
     @(chk_1st_setmtvec)                                                       \
     forever begin                                                             \
     //repeat ($urandom_range(50, 300)) @(posedge tb_clk) tb_irq = 1'b0;       \
     //repeat ($urandom_range(50, 300)) @(posedge tb_clk) tb_irq = 1'b1;       \
     repeat ($urandom_range(20000, 40000)) @(negedge tb_clk) tb_irq = 1'b0;       \
     repeat ($urandom_range(5, 10)) @(negedge tb_clk) tb_irq = 1'b1;       \
       @(chk_x_irq_mret)                                                       \
       tb_irq = 1'b0;                                                          \
       if(stop_assert_irq) begin                                               \
         break;                                                                \
       end                                                                     \
     end                                                                       \
  end                                                                          \

  `define TB_CLIC_IRQ_TRIGGER(tb_irq,chk_x_irq_mret)                                \
  initial begin                                                                \
     #100                                                                      \
     tb_irq = 1'b0;                                                            \
     @(chk_1st_setmtvec)                                                       \
     repeat ($urandom_range(200, 400)) @(negedge tb_clk);       \
     forever begin                                                            \
     repeat ($urandom_range(2000, 4000)) @(negedge tb_clk) tb_irq = 1'b0;       \
     repeat ($urandom_range(1)) @(negedge tb_clk) tb_irq = 1'b1;       \
       wait(chk_x_irq_mret|stop_assert_irq)                                                       \
       tb_irq = 1'b0;                                                          \
    end                                                                         \
  end                                                                          \

  `define RANDOM_ENA(random_reg)                                               \
  initial begin                                                                \
     #100                                                                      \
     @(chk_1st_setmtvec);                                                      \
     forever begin                                                             \
       repeat ($urandom_range(1000, 20000)) @(negedge tb_clk) random_reg = 1'b0;   \
       repeat ($urandom_range(10, 100)) @(negedge tb_clk) random_reg = 1'b1;   \
     end                                                                       \
  end                                                                          \

  `define RANDOM_SIGNAL(random_reg)                                            \
  initial begin                                                                \
     #100                                                                      \
     forever begin                                                             \
       repeat ($urandom_range(1, 2)) @(negedge tb_clk) random_reg = 1'b0;      \
       repeat ($urandom_range(1, 2)) @(negedge tb_clk) random_reg = 1'b1;      \
     end                                                                       \
  end                                                                          \

  `define FORCE_SB_ECC(force_sb, inject_ena, i, sb_dat_pos, sb_ecc_pos, sb_err_type, tb_clk)                \
  initial begin                                                                \
      #100                                                                     \
      forever begin                                                            \
        wait(inject_ena) begin                                                 \
          if(((sb_ecc_pos==i) & (sb_err_type==0)) |                            \
             ((sb_dat_pos==i) & (sb_err_type==1))) begin                                                  \
          if(force_sb)   force force_sb = 1'b0;                                \
          else           force force_sb = 1'b1;                                \
          @(posedge tb_clk) release force_sb;                                  \
          end                                                                  \
          else @(posedge tb_clk);                                              \
        end                                                                    \
      end                                                                      \
  end                                                                          \

  `define FORCE_CLT(force_irq,unforce,reforce)                                 \
  initial begin                                                                \
    force_irq = 1'b1;                                                          \
    #100                                                                       \
    forever begin                                                              \
    @(unforce)                                                                 \
    @(negedge tb_clk)                                                          \
      force_irq = 1'b0;                                                        \
    @(reforce)                                                                 \
    @(negedge tb_clk)                                                          \
      force_irq = 1'b1;                                                        \
    end                                                                        \
  end                                                                          \

  `define RELEASE_CLT(force_i,force_o,force_en,release_en)                     \
  initial begin                                                                \
	fork                                                                       \
		forever begin                                                          \
			@(force_en)                                                        \
			force force_o = force_i;                                           \
		end                                                                    \
		forever begin                                                          \
			@(release_en)                                                      \
			release force_o;                                                   \
		end                                                                    \
	join                                                                       \
  end                                                                          \

  `define QUICK_RELEASE_CLT(release_o, release_en)                             \
  initial begin                                                                \
	forever begin                                                              \
		@(release_en)                                                          \
		#1;                                                                    \
		force release_o = 0;                                                   \
		#1 release release_o;                                                  \
	end                                                                        \
  end                                                                          \

  `define QUICK_RELEASE_CLT1(release_o, release_en, tb_clk)                    \
  initial begin                                                                \
	forever begin                                                              \
		@(release_en)                                                          \
		#2                                                                     \
		@(posedge tb_clk)                                                      \
		#2                                                                     \
		force release_o = 0;                                                   \
		#1 release release_o;                                                  \
	end                                                                        \
  end                                                                          \

  `define RANDOM_PIN(random_reg)                                               \
  initial begin                                                                \
     random_reg = 1'b0;                                                        \
     #100                                                                      \
     forever begin                                                             \
       repeat ($urandom_range(50000,100000)) @(negedge hfclk) random_reg = 1'b0;   \
       repeat ($urandom_range(1000, 20000)) @(negedge hfclk) random_reg = 1'b1;   \
     end                                                                       \
  end                                                                          \


 `define RANDOM_ALL(random_reg)                                                \
  initial begin                                                                \
     #100                                                                      \
     forever begin                                                             \
       repeat ($urandom_range(100, 10000)) @(negedge hfclk) random_reg = 1'b0;    \
       repeat ($urandom_range(10, 100)) @(negedge hfclk) random_reg = 1'b1;    \
     end                                                                       \
  end                                                                          \


  `define TB_IRQ_SWITCHP(tb_irq)                                               \
  initial                                                                      \
     begin                                                                     \
     #100                                                                      \
     @(chk_1st_setmtvec)                                                       \
     forever begin                                                             \
       repeat ($urandom_range(1000, 2000)) @(negedge tb_clk) tb_irq = 1'b0;       \
       repeat ($urandom_range(1, 1)) @(negedge tb_clk) tb_irq = 1'b1;          \
       if(stop_assert_irq) begin                                               \
          break;                                                               \
       end                                                                     \
     end                                                                       \
   end                                                                         \

  `define TB_NMI_SWITCHP(tb_nmi)                                               \
  initial                                                                      \
     begin                                                                     \
     #100                                                                      \
     @(chk_1st_setmtvec)                                                       \
     forever begin                                                             \
       repeat ($urandom_range(20000, 40000)) @(negedge tb_clk) tb_nmi = 1'b0;  \
       repeat ($urandom_range(1, 1)) @(negedge tb_clk) tb_nmi = 1'b1;          \
       if(stop_assert_irq) begin                                               \
          break;                                                               \
       end                                                                     \
     end                                                                       \
   end                                                                         \
