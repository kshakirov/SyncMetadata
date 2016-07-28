require_relative 'base_update'
if ARGV[0]
  manager = get_update_manager
  updated_items = manager._collect_products_by_part_type  ARGV[0]
  puts "List contains #{updated_items} items"
else
  puts "Enter Part Type Name"
end