class ServiceKitAttributeReader
  def get_main_fields kit
    main = {:sku => kit.kitSku,
    :partNumber => kit.kitPartNumber,
    :description => kit.description,
    :tiSku=> kit.tiKitSku,
    :tiPartNumber => kit.tiKitPartNumber
    }
  end
  def get_attribute id
    response = []
    sks = VmagmiServiceKit.where(sku: id).limit(100)
    sks.each do |sk|
      response.push(get_main_fields sk)
    end
    response
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

  def aggregate_ti_part_skus response, bom_new
    if response.has_key? bom_new[:sku]
      response[bom_new[:sku]][:ti_part_sku].push bom_new[:ti_part_sku]
    else
      response[bom_new[:sku]] = bom_new
      response[bom_new[:sku]][:ti_part_sku] =  [bom_new[:ti_part_sku]]
    end
  end

  def conv_from_hash_to_array response
    values = []
    response.each do |key, value|
      values.push value
    end

  end

  def get_main_fields bom
    main = {  "alt_part_sku": [],
              "distance": bom.distance,
              "has_bom": bom.has_bom,
              "part_type_parent": bom.part_type_parent,
              "quantity": bom.quantity,
              "sku": bom.descendant_sku,
              "ti_part_sku":   bom.int_sku,
              "type": bom.type}
  end

  def get_attribute id
    boms = VmagmiBom.where(ancestor_sku: id).limit(100)
    response = {}
    boms.each do |bom|
      aggregate_ti_part_skus response, get_main_fields(bom)
    end
    conv_from_hash_to_array response
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

  def get_stringified_field app
    "#{app.car_make}!!#{app.car_model}!!#{app.car_year || 'not specified'}!!!!"

  end

  def get_attribute id
    previous = false
    apps = Vapp.where(part_id: id).limit(100)
    apps.each do |app|
      if not previous
        previous = get_stringified_field app
      else
        previous = previous + '||' + get_stringified_field(app)
      end
    end
    previous
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
    unless value.nil? or   value == '[]' or value == '{}'
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
    #still too slow
    #add_part_type_specific_attrs inserted_product, :bill_of_materials, get_bom(part.id)
    #still too slow
    #add_part_type_specific_attrs inserted_product, :application_detail, get_applications(part.id)
    inserted_product[:custom_attrs] = @crit_dim_attr_reader.get_crit_dim_attributes(part.part_type.id, id)

    inserted_product
  end

  def normalize_set_name name
    name.downcase.gsub(" ", '_')
  end
end