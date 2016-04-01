class InterchangeItem < ActiveRecord::Base
  self.table_name = 'interchange_item'
  has_one :part, class_name: "Part",
             foreign_key: 'id'
end