class ServiceKitAttributeReader
  def get_main_fields kit
    main = {:sku => kit.kitSku,
    :partNumber => kit.kitPartNumber,
    :description => kit.description,
    :tiSku=> kit.tiKitSku,
    :tiPartNumber => kit.tiKitPartNumber
    }
  end

  def convert_hash_to_array hash
    array = []
    hash.each do |key,value|
      array.push value
    end
    array
  end
  def get_attribute id
    hash = {}
    sks = VmagmiServiceKit.where(sku: id)
    sks.each do |sk|
      unless  hash.has_key? sk.kitSku.to_s
        hash[sk.kitSku.to_s] = get_main_fields(sk)
      end
    end
     convert_hash_to_array hash
  end
end

class WhereUsedAttrReader

  def  get_attribute id
    vw = VWhereUsed.where(principal_id: id).limit(100)
    response = {}
    if vw.size > 0
       vw.each do  |v|
         aggregate_turbo_part_numbers response, get_main_fields(v)
       end
      response
    else
      nil
    end
  end

  private
  def get_main_fields item
    main = {
        "sku": item.sku,
        "manufacturer": item.manufacturer,
        "partNumber": item.part_number,
        "tiSku": item.ti_sku,
        "tiPartNumber": item.ti_part_number,
        "partType": item.part_type,
        "turboType": item.turbo_type,
        "turboPartNumbers": item.turbo_part_number,
    }

  end

  def aggregate_turbo_part_numbers response, item_new
    if response.has_key? item_new[:sku]
      response[item_new[:sku]][:turboPartNumbers].push item_new[:turboPartNumbers]
    else
      response[item_new[:sku]] = item_new
      response[item_new[:sku]][:turboPartNumbers] = [item_new[:turboPartNumbers]]

    end
  end
end


class BomAttributeReader


  def initialize
    @sql_template = ERB.new %q{
    SELECT DISTINCT
      ii2.part_id AS ancestor_sku,
      ii.part_id AS descendant_sku,
      bd.qty AS quantity,
      bd.distance AS distance,
      IF(((ii2.part_id <> b.parent_part_id)
              OR (ii.part_id <> bc.child_part_id)),
          'Interchange',
          bd.type) AS type,
      dppt.value AS part_type_parent,
      IF((db.id IS NOT NULL), 1, 0) AS has_bom,
      ba.child_part_id AS alt_sku,
      bam.id AS alt_mfr_id,
      ip.id AS int_sku
    FROM
        bom_descendant bd
        JOIN bom b ON bd.part_bom_id = b.id
        JOIN interchange_item ii1 ON b.parent_part_id = ii1.part_id
        JOIN interchange_item ii2 ON ii2.interchange_header_id = ii1.interchange_header_id
        JOIN bom bc ON bd.descendant_bom_id = bc.id
        JOIN interchange_item ii3 ON bc.child_part_id = ii3.part_id
        JOIN interchange_item ii ON ii3.interchange_header_id = ii.interchange_header_id

        JOIN part dp ON dp.id = ii.part_id
        JOIN part_type dpt ON dpt.id = dp.part_type_id
        LEFT JOIN part_type dppt ON dppt.id = dpt.parent_part_type_id

        left join
        (bom_alt_item bai
        JOIN bom ba ON ba.id = bai.bom_id
        JOIN part pa ON pa.id = bai.part_id
        JOIN manfr bam ON bam.id = pa.manfr_id) ON bai.bom_id = bd.part_bom_id

        left join
        (interchange_item ii1t
        JOIN interchange_item ii2t ON ii2t.interchange_header_id = ii1t.interchange_header_id AND ii1t.part_id <> ii2t.part_id
        JOIN part ip ON ip.id = ii2t.part_id and ip.manfr_id = 11) on ii1t.part_id = ii.part_id

        LEFT JOIN bom db ON db.parent_part_id = ii.part_id

        left join
        (bom_descendant bdd
                JOIN bom b4 ON bdd.part_bom_id = b4.id and bdd.type = 'direct'
                JOIN bom b4c ON bdd.descendant_bom_id = b4c.id
        ) ON ii2.part_id = b4.parent_part_id
            AND ii.part_id = b4c.child_part_id
            and IF(((ii2.part_id <> b.parent_part_id)
                     OR (ii.part_id <> bc.child_part_id)),
                    'Interchange',
                    bd.type) = 'Interchange'

    WHERE
        ISNULL(bdd.id)
        and ii2.part_id = <%= part_id %>
    }.gsub(/\s+/, " ").strip
  end

  def conv_from_hash_to_array hash
    values = []
    hash.each do |key, value|
      values.push value
    end
    values
  end

  def create_hash  bom
    main = {  "alt_part_sku": [],
              "distance": bom[3],
              "has_bom": bom[6] == 1 ? true: false ,
              "part_type_parent": bom[5],
              "quantity": bom[2],
              "sku": bom[1],
              "ti_part_sku":   [bom[9]],
              "type": bom[4]}
  end

  def aggregate_ti_part_skus boms
   hash = {}
    boms.each do |bom|
      if hash.has_key? bom[1]
        hash[bom[1]][:ti_part_sku].push bom[9]
      else
        hash[bom[1]] = create_hash(bom)
      end
    end
    hash
  end

  def prepare_response id
    part_id = id
    sql = @sql_template.result(binding)
    boms = ActiveRecord::Base.connection.execute(sql)
    hash = aggregate_ti_part_skus boms
    conv_from_hash_to_array hash

  end

  def get_attribute id
    prepare_response id

  end
end

class InterchangeAttributeReader



  def get_attribute id
    response = false
    ints = Vint.where(part_id: id).limit(100)
    ints.each do |int|
      if not response
        response = int.i_part_id.to_s
      else
        response = response + ',' + int.i_part_id.to_s
      end
    end
    response
  end
end


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


class HasTiChra
  def get_attribute id
    val = VmagmiTiChra.find id
    if val.has_ti_chra == 'no'
      return false
    elsif val.has_ti_chra == 'yes'
      return true
    end
    false
  end
end


class ProductAttrsReader

  def initialize
    @crit_dim_attr_reader = ProductCriticalAtttsReader.new
    @vwhere_used_attr_reader = WhereUsedAttrReader.new
    @bom_attr_reader = BomAttributeReader.new
    @service_kit_reader = ServiceKitAttributeReader.new
    @interchange_attr_reader = InterchangeAttributeReader.new
    @application_attr_reader = ApplicationAttrReader.new
    @fgn_interchange_attr_reader = ForeignInterchangeReader.new
    @has_ti_interchange_attr_reader = HasTiInterchange.new
    @has_ti_chra_attr_reader = HasTiChra.new
  end

  def get_attribute_set set, product, part
    a_set = set
    product[:magento_attribute_set] = set
    unless a_set.include?('Part')
      product_specific_table = part.send(normalize_set_name(a_set))
      product_specific_table.attributes.each do |a_name, a_value|
        unless a_name.include? 'part_id'
          product[a_name.to_sym] = a_value
        end
      end

    end
    product
  end

  def get_turbo_type part
    type = TurboType.where("manfr_id = ? and import_pk = ?", part.manfr.id, part.import_pk)
    if type.first
      return type.first.name
    end
    nil
  end

  def get_ti_interchange id
    @has_ti_interchange_attr_reader.get_attribute id
  end

  def get_ti_chra id
    @has_ti_chra_attr_reader.get_attribute id
  end

  def get_where_used id
    @vwhere_used_attr_reader.get_attribute(id).to_json
  end

  def get_bom id
    @bom_attr_reader.get_attribute(id).to_json
  end

  def get_service_kits id
    @service_kit_reader.get_attribute(id).to_json
  end
  def get_interchanges id
    @interchange_attr_reader.get_attribute(id)
  end

  def get_applications id
    @application_attr_reader.get_attribute id
  end

  def get_foreign_interchange id
    @fgn_interchange_attr_reader.get_attribute id
  end


  def add_part_type_specific_attrs inserted_product, label, value
    unless value.nil? or   value == '[]' or value == '{}' or not value
      inserted_product[label] = value
    end
  end

  def run id
    part = Part.find(id)
    inserted_product = {}
    inserted_product[:sku] = part.id
    inserted_product[:name] = part.name
    inserted_product[:manufacturer] = part.manfr.name
    inserted_product[:description] = part.description
    inserted_product[:part_number] = part.manfr_part_num
    inserted_product[:part_type] = part.part_type.magento_attribute_set
    inserted_product[:turbo_type] = get_turbo_type part
    inserted_product[:has_ti_interchange] = get_ti_interchange part.id
    inserted_product[:has_ti_chra] = get_ti_chra part.id
    inserted_product[:has_foreign_interchange] = get_foreign_interchange part.id
    add_part_type_specific_attrs inserted_product, :where_used, get_where_used(part.id)
    add_part_type_specific_attrs inserted_product, :service_kits, get_service_kits(part.id)
    add_part_type_specific_attrs inserted_product, :interchanges, get_interchanges(part.id)
    add_part_type_specific_attrs inserted_product, :bill_of_materials, get_bom(part.id)
    add_part_type_specific_attrs inserted_product, :application_detail, get_applications(part.id)
    inserted_product[:custom_attrs] = @crit_dim_attr_reader.get_crit_dim_attributes(part.part_type.id, id)

    inserted_product
  end

  def normalize_set_name name
    name.downcase.gsub(" ", '_')
  end
end