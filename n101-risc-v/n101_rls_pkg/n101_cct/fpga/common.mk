# See LICENSE for license details.

# Required variables:
# - PROJECT
# - CONFIG_PROJECT
# - CONFIG
# - FPGA_DIR

CORE := n101
HACK_ID := 0

PATCHVERILOG ?= ""



base_dir := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))


	#sed -i 's/1000563D/1e200a6d/'  ${INSTALL_RTL}/core/${CORE}_dtm_tap.v// Nuclei
	#sed -i 's/1000563D/10e31913/'  ${INSTALL_RTL}/core/${CORE}_dtm_tap.v// SiFive

# Install RTLs
install: 
	mkdir -p ${PWD}/install
	cp ${PWD}/../${CORE}/design ${INSTALL_RTL} -rf
	cp ${PWD}/${FPGA_NAME}/src/system.org ${INSTALL_RTL}/system.v -rf
	sed -i 's/n100/${CORE}/g' ${INSTALL_RTL}/system.v
	sed -i '1i\`define FPGA_SOURCE\'  ${INSTALL_RTL}/core/${CORE}_defines.v
	rm -rf  ${INSTALL_RTL}/asic

EXTRA_FPGA_VSRCS := 
verilog := $(wildcard ${INSTALL_RTL}/*/*.v)
verilog += $(wildcard ${INSTALL_RTL}/*.v)


# Build .mcs
.PHONY: mcs
mcs : install
	BASEDIR=${base_dir} VSRCS="$(verilog)" EXTRA_VSRCS="$(EXTRA_FPGA_VSRCS)" $(MAKE) -C $(FPGA_DIR) mcs


# Build .bit
.PHONY: bit
bit : install
	BASEDIR=${base_dir} VSRCS="$(verilog)" EXTRA_VSRCS="$(EXTRA_FPGA_VSRCS)" $(MAKE) -C $(FPGA_DIR) bit


.PHONY: setup
setup: 
	BASEDIR=${base_dir} VSRCS="$(verilog)" EXTRA_VSRCS="$(EXTRA_FPGA_VSRCS)" $(MAKE) -C $(FPGA_DIR) setup



.PHONY: verdi
verdi: 
	ls ${INSTALL_RTL}/*/*.v -1 >& fpga_flist
	verdi -sverilog +v2k +incdir+${INSTALL_RTL}/perips+${INSTALL_RTL}/core -f fpga_flist &

.PHONY: vcs
vcs: 
	ls ${INSTALL_RTL}/*/*.v -1 >& fpga_flist
	vcs -full64 -sverilog +v2k +incdir+${INSTALL_RTL}/perips+${INSTALL_RTL}/core -f fpga_flist &

# Clean
.PHONY: clean
clean:
	$(MAKE) -C $(FPGA_DIR) clean
	rm -rf fpga_flist
	rm -rf install
	rm -rf vivado.*
	rm -rf novas.*

