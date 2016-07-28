require_relative '../tools_helper'
def get_update_manager
  manager = ProductSyncManager.new
  crit_dim_classes_creator = CritDimClassesCreator.new
  crit_dim_classes_creator.dynamically_create_classes
  manager
end
