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


  def is_big_decimal_to_f value
    if value.class.to_s.include? 'BigDecimal'
      value.to_f
    else
      value
    end
  end

  def _put_explicit_zero value
   is_big_decimal_to_f(value) || 0
  end

  def _get_values_from_table table_class_name, attrs, product_id, magento_set_name
    product = Object.const_get(table_class_name).find product_id
    attributes = {}

    attrs.each do |attr|
      key_name = attr.idx_name
      attributes[key_name] = {'value' => _put_explicit_zero(product.send(attr.json_name)), 'type' => attr.data_type}
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