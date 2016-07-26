class HasTiInterchange < ForeignInterchangeReader
  def prepare_response sql_template, id
    id = id
    sql = @sql_template.result(binding)
    result = ActiveRecord::Base.connection.execute(sql)
    result.each do |r|
      if r and r.size== 3 and r[1]==1
        return true
      else
        return false
      end
    end
  end
end