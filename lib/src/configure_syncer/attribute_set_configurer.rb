class AttributeSetConfigurer
  def run
    sets = PartType.all
    response = []
    sets.each do |set|
      response.push set.magento_attribute_set
    end
    response.to_json
  end
end