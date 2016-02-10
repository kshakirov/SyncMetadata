class BearingSpacer < ActiveRecord::Base
  self.table_name =  'bearing_spacer'
  self.primary_key = "part_id"
  has_one :part, class_name: "Part",
             foreign_key: 'id'
end