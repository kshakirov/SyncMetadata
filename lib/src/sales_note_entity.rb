class Salesnote < ActiveRecord::Base
  self.table_name = "sales_note"
  def self.recently_commented
    self.find(:all,:conditions => [ 'write_date  > ?', Time.now - 5.years] )
  end
end

class Salesnotepart < ActiveRecord::Base
  has_many :salesnote, class_name: "Salesnote",
           foreign_key: "id"
  self.primary_keys = :sales_note_id, :part_id
  self.table_name = "sales_note_part"
end

class Part < ActiveRecord::Base
  has_many :salesnotepart, class_name: "Salesnotepart",
           foreign_key: "part_id"
  self.table_name = "part"

end