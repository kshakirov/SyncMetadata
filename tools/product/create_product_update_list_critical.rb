require_relative '../tools_helper'

def get_update_manager
  CollectionUpdate::CritPart.new
end

manager = get_update_manager
manager.update_critical_products