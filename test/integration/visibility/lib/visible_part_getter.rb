class VisiblePartGetter
  def initialize
    @sql_template = ERB.new %q{
            select distinct
    p.id
    , p.manfr_part_num
    , q.visible
    , q.visibility
    , p.manfr_id
    , m.name as manfr
    , p.part_type_id
    , pt.name as part_type
from
(
    select distinct
        p.id
        , m.name as manfr
        , p.manfr_part_num
        , '01_ti_part_without_foreign_inter' as visibility
        , true as visible
    from
        part as p
        inner join manfr m on p.manfr_id = m.id

        left join (interchange_item as ii1
        inner join interchange_item as ii2 on ii1.interchange_header_id = ii2.interchange_header_id and ii1.part_id <> ii2.part_id
        inner join part as p2 on ii2.part_id = p2.id and not p2.inactive)
            on ii1.part_id = p.id and p2.manfr_id <> p.manfr_id
    where
        1 = 1
        and not p.inactive
        and m.id = 11
        and p2.id is null


    union all

    select distinct
        p.id
        , m.name as manfr
        , p.manfr_part_num
        , '02_non_ti_part_with_ti_inter' as visibility
        , true as visible
    from
        part as p
        inner join manfr m on p.manfr_id = m.id

        inner join (interchange_item as ii1
        inner join interchange_item as ii2 on ii1.interchange_header_id = ii2.interchange_header_id and ii1.part_id <> ii2.part_id
        inner join part as p2 on ii2.part_id = p2.id and not p2.inactive)
            on ii1.part_id = p.id and p2.manfr_id = 11
    where
        1 = 1
        and not p.inactive
        and m.id <> 11

    union all

    select distinct
        p.id
        , m.name as manfr
        , p.manfr_part_num
        , '03_non_ti_turbo_no_ti_inter_has_chra_bom_with_ti_interch' as visibility
        , true as visible
    from
        part as p
        inner join manfr as m on p.manfr_id = m.id

        left join (interchange_item as ii1
        inner join interchange_item as ii2 on ii1.interchange_header_id = ii2.interchange_header_id and ii1.part_id <> ii2.part_id
        inner join part as p2 on ii2.part_id = p2.id and not p2.inactive)
            on ii1.part_id = p.id and p2.manfr_id = 11

        inner join bom as b on p.id = b.parent_part_id
        inner join part as pc on b.child_part_id = pc.id and pc.part_type_id = 2 and not pc.inactive
        inner join interchange_item as ii3 on pc.id = ii3.part_id
        inner join interchange_item as ii4 on ii3.interchange_header_id = ii4.interchange_header_id and ii3.part_id <> ii4.part_id
        inner join part as p4 on ii4.part_id = p4.id and p4.manfr_id = 11 and not p4.inactive

    where
        1 = 1
        and not p.inactive
        and m.id <> 11
        and p2.id is null
        and p.part_type_id = 1

    union all



    select distinct
        p.id
        , m.name as manfr
        , p.manfr_part_num
        , '035_inactive_parts' as visibility
        , false as visible
    from
        part as p
        inner join manfr m on p.manfr_id = m.id
    where
        p.inactive

    union all

    select distinct
        p.id
        , m.name as manfr
        , p.manfr_part_num
        , '04_ti_parts_with_active_foreign_interchange' as visibility
        , false as visible
    from
        part as p
        inner join manfr m on p.manfr_id = m.id

        left join (interchange_item as ii1
        inner join interchange_item as ii2 on ii1.interchange_header_id = ii2.interchange_header_id and ii1.part_id <> ii2.part_id
        inner join part as p2 on ii2.part_id = p2.id and not p2.inactive)
            on ii1.part_id = p.id and p2.manfr_id <> p.manfr_id
    where
        1 = 1
        and not p.inactive
        and m.id = 11
        and p2.id is not null


    union all

    select distinct
        p.id
        , m.name as manfr
        , p.manfr_part_num
        , '05_non_ti_parts_no_ti_interchange_is_turbo_no_chra_ti_interch' as visibility
        , false as visible
    from
        part as p
        inner join manfr as m on p.manfr_id = m.id

        left join (interchange_item as ii1
        inner join interchange_item as ii2 on ii1.interchange_header_id = ii2.interchange_header_id and ii1.part_id <> ii2.part_id
        inner join part as p2 on ii2.part_id = p2.id and not p2.inactive)
            on ii1.part_id = p.id and p2.manfr_id = 11

        left join (bom as b
        inner join part as pc on b.child_part_id = pc.id and pc.part_type_id = 2 and not pc.inactive
        inner join interchange_item as ii3 on pc.id = ii3.part_id
        inner join interchange_item as ii4 on ii3.interchange_header_id = ii4.interchange_header_id and ii3.part_id <> ii4.part_id
        inner join part as p4 on ii4.part_id = p4.id and p4.manfr_id = 11 and not p4.inactive) on p.id = b.parent_part_id

    where
        1 = 1
        and not p.inactive
        and m.id <> 11
        and p2.id is null
        and p.part_type_id = 1
        and p4.id is null

    union all

    select distinct
        p.id
        , m.name as manfr
        , p.manfr_part_num
        , '06_non_ti_parts_no_ti_interchange_not_turbo' as visibility
        , false as visible
    from
        part as p
        inner join manfr m on p.manfr_id = m.id

        left join (interchange_item as ii1
        inner join interchange_item as ii2 on ii1.interchange_header_id = ii2.interchange_header_id and ii1.part_id <> ii2.part_id
        inner join part as p2 on ii2.part_id = p2.id and not p2.inactive)
            on ii1.part_id = p.id and p2.manfr_id = 11
    where
        1 = 1
        and not p.inactive
        and m.id <> 11
        and p2.id is null
        and p.part_type_id <> 1
) as q
    inner join part as p on q.id = p.id
    inner join part_type as pt on p.part_type_id = pt.id
    inner join manfr as m on p.manfr_id = m.id

        }.gsub(/\s+/, " ").strip


  end



  def is_part_visible part
    if part[2]== 1
      true
    else
      false
    end
  end


  def dump_metadata_catalog

    sql = @sql_template.result(binding)
    @result = ActiveRecord::Base.connection.execute(sql)
    visible_ids_by_parts = {}
    @result.each{|r|
     if visible_ids_by_parts.key? r[7]
       visible_ids_by_parts[r[7]].push r[0] if is_part_visible r
     else
       if is_part_visible r
        visible_ids_by_parts[r[7]] = [r[0]]
       else
         visible_ids_by_parts[r[7]] = []
       end

     end
    }
    File.open('../var/metadata_visible.yml', 'w') {|f| f.write visible_ids_by_parts.to_yaml }
  end

end