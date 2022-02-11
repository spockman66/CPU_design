proc set_dont_ungroup_hierarchy {{instance_list}} {

      #exit if no instance name is provided
      if {[string compare $instance_list ""] == 0} {
         puts "Instance name is missing."
         return 0
      }

      #convert all input into collection
      if {[regexp "_sel.*" $instance_list] == 0} {; #if instance_list is not a DC object
         set instance_items [get_cells $instance_list]
      } else {; #if instance_list is a DC object
         set instance_items $instance_list
      }

      #iterate on all input elements
      foreach_in_collection instance_col $instance_items {
         set instance [get_attribute $instance_col full_name]

         #exit if non existing hierarchical instance is provided
         if {[sizeof_collection [get_cells $instance]] < 1} {continue}

         #exit if provided instance is not hierarchical 
         if {[sizeof_collection [filter [get_cells $instance] "@is_hierarchical == true"]] < 1} {
            puts "Warning: Instance $instance is not hierarchical, attribute is not annotated."
            continue
         }

         #filter and get only hierarchical cells under the parent instance 
         set hier_cells [filter [get_cells -hier] -regexp "@full_name =~ ${instance}/.*"]
         set hier_cells [filter $hier_cells "@is_hierarchical == true"]

         #if cell list is empty, set attibute on parent cell, flag a message and exit
         set cell_count [sizeof_collection $hier_cells]
         set_ungroup $instance false
         if {$cell_count < 1} {
            puts "Information: There is no hierarchical instance under $instance. Only $instance \
receive the set_ungroup false attribute."
            continue
         }

         #set the attribute on all cells found
         set_ungroup [filter $hier_cells "@is_hierarchical == true"] false

         #summary report
         puts "Information: Attribute set_ungroup false annotated for [expr $cell_count+1] \
hierarchical cells, including parent cell $instance."
      }
      return 1
}

