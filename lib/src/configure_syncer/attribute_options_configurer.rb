class AttributeOptionsConfigurer

  def config_options_array dimension
    option_id = dimension.enum_id
    opts = CritDimEnumVal.where crit_dim_enum_id: option_id
    option = {:values => []}
    opts.each_with_index  {|o, i|
      option[:values].push o.val
    }
    option
  end
end