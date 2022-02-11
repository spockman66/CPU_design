set core_clk_period  10
set jtag_TCK_period  100

create_clock -period $core_clk_period [get_port core_clk]
set_clock_uncertainty -setup [expr  $core_clk_period * 0.05] [get_clocks core_clk]
set_clock_transition -max 0.1  [get_clocks core_clk]

set core_clk_input  [all_inputs]
set core_clk_output [all_outputs]

set_input_delay  -max [expr  $core_clk_period * 0.1] -clock core_clk $core_clk_input
set_output_delay -max [expr  $core_clk_period * 0.1] -clock core_clk $core_clk_output


create_clock -period $jtag_TCK_period [get_port jtag_TCK]
set jtag_TCK_inputs  [get_ports {jtag_TMS jtag_TDI}]
set jtag_TCK_outputs [get_ports jtag_TDO]

set_input_delay  -max [expr  $jtag_TCK_period * 0.2] -clock jtag_TCK $jtag_TCK_inputs
set_output_delay -max [expr  $jtag_TCK_period * 0.2] -clock jtag_TCK $jtag_TCK_outputs


set_clock_groups  -asynchronous -group {core_clk} -group {jtag_TCK}

proc apply_pairwise_exceptions {exception args} {
 foreach group1 $args {
  foreach group2 $args {
   if {$group1 eq {-group} || $group2 eq {-group} || $group1 eq $group2} {continue}
   foreach c1 $group1 {
    foreach c2 $group2 {
     echo "$exception -from \[get_clocks $c1\] -to \[get_clocks $c2\]"
     eval "$exception -from \[get_clocks $c1\] -to \[get_clocks $c2\]"
    }
   }
  }
 }
}

apply_pairwise_exceptions {set_false_path} -group {core_clk} -group {jtag_TCK}
