require_relative '../tools_helper'

def get_update_manager
  CollectionUpdate::ByPart.new
end

if ARGV[0]
  manager = get_update_manager
  updated_items, rejected_items  = manager._collect_products_by_part_type  ARGV[0]
  puts "List contains #{updated_items} active items"
  puts " #{rejected_items}  items by some reasons are not included in this update"
else
  puts "Enter Part Type Name"
end