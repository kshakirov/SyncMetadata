class PartTypeAnalyzer
  def is_crit_dim_part_type part_type_id
    part_types = _get_crit_dims_part_types

    part_types.each {|part_type|
      if part_type.part_type_id == part_type_id
        type = PartType.find part_type_id
        return true unless type.magento_attribute_set == 'Part'
      end
    }
    false
  end

  def _get_crit_dims_part_types
    CritDim.select(:part_type_id).distinct

  end

end

