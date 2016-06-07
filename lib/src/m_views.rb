class VmagmiTiChra < ActiveRecord::Base
  self.table_name = 'vmagmi_ti_chra'
  self.primary_key = 'id'
end

class VWhereUsed < ActiveRecord::Base
  self.table_name = 'vwhere_used'
end

class VmagmiBom < ActiveRecord::Base
  self.inheritance_column = nil
  #attr_accessible :type
  self.table_name = 'vmagmi_bom'
end

class VmagmiServiceKit < ActiveRecord::Base
  #attr_accessible :type
  self.table_name = 'vmagmi_service_kits'
end