if {[file exists [which ${DCRM_SDC_INPUT_FILE}]]} {
  puts "RM-Info: Reading SDC file [which ${DCRM_SDC_INPUT_FILE}]\n"
  read_sdc ${DCRM_SDC_INPUT_FILE}
}

set_load [expr [load_of/A1]*5] [all_outputs] 
set_driving_cell -no_design_rule -lib_cell -pin Z [remove_from_collection [all_inputs] [all_clocks]]
set_ideal_network -no_propagate por_reset_n
#set_operating_conditions -max_library scc018ug_uhd_rvt_ss_v1p08_125c_basic -max ss_v1p08_125c -min_library scc018ug_uhd_rvt_ff_v1p98_-40c_basic -min ff_v1p98_-40c

#set_dont_touch_network {OTPVDD OTPVSS OTPVPP}
