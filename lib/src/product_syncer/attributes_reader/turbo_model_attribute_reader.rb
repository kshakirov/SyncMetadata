class TurboModelAttributeReader

  def initialize
    @sql_template = ERB.new %q{
     select
      distinct
      q.part_id,
      q.turbo_model_id
     from
        (
            select
                ii.part_id,
                ii2.part_id AS turbo_id,
                t.turbo_model_id
            FROM
                bom_descendant bd
                JOIN bom b ON bd.part_bom_id = b.id
                JOIN interchange_item ii1 ON b.parent_part_id = ii1.part_id
                JOIN interchange_item ii2 ON ii2.interchange_header_id = ii1.interchange_header_id
                JOIN bom bc ON bd.descendant_bom_id = bc.id
                JOIN interchange_item ii3 ON bc.child_part_id = ii3.part_id
                JOIN interchange_item ii ON ii3.interchange_header_id = ii.interchange_header_id
                join turbo t on ii2.part_id = t.part_id
            where
                ii.part_id = <%= part_id%>
        UNION
            SELECT
                turbo.part_id AS part_id,
                turbo.part_id AS turbo_id,
                turbo_model_id
            FROM
                turbo
            where
                part_id = <%= part_id%>
        ) as q
    }.gsub(/\s+/, " ").strip
  end



  def normalize_tyrbo_types types_hash
    types_hash.keys
  end

  def get_turbo_model responses
    models = []
    turbo_types = {}
    i = 0
    responses.each do |r|
      model = TurboModel.find r[1]
      models.push(model.name)
      turbo_types[model.turbo_type.name] = i
      i += 1
    end
    return models, normalize_tyrbo_types(turbo_types)
  end

  def process_response id
    part_id = id
    sql = @sql_template.result(binding)
    responses = ActiveRecord::Base.connection.execute(sql)
    get_turbo_model responses

  end

  def get_attribute id
      process_response id
  end
end