RUN_DIR      := ${PWD}

TESTCASE     := ${RUN_DIR}/../../riscv-tools/riscv-tests/isa/generated/rv32mi-p-interrupt_all
DUMPWAVE     := 1
FORCE_DELAY    := 1
FORCE_IRQ    := 1
FORCE_ECC   :=0
WFI_FORCE_IRQ    := 1
FORCE_RESP_ERR    := 0


SMIC130LL    := 0
GATE_SIM     := 0
GATE_SDF     := 0
GATE_NOTIME  := 0

CORE := n101

N201        := n201
N203        := n203
N205        := n205
N205F       := n205f
N205FD      := n205fd
N225FD      := n225fd
N207        := n207

SEED      = $[date +%Y%m%d%H%M%S]
COVERAGE   := 1

CORE_NAME = $(shell echo $(CORE) | tr a-z A-Z)
core_name = $(shell echo $(CORE) | tr A-Z a-z)

VSRC_DIR     := ${RUN_DIR}/../../${CORE}/design
VTB_DIR      := ${RUN_DIR}/../install/tb
COVGRP_DIR   := ${VTB_DIR}/${CORE}_cov
TESTNAME     := $(notdir $(patsubst %.dump,%,${TESTCASE}.dump))
TEST_RUNDIR  := ${TESTNAME}

RTL_V_FILES		:= $(wildcard ${VSRC_DIR}/*/*.v)
RTL_V_FILES		+= $(wildcard ${VSRC_DIR}/*/*.inc)
TB_V_FILES		:= $(wildcard ${VTB_DIR}/*.v)
VDB_FILES		:= $(wildcard ${RUN_DIR}/rv32*/simv.vdb)
COVGRP_SV_FILES	:= $(wildcard ${COVGRP_DIR}/*.sv)

# The following portion is depending on the EDA tools you are using, Please add them by yourself according to your EDA vendors
SIM_TOOL      := #To-ADD: to add the simulatoin tool
SIM_TOOL      := vcs
COV_TOOL      := dve
COV_OPTIONS   := -full64 -covdir ${RUN_DIR}/${TEST_RUNDIR}/simv.vdb &
ifeq ($(COV_TOOL),dve)
COV_OPTIONS   := -full64 -covdir ${RUN_DIR}/${TEST_RUNDIR}/simv.vdb &
endif
ifeq ($(COV_TOOL),urg)
COV_OPTIONS   := urg -dir simv.vdb -report both &
endif
ifeq ($(COVERAGE), 1)
CODE_COV      := -cm line+fsm+tgl+cond+branch -cm_dir simv.vdb -cm_line contassign
COV_OPT		:= +define+ENABLE_COV
endif
SIM_OPTIONS   := #To-ADD: to add the simulatoin tool options 
SIM_OPTIONS   := +v2k -sverilog -notice -q +lint=all,noSVA-NSVU,noVCDE,noUI,noSVA-CE,noPCTIO-L,noSVA-DIU,noPORTFRC,noSVA-ICP,noNS +define+ENABLE_TB_FORCE ${COV_OPT} -debug_access+all -full64 -timescale=1ns/10ps ${CODE_COV}
SIM_OPTIONS   += -l compile.log
SIM_OPTIONS   += +incdir+"${VSRC_DIR}/core/"+"${VSRC_DIR}/subsys/"+"${VSRC_DIR}/perips/"+"${VSRC_DIR}/soc/"+"${VSRC_DIR}/fab/"+"${VSRC_DIR}/mems"+"${COVGRP_DIR}"+"${VTB_DIR}"
ifeq ($(SMIC130LL),1) 
SIM_OPTIONS   += +define+SMIC130_LL
endif
ifeq ($(GATE_SIM),1) 
SIM_OPTIONS   += +define+GATE_SIM  +lint=noIWU,noOUDPE,noPCUDPE,noSVA-ICP,noNS
endif
ifeq ($(GATE_SDF),1) 
SIM_OPTIONS   += +define+GATE_SDF
endif
ifeq ($(GATE_NOTIME),1) 
SIM_OPTIONS   += +nospecify +notimingcheck 
endif
ifeq ($(GATE_SDF_MAX),1) 
SIM_OPTIONS   += +define+SIM_MAX
endif
ifeq ($(GATE_SDF_MIN),1) 
SIM_OPTIONS   += +define+SIM_MIN
endif

SIM_EXEC      := #To-ADD: to add the simulatoin executable
SIM_EXEC      := ${RUN_DIR}/simv +plusarg_save +ntb_random_seed=${SEED} ${CODE_COV}
WAV_TOOL      := #To-ADD: to add the waveform tool
WAV_TOOL      := verdi
WAV_OPTIONS   := #To-ADD: to add the waveform tool options 
WAV_OPTIONS   := +v2k -sverilog +define+ENABLE_TB_FORCE ${COV_OPT} 
ifeq ($(SMIC130LL),1) 
WAV_OPTIONS   += +define+SMIC130_LL
endif
ifeq ($(GATE_SIM),1) 
WAV_OPTIONS   += +define+GATE_SIM  
endif
ifeq ($(GATE_SDF),1) 
WAV_OPTIONS   += +define+GATE_SDF
endif
WAV_PFIX      := #To-ADD: to add the waveform file postfix
WAV_PFIX      := fsdb

all: run

compile.flg: ${RTL_V_FILES} ${TB_V_FILES} ${COVGRP_SV_FILES}
	@-rm -rf compile.flg
ifeq ($(COVERAGE), 1)
	${SIM_TOOL} ${SIM_OPTIONS} ${RTL_V_FILES} ${COVGRP_SV_FILES} ${TB_V_FILES} ;
else
	${SIM_TOOL} ${SIM_OPTIONS} ${RTL_V_FILES} ${TB_V_FILES} ;
endif
	touch compile.flg

compile: compile.flg 

simlog: 
	gvim -p ${TESTCASE}.spike.log ${TESTCASE}.dump &

wave: 
	#gvim -p ${TESTCASE}.spike.log ${TESTCASE}.dump &
	gvim  ${TESTCASE}.dump &
ifeq ($(COVERAGE), 1)
	${WAV_TOOL} ${WAV_OPTIONS} +incdir+"${VSRC_DIR}/core/"+"${VSRC_DIR}/subsys/"+"${VSRC_DIR}/perips/"+${COVGRP_DIR}+"${VTB_DIR}"  ${RTL_V_FILES} ${TB_V_FILES} ${COVGRP_SV_FILES} -ssf ${TEST_RUNDIR}/tb_top.${WAV_PFIX} -nologo & 
else
	${WAV_TOOL} ${WAV_OPTIONS} +incdir+"${VSRC_DIR}/core/"+"${VSRC_DIR}/subsys/"+"${VSRC_DIR}/perips/"+${COVGRP_DIR}+"${VTB_DIR}"  ${RTL_V_FILES} ${TB_V_FILES} -ssf ${TEST_RUNDIR}/tb_top.${WAV_PFIX} -nologo & 
endif

verilog: 
	${WAV_TOOL} ${WAV_OPTIONS} +incdir+"${VSRC_DIR}/core/"+"${VSRC_DIR}/subsys/"+"${VSRC_DIR}/perips/"+${COVGRP_DIR}+"${VTB_DIR}"  ${RTL_V_FILES} ${TB_V_FILES} ${COVGTP_SV_FILES} -logdir ${RUN_DIR}/verdilog -nologo & 

verilog_rtlonly: 
	${WAV_TOOL} ${WAV_OPTIONS} +incdir+"${VSRC_DIR}/core/"+"${VTB_DIR}" -f ${RUN_DIR}/rtlonly_flist   & 

compile_rtlonly: 
	${SIM_TOOL} ${SIM_OPTIONS} +incdir+"${VSRC_DIR}/core/"+"${VTB_DIR}" -f ${RUN_DIR}/rtlonly_flist    

verilog_core: 
	${WAV_TOOL} ${WAV_OPTIONS} +incdir+"${VSRC_DIR}/core/"+"${VTB_DIR}" -f ${RUN_DIR}/core_flist   & 

compile_core: 
	${SIM_TOOL} ${SIM_OPTIONS} +incdir+"${VSRC_DIR}/core/"+"${VTB_DIR}" -f ${RUN_DIR}/core_flist    

cov:
	${COV_TOOL} ${COV_OPTIONS}

cov_merge:
	urg -dir ${VDB_FILES} merged/simv.vdb -dbname merged/simv.vdb
	${COV_TOOL} -full64 -covdir ${RUN_DIR}/merged/simv.vdb &

cov_merge_batch:
	urg -dir ${VDB_FILES} merged/simv.vdb -dbname merged/simv.vdb


run: compile
	rm -rf ${TEST_RUNDIR}
	mkdir -p ${TEST_RUNDIR}
    ifeq ($(COVERAGE), 1)
	cp -r simv.vdb ${TEST_RUNDIR}/simv.vdb
    endif
	cd ${TEST_RUNDIR}; ${SIM_EXEC} +WFI_FORCE_IRQ=${WFI_FORCE_IRQ} +FORCE_DELAY=${FORCE_DELAY}  +FORCE_IRQ=${FORCE_IRQ} +FORCE_ECC=${FORCE_ECC} +FORCE_RESP_ERR=${FORCE_RESP_ERR}  +DUMPWAVE=${DUMPWAVE} +TESTCASE=${TESTCASE} +SEED=${SEED} COVERAGE=${COVERAGE} |& tee ${TESTNAME}.log; cd ${RUN_DIR}; 


.PHONY: run clean all 

