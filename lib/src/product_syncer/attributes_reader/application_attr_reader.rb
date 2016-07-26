class ApplicationAttrReader
  def initialize
    @sql_template = ERB.new %q{
      select
        distinct
        q.part_id,
        cmake.name AS car_make,
        cyear.name AS car_year,
        cmodel.name AS car_model
      from
        (
            select
                ii.part_id,
                ii2.part_id AS turbo_id
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
                ii.part_id = <%= part_id %>
            UNION
            SELECT
                turbo.part_id AS part_id,
                turbo.part_id AS turbo_id
            FROM
                turbo
            where
                part_id = <%= part_id %>
        ) as q
        JOIN turbo_car_model_engine_year c ON c.part_id = q.turbo_id
        LEFT JOIN car_model_engine_year cmey ON cmey.id = c.car_model_engine_year_id
        LEFT JOIN car_model cmodel ON cmodel.id = cmey.car_model_id
        LEFT JOIN car_make cmake ON cmake.id = cmodel.car_make_id
        LEFT JOIN car_year cyear ON cyear.id = cmey.car_year_id
    }.gsub(/\s+/, " ").strip
  end


  def get_stringified_field app
    "#{app[1]}!!#{app[3]}!!#{app[2]||'not specified'}!!#{app[0]}!!"

  end

  def get_stringified_result apps
    previous = false
    apps.each do |app|
      if not previous
        previous = get_stringified_field app
      else
        previous = previous + '||' + get_stringified_field(app)
      end
    end
    previous
  end

  def prepare_response sql_template, id
    part_id = id
    sql = @sql_template.result(binding)
    apps = ActiveRecord::Base.connection.execute(sql)
    get_stringified_result apps

  end

  def get_attribute id
    prepare_response @sql_template, id
  end


end

