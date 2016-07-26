class ForeignInterchangeReader
  def initialize
    @sql_template = ERB.new %q{
             SELECT
                p.id AS sku,
                max(case when p1.manfr_id = 11 then 1 else 0 end) AS has_ti_interchange,
                max(case when p1.manfr_id <> p.manfr_id then 1 else 0 end) AS has_foreign_interchange
            FROM
                part AS p

                LEFT JOIN (interchange_item AS ii1
                INNER JOIN interchange_item AS ii2 ON ii1.interchange_header_id = ii2.interchange_header_id
                AND ii1.part_id <> ii2.part_id
                INNER JOIN part AS p1 ON ii2.part_id = p1.id AND p1.inactive = False) ON p.id = ii1.part_id
            WHERE p.id=<%= id %>
            GROUP BY p.id
        }.gsub(/\s+/, " ").strip
  end

  def prepare_response sql_template, id
    id = id
    sql = @sql_template.result(binding)
    result = ActiveRecord::Base.connection.execute(sql)
    result.each do |r|
      if r and r.size== 3 and r[2]==1
        return true
      else
        return false
      end
    end
  end

  def get_attribute id
    prepare_response(@sql_template, id)
  end
end
