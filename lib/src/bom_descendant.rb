class BomDescendant < ActiveRecord::Base
  self.table_name ="bom_descendant"
  self.inheritance_column ='type1'
  belongs_to :bom, class_name: Bom, foreign_key: "part_bom_id"
end