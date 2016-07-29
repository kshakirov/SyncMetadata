class MetaPart

  def initialize
    @attrs_map = {}
  end

  def _get__dynamic_crit_dim_class part
    name = part.part_type.magento_attribute_set
    value = part.part_type.value
    klazz= nil
    unless name.downcase == 'part'
      name = name.gsub(" ", '')
      klazz = Class.new(ActiveRecord::Base)
      klass = Object.const_set name, klazz
      klass.table_name = value
      klass.primary_key = 'part_id'
    end
    klazz
  end

  def _has_map_part_type name
    @attrs_map.key? name
  end

  def _get_part_type_name part
    part.part_type.magento_attribute_set
  end

  def _get_part_type_id part
    part.part_type.id
  end

  def _init_crit_dim_map part
    part_name = _get_part_type_name(part)
    unless _has_map_part_type(part_name)
      crit_dims = CritDim.where(part_type_id: _get_part_type_id(part))
      @attrs_map[part_name] = {}
      crit_dims.each do |c|
        @attrs_map[part_name][c['json_name']] = c['idx_name']
      end
    end
    0
  end


  def _convert_2_diff_format part, part_std
    converted_part = {}
    part_name = _get_part_type_name(part_std)
    part.attributes.each do |a|
      if @attrs_map[part_name].key? a[0]
        converted_part[@attrs_map[part_name][a[0]]] = a[1].to_f
      end
    end
    converted_part
  end


  def init_meta_part sku
    part_std = Part.find sku
    _init_crit_dim_map(part_std)
    klazz = _get__dynamic_crit_dim_class part_std
    part_critical = klazz.send 'find', sku
    _convert_2_diff_format(part_critical, part_std)
  end
end