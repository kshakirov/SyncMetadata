class ProductCriticalAtttsReader
  def initialize
    @crit_dims = CritDim.all
  end

  def add_prefix_to_attribute_name part_type_name
    ps = part_type_name.split(' ')
    name = ''
    ps.each { |p|
      name += p[0]
    }
    name
  end

  def add_part_type_prefix name, part_type_name
    add_prefix_to_attribute_name(part_type_name) + '_' + name.underscore

  end

  def _get_values_from_table table_class_name, attrs, product_id, magento_set_name
    product = Object.const_get(table_class_name).find product_id
    attributes = {}

    attrs.each do |attr|
      #key_name = add_part_type_prefix(attr.json_name, magento_set_name)
      key_name = attr.idx_name
      attributes[key_name] = product.send(attr.json_name) || 0
    end
    attributes
  end

  def _get_magento_set_name set_id
    PartType.find(set_id).magento_attribute_set

  end

  def _get_table_class_name set_id
   table_class_name =  PartType.find(set_id).magento_attribute_set
   table_class_name.gsub(" ", '')

  end

  def _get_attribute_values attrs, set_id, product_id
    table_class_name = _get_table_class_name(set_id)
    magento_set_name = _get_magento_set_name(set_id)
    attributes = _get_values_from_table(table_class_name, attrs, product_id, magento_set_name)
  end

  def _get_attributes_by_set_id  set_id
    @crit_dims.where part_type_id: set_id
  end

  def get_crit_dim_attributes set_id,  product_id
      _get_attribute_values(_get_attributes_by_set_id(set_id), set_id,  product_id)
  end
end