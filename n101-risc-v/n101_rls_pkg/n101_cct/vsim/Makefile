SIM_DIR     := ${PWD}
RUN_DIR      := ${PWD}/run
TESTNAME     := rv32ui-p-lb
TESTCASE     := ${RUN_DIR}/../../riscv-tests/isa/generated/${TESTNAME}
ISADIR        := ${RUN_DIR}/../../riscv-tests/isa/
ENVDIR        := ${RUN_DIR}/../../riscv-tests/env/
RVTDIR        := ${RUN_DIR}/../../riscv-tests
TESTFLIS_FILE := ${RUN_DIR}/tests_flist
ENVFLIS_FILE := ${RUN_DIR}/env_flist
DUMPWAVE     := 1
FORCE_ECC	 := 0
FORCE_IRQ    := 0
FORCE_DELAY  := 0
WFI_FORCE_IRQ    := 1
CORE := n101
CFG         := ${CORE}_config
INSTALL_TESTS := 1

SEED       := $(shell date +%Y%m%d%H%M%S)
COVERAGE    := 0

CORE_NAME = $(shell echo $(CORE) | tr a-z A-Z)
core_name = $(shell echo $(CORE) | tr A-Z a-z)


DEFINE_FILE   := ${PWD}/../${core_name}/design/core/${core_name}_defines.v

all: run_test


install: ${RUN_DIR}
	mkdir -p ${SIM_DIR}/install/tb
	rm -rf ${SIM_DIR}/install/tb/*_defines.v
	cp ${SIM_DIR}/../${core_name}/design/core/${core_name}_defines.v ${SIM_DIR}/install/tb/${core_name}_defines.v
	cp ${SIM_DIR}/../tb/* ${SIM_DIR}/install/tb/ -rf
	sed -i '/ifndef.*_HAS_DEBUG_NEW/, /endif.*_HAS_DEBUG_NEW/d' ${SIM_DIR}/install/tb/*.v
	sed -i '/ifdef.*_HAS_DEBUG_NEW/d' ${SIM_DIR}/install/tb/*.v
	sed -i '/endif.*_HAS_DEBUG_NEW/d' ${SIM_DIR}/install/tb/*.v

	sed -i "s/n100/${core_name}/g" ${SIM_DIR}/install/tb/*.v
	sed -i "s/N100/${CORE_NAME}/g" ${SIM_DIR}/install/tb/*.v


	ls -1 ${SIM_DIR}/../${core_name}/design/*/*.v >& ${RUN_DIR}/rtlonly_flist
	ls -1 ${SIM_DIR}/../${core_name}/design/core/*.v >& ${RUN_DIR}/core_flist
ifeq ($(INSTALL_TESTS),1) 
	cd ${RVTDIR}; ./clean.sh ;
	cp ${RVTDIR}/env_origs/ ${RVTDIR}/env_orig -rf
	cp ${RVTDIR}/isa_origs/ ${RVTDIR}/isa_orig -rf
	sed -i "s/n100/${core_name}/g" ${DEFINE_FILE}
	sed -i "s/N100/${CORE_NAME}/g" ${DEFINE_FILE}
	sed -i "s/n100/${core_name}/g" ${RVTDIR}/env_orig/*.h
	sed -i "s/N100/${CORE_NAME}/g" ${RVTDIR}/env_orig/*.h
	sed -i "s/n100/${core_name}/g" ${RVTDIR}/env_orig/*/*
	sed -i "s/N100/${CORE_NAME}/g" ${RVTDIR}/env_orig/*/*
	sed -i "s/n100/${core_name}/g" ${RVTDIR}/isa_orig/Makefile
	sed -i "s/N100/${CORE_NAME}/g" ${RVTDIR}/isa_orig/Makefile
	sed -i "s/n100/${core_name}/g" ${RVTDIR}/isa_orig/rv*/*
	sed -i "s/N100/${CORE_NAME}/g" ${RVTDIR}/isa_orig/rv*/*
	sed -i "s/n100/${core_name}/g" ${RVTDIR}/isa_orig/macros/*/*
	sed -i "s/N100/${CORE_NAME}/g" ${RVTDIR}/isa_orig/macros/*/*
	ls -1 ${RUN_DIR}/../../riscv-tests/isa_orig/rv*/* >& ${RUN_DIR}/tests_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/isa_orig/Makefile >> ${RUN_DIR}/tests_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/isa_orig/macros/scalar/* >> ${RUN_DIR}/tests_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env_orig/*.h  >& ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env_orig/p/*  >> ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env_orig/pm/*  >> ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env_orig/pt/*  >> ${RUN_DIR}/env_flist
	ls -1 ${RUN_DIR}/../../riscv-tests/env_orig/v/*  >> ${RUN_DIR}/env_flist
	cd ${ENVDIR}; ./clean.sh ; ./config_env.pl ${DEFINE_FILE} ${ENVFLIS_FILE}
	cd ${ISADIR}; ./clean.sh ;  rm generated -rf; ./config_test.pl ${DEFINE_FILE} ${TESTFLIS_FILE} 
	cd ${RVTDIR} ; ./clean.sh  
	cd ${ISADIR}; mkdir generated; make -C generated -f ../Makefile src_dir=../ XLEN=32 NDSE=${NDSE} 
endif

${RUN_DIR}:
	mkdir -p ${RUN_DIR}
	rm -f ${RUN_DIR}/Makefile
	ln -s ${SIM_DIR}/bin/run.makefile ${RUN_DIR}/Makefile

verilog: ${RUN_DIR}
	make verilog RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

verilog_rtlonly: ${RUN_DIR}
	make verilog_rtlonly RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

compile_rtlonly: ${RUN_DIR}
	make compile_rtlonly RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

verilog_core: ${RUN_DIR}
	make verilog_core RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

compile_core: ${RUN_DIR}
	make compile_core RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

compile: ${RUN_DIR}
	make compile CORE=${CORE} RUN_DIR=${RUN_DIR} -C ${RUN_DIR} TESTCASE=${TESTCASE} COVERAGE=${COVERAGE}

simlog: ${RUN_DIR}
	make simlog TESTCASE=${TESTCASE} RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

wave: ${RUN_DIR}
	make wave CORE=${CORE} TESTCASE=${TESTCASE} RUN_DIR=${RUN_DIR} -C ${RUN_DIR} 

run_test: compile
	make run CORE=${CORE} WFI_FORCE_IRQ=${WFI_FORCE_IRQ} FORCE_DELAY=${FORCE_DELAY} FORCE_IRQ=${FORCE_IRQ} FORCE_ECC=${FORCE_ECC} DUMPWAVE=${DUMPWAVE} TESTCASE=${TESTCASE} SEED=${SEED} RUN_DIR=${RUN_DIR} -C ${RUN_DIR} COVERAGE=${COVERAGE}

cov: ${RUN_DIR}
	make cov CORE=${CORE} TESTCASE=${TESTCASE} RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

cov_merge:
	make cov_merge RUN_DIR=${RUN_DIR} -C ${RUN_DIR}

cov_merge_batch:
	make cov_merge_batch RUN_DIR=${RUN_DIR} -C ${RUN_DIR}


ifeq ($(CORE),n101) 
SELF_TESTS := $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv32uc-p*.dump))
SELF_TESTS += $(patsubst %.dump,%,$(wildcard ${RUN_DIR}/../../riscv-tests/isa/generated/rv32ui-p*.dump))
endif


regress_prepare:
	make compile
	@-rm -rf ${RUN_DIR}/rv32*.log
regress_run:
	$(foreach tst,$(SELF_TESTS), make run_test DUMPWAVE=0 TESTCASE=$(tst);)
regress_collect:
	@-rm -rf ${RUN_DIR}/regress.res
	@find ${RUN_DIR} -name "rv32*.log" -exec bin/find_test_fail.csh {} >> ${RUN_DIR}/regress.res \;
	@cat ${RUN_DIR}/regress.res
regress: regress_prepare regress_run regress_collect 

clean:
	rm -rf run
	rm -rf install

.PHONY: compile run install clean all run_test regress regress_prepare regress_run regress_collect 

