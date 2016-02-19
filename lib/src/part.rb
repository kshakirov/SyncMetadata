class Part < ActiveRecord::Base
  has_many :salesnotepart, class_name: "Salesnotepart",
           foreign_key: "part_id"
  belongs_to :manfr, class_name: "Manfr",
          foreign_key: 'manfr_id'
  belongs_to :part_type, class_name: "PartType",
             foreign_key: 'part_type_id'
  self.table_name = "part"

  has_many :product_image, class_name: "ProductImage",
           foreign_key: "part_id"

end