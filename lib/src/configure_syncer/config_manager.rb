class ConfigManager
  def initialize
    @attribute_configurer = AttributeConfigurer.new
  end
  def get_attributes_table
    @attribute_configurer.run
  end

  def run params
    if params[:attribute_metadata]
      get_attributes_table
    end
  end
end