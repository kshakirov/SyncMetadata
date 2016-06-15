require_relative '../app_helper'
require_relative 'tools_helper'
require_relative '../lib/sync'



part_type  = PartType.where(name: 'Clamp').first
part_type.magento_attribute_set = 'Clamp'
part_type.save