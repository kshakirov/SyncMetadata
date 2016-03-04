class TurboType < ActiveRecord::Base
  self.table_name =  'turbo_type'
  self.primary_key = "id"
  belongs_to :manfr, class_name: "Manfr",
          foreign_key: 'manfr_id'
end