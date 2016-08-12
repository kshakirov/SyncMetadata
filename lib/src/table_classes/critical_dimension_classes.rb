class CritDimClassesCreator

  def _get_crit_dims_part_types
    CritDim.select(:part_type_id).distinct

  end

  def dynamically_create_classes
    crit_dim_parts = []
    crit_dim_part_types = _get_crit_dims_part_types
    crit_dim_part_types.each do |type|
      part_type = PartType.find type.part_type_id
      name = part_type.magento_attribute_set
      unless name.downcase == 'part'
        name = name.gsub(" ", '')
        klazz = Class.new(ActiveRecord::Base)
        klass = Object.const_set name, klazz
        klass.table_name = part_type.value
        klass.inheritance_column = nil
        klass.primary_key = 'part_id'
      end
    end
  end
end


