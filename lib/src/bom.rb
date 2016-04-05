class Bom < ActiveRecord::Base
  self.table_name ='bom'
  # has_one :bom_descendant, class_name: BomDescendant,
  #         foreign_key: "part_bom_id"
end