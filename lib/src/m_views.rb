class VmagmiTiChra < ActiveRecord::Base
  self.table_name = 'vmagmi_ti_chra'
  self.primary_key = 'id'
end

class VWhereUsed < ActiveRecord::Base
  self.table_name = 'vwhere_used'
  #self.primary_key = 'principa_id'
end