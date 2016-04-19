class ConfigManager
  def initialize
    @attribute_configurer = AttributeConfigurer.new
  end
  def get_attributes_table
    @attribute_configurer.run
  end

  def get_critical_dimension_attributes
      get_attributes_table
  end

end