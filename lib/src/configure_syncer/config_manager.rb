class ConfigManager
  def initialize
    @attribute_configurer = AttributeConfigurer.new
    @attribute_set_configurer = AttributeSetConfigurer.new
  end
  def get_attributes_table
    @attribute_configurer.run
  end

  def get_attribute_by_code code
    @attribute_configurer.run_single code
  end

  def get_critical_dimension_attributes
        get_attributes_table
  end


  def get_critical_dimension_attribute code

      get_attribute_by_code code

  end


  def get_attribute_sets
      @attribute_set_configurer.run
  end

end