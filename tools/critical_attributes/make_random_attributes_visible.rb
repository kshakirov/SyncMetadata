require_relative '../../app_helper'
require_relative '../tools_helper'
require_relative '../../lib/sync'

part_types = PartType.all

part_types.each do |part_type|
  crit_dims = CritDim.where( 'part_type_id = ? and parent_id IS NULL', part_type).limit(4)
  crit_dims.each do |cd|
    cd.is_visible_in_list = 1
    cd.save
  end
end