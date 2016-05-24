require 'minitest/autorun'
require_relative "../test_helper"
class TestProductsAttrsReader < MiniTest::Unit::TestCase
  def setup
    @crit_dim_part_types = CritDim.select(:part_type_id).distinct
    @crit_dim_classes_creator = CritDimClassesCreator.new

  end

  def test_create_classes
    @crit_dim_classes_creator.dynamically_create_classes
    @crit_dim_part_types.each do |type|
      part_type = PartType.find type.part_type_id

        name = part_type.magento_attribute_set
      unless name.downcase  == 'part'
        name = name.gsub(" ", '')
        p Object.const_get(name)
      end
    end
  end
end