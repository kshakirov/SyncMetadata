class VWhereUsed < ActiveRecord::Base
  self.table_name = 'vwhere_used'
  self.primary_key = "principal_id"
end