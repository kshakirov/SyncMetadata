class CritDim < ActiveRecord::Base
  self.table_name ="crit_dim"
  belongs_to :part_type, class_name: "PartType",
             foreign_key: 'part_type_id'
end