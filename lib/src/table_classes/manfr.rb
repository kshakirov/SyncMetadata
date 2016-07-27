class Manfr < ActiveRecord::Base
  self.table_name = 'manfr'
  self.primary_key = "id"
  has_many :turbo_type, class_name: "TurboType"
end