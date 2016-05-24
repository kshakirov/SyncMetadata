class ProductAttrsReader

  def initialize
    @crit_dim_attr_reader = ProductCriticalAtttsReader.new
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

  def get_turbo_type  part
    type = TurboType.where("manfr_id = ? and import_pk = ?", part.manfr.id, part.import_pk)
    if type.first
      return type.first.name
    end
    nil
  end

  def run id
    part = Part.find(id)
    inserted_product = {}
    inserted_product[:sku] = part.id
    inserted_product[:name] = part.name
    inserted_product[:manufacturer] = part.manfr.name
    inserted_product[:description] = part.description
    inserted_product[:part_number] = part.manfr_part_num
    p part.part_type.magento_attribute_set
    #get_attribute_set(part.part_type.magento_attribute_set, inserted_product, part)
    inserted_product[:turbo_type] = get_turbo_type part
    inserted_product[:custom_attrs] = @crit_dim_attr_reader.get_crit_dim_attributes(part.part_type.id, id)

    inserted_product
  end

  def normalize_set_name name
    name.downcase.gsub(" ", '_')
  end
end