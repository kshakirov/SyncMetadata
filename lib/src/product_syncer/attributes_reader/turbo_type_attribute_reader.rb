class TurboTypeAttributeReader

  def initialize
    @sql_template = ERB.new %q{
     select
      distinct
      q.part_id,
      q.turbo_type_id
     from
        (
            select
                ii.part_id,
                tm.turbo_type_id
            FROM
                bom_descendant bd
                JOIN bom b ON bd.part_bom_id = b.id
                JOIN interchange_item ii1 ON b.parent_part_id = ii1.part_id
                JOIN interchange_item ii2 ON ii2.interchange_header_id = ii1.interchange_header_id
                JOIN bom bc ON bd.descendant_bom_id = bc.id
                JOIN interchange_item ii3 ON bc.child_part_id = ii3.part_id
                JOIN interchange_item ii ON ii3.interchange_header_id = ii.interchange_header_id
                join turbo t on ii2.part_id = t.part_id
                join turbo_model tm on t.turbo_model_id = tm.id
            where
                ii.part_id = <%= part_id%>
        UNION
            SELECT
                turbo.part_id AS part_id,
                tm.turbo_type_id
            FROM
                turbo
                join turbo_model tm on turbo_model_id = tm.id
            where
                part_id = <%= part_id%>
        UNION
            SELECT
                part_id,
                turbo_type_id
            FROM
                part_turbo_type
            where
                part_id = <%= part_id%>
        ) as q
    }.gsub(/\s+/, " ").strip
  end

  def get_turbo_type responses
    models = Set.new
    turbo_types = Set.new
    i = 0
    responses.each do |r|
      turbo = TurboType.find r[1]
      turbo_types.add(turbo.name)
    end
    turbo_types.to_a
  end


  def process_response id
    part_id = id
    sql = @sql_template.result(binding)
    responses = ActiveRecord::Base.connection.execute(sql)
    get_turbo_type responses
  end


  def get_attribute id
    process_response id
  end
end
