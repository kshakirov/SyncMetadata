require_relative '../tools_helper'

def get_update_manager
  CollectionUpdate::CritPart.new
end

manager = get_update_manager
updated_items, rejected_items = manager.update_critical_products

puts "List contains #{updated_items} active items"
puts " #{rejected_items}  items by some reasons are not included in this update"