require_relative '../../app_helper'
require_relative '../tools_helper'
require_relative '../../lib/sync'

crit_dims = CritDim.where('parent_id > 0')
crit_dims.each do |cd|
  cd.is_visible_in_list = 0
  cd.save
end