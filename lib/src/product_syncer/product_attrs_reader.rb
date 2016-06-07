class WhereUsedAttrReader

  def  get_attribute id
    vw = VWhereUsed.where principal_id: id
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

class ProductAttrsReader

  def initialize
    @crit_dim_attr_reader = ProductCriticalAtttsReader.new
    @vwhere_used_attr_reader = WhereUsedAttrReader.new
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
    val = VmagmiTiChra.find id
    if val.has_ti_chra == 'no'
      return false
    end
    true
  end

  def get_where_used id
    @vwhere_used_attr_reader.get_attribute id
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
    inserted_product[:where_used] = get_where_used part.id
    inserted_product[:custom_attrs] = @crit_dim_attr_reader.get_crit_dim_attributes(part.part_type.id, id)

    inserted_product
  end

  def normalize_set_name name
    name.downcase.gsub(" ", '_')
  end
end