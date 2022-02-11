###USER DEFINED
FREQUENCY             := 80
PERIOD                := $(shell echo "scale=4; 1000 / ${FREQUENCY}" | bc)

LIB                   := scc011ums_uhd_rvt_ss_v1p08_125c_ccs
LIBDIR                := /home/xinlai/tools/edatools/synopsys/dc_2016.03/libraries/smic110/SCC011UMS_UHD_RVT_V1p0
ADDITIONAL_SEARCH_PATH:= ${LIBDIR}/liberty/1.2v

MW_REFERENCE_LIB_DIRS := ${LIBDIR}/astro/scc011ums_uhd_rvt
TECH_FILE             := ${LIBDIR}/astro/tf_wo_ALPA/scc011u_uhd_7lm_1tm_thin.tf
TLUPLUS_MAX_FILE      := ${LIBDIR}/astro/tluplus/MIM1f/smic_011_mix_p1mt8_max_cell_1fF_9k.tluplus
TLUPLUS_MIN_FILE      := ${LIBDIR}/astro/tluplus/MIM1f/smic_011_mix_p1mt8_min_cell_1fF_9k.tluplus
MAP_FILE			  := ${LIBDIR}/astro/tluplus/MIM1f/SmicSP2P_011_mix_plmt8_cell_typ_1233_9k_1f.map
CELL_NAND             := NAND2UHDV1
CELL_BUF              := BUFUHDV1

CORE := n101
SRC_DIR               := ../n101/design



#####################

TOP                   := ${CORE}_core_top
CFG                   := ${CORE}_config

CORE_NAME = $(shell echo $(CORE) | tr a-z A-Z)
core_name = $(shell echo $(CORE) | tr A-Z a-z)


ORGS_DIR              := ${PWD}/scripts_orgs

SYN_NAME := syn_${CFG}_${FREQUENCY}MHZ_${LIB}
SYN_DIR := ${PWD}/${SYN_NAME}
BUILD_DIR := ${SYN_DIR}/builds
INSTALL_RTL := ${BUILD_DIR}/



ADDITIONAL_SEARCH_PATH += ${SYN_DIR}/results/

VSRC := $(wildcard ${SRC_DIR}/core/*.v)

all: clean install_rtl syn 

# Install RTLs
${SYN_DIR}/install_rtl.flg: $(VSRC)
	mkdir -p ${SYN_DIR}
	mkdir -p ${SYN_DIR}/logs
	mkdir -p ${BUILD_DIR}
	rm -rf ${HOME_DIR}/install_rtl.flg

	cp -rf ${ORGS_DIR}/*  ${SYN_DIR}
	cp -rf ${SRC_DIR}/* ${BUILD_DIR}
	rm -rf ${BUILD_DIR}/core/rtl.vf

	cp -rf ${ORGS_DIR}/top/n100_core_top.v ${BUILD_DIR}/core/
	sed -i 's/n100_/${core_name}_/g' ${BUILD_DIR}/core/n100_core_top.v
	sed -i 's/N100_/${CORE_NAME}_/g' ${BUILD_DIR}/core/n100_core_top.v	
	mv ${BUILD_DIR}/core/n100_core_top.v ${BUILD_DIR}/core/${core_name}_core_top.v

	mv ${SYN_DIR}/constraints/n100_core_top_dc.sdc ${SYN_DIR}/constraints/${TOP}_dc.sdc
	mv ${SYN_DIR}/constraints/n100_core_top.constraints.tcl ${SYN_DIR}/constraints/${TOP}.constraints.tcl

	sed -i 's#set libdir.*#set libdir "${LIBDIR}"#g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i '/set ADDITIONAL_SEARCH_PATH/a\append ADDITIONAL_SEARCH_PATH "${ADDITIONAL_SEARCH_PATH}"' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's#set TARGET_LIBRARY_FILES.*#set TARGET_LIBRARY_FILES "${LIB}.db"#g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's#set MW_REFERENCE_LIB_DIRS.*#set MW_REFERENCE_LIB_DIRS "${MW_REFERENCE_LIB_DIRS}"#g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's#set TECH_FILE.*#set TECH_FILE "${TECH_FILE}"#g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's#set TLUPLUS_MIN_FILE.*#set TLUPLUS_MIN_FILE "${TLUPLUS_MIN_FILE}"#g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's#set TLUPLUS_MAX_FILE.*#set TLUPLUS_MAX_FILE "${TLUPLUS_MAX_FILE}"#g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's#set MAP_FILE.*#set MAP_FILE "${MAP_FILE}"#g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's/load_of/load_of ${LIB}\/${CELL_NAND}/g' ${SYN_DIR}/constraints/${TOP}.constraints.tcl
	sed -i 's/lib_cell/lib_cell ${CELL_BUF}/g' ${SYN_DIR}/constraints/${TOP}.constraints.tcl
	sed -i '1s/core_clk_period.*/core_clk_period ${PERIOD}/g' ${SYN_DIR}/constraints/${TOP}_dc.sdc
	sed -i 's/DESIGN_NAME.*/DESIGN_NAME ${TOP}/g' ${SYN_DIR}/rm_setup/common_setup.tcl
	sed -i 's/current_design n100_core/current_design ${CORE}_core/' ${SYN_DIR}/rm_dc_scripts/dc.tcl
	sed -i 's/u_n100_ucore/u_${CORE}_ucore/' ${SYN_DIR}/rm_dc_scripts/dc.tcl

	touch ${SYN_DIR}/install_rtl.flg

install: ${SYN_DIR}/install_rtl.flg

syn: install
	cd ${SYN_DIR}; dc_shell-t -topo -f rm_dc_scripts/dc.tcl | tee logs/dc.syn.log &

clean:
	rm -rf syn_n*

.PHONY: clean all dc_syn 
