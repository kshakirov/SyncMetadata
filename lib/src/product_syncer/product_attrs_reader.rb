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
    @part_type_analyzer = PartTypeAnalyzer.new
    @turbo_model_attr_reader = TurboModelAttributeReader.new
    @turbo_type_attr_reader = TurboTypeAttributeReader.new
    @price_attr_reader = PriceAttributeReader.new
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

  def get_turbo_type part_id
    @turbo_type_attr_reader.get_attribute part_id
  end

  def get_turbo_model part_id
    @turbo_model_attr_reader.get_attribute part_id
  end

  def get_price id
    @price_attr_reader.get_attribute id
  end

  def get_active_state part
    part.inactive ? 'delete': 'update'
  end

  def run id
    part = Part.find(id)
    inserted_product = {}
    inserted_product['action'] = get_active_state part
    inserted_product['sku'] = part.id
    inserted_product['name'] = part.name
    inserted_product['manufacturer'] = part.manfr.name
    inserted_product['description'] = part.description
    inserted_product['part_number'] = part.manfr_part_num
    inserted_product['part_type'] = part.part_type.magento_attribute_set
    inserted_product['has_ti_interchange'] = get_ti_interchange part.id
    inserted_product['has_ti_chra'] = get_ti_chra part.id
    inserted_product['has_foreign_interchange'] = get_foreign_interchange part.id
    inserted_product['group_price'] = get_price part.id
    inserted_product['turbo_model'] = get_turbo_model part.id
    inserted_product['turbo_type'] = get_turbo_type part.id

    add_part_type_specific_attrs inserted_product, 'where_used', get_where_used(part.id)
    add_part_type_specific_attrs inserted_product, 'service_kits', get_service_kits(part.id)
    add_part_type_specific_attrs inserted_product, 'interchanges', get_interchanges(part.id)
    add_part_type_specific_attrs inserted_product, 'bill_of_materials', get_bom(part.id)
    add_part_type_specific_attrs inserted_product, 'application_detail', get_applications(part.id)
    inserted_product['custom_attrs'] = @crit_dim_attr_reader.get_crit_dim_attributes(part.part_type.id, id) if @part_type_analyzer.is_crit_dim_part_type(part.part_type.id)

    inserted_product
  end

  def normalize_set_name name
    name.downcase.gsub(" ", '_')
  end
end