if {$synopsys_program_name == "dc_shell"}  {

    set tech_dont_use "CLK*"
    foreach dont_use $tech_dont_use {
        set_dont_use [get_lib_cells */$dont_use]
    }
}
if {$synopsys_program_name == "icc_shell"}  {
    #set di_box  [get_attribute [get_die_area] bbox]
    #set di_mmg [lindex [lindex $di_box 0] 0]
    #set di_x  [lindex [lindex $di_box 1] 0]
    #set di_y  [lindex [lindex $di_box 1] 1]
    #set fp_box  [get_attribute [get_core_area] bbox]
    #set fp_x  [lindex [lindex $fp_box 1] 0]
    #set fp_y  [lindex [lindex $fp_box 1] 1]
    #set di_mg [expr $di_mmg*-1]
    #create_routing_blockage -layers {metal1Blockage} -bbox [list [list $di_mmg [expr $fp_y+0.2]] [list $di_x $di_y]]
    #create_routing_blockage -layers {metal1Blockage} -bbox [list [list $di_mmg $di_mmg] [list $di_x -0.5]]


}
