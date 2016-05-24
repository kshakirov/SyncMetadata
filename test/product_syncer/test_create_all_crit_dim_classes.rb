require 'minitest/autorun'
require_relative "../test_helper"
class TestProductsAttrsReader < MiniTest::Unit::TestCase
  def setup
    @crit_dim_part_types = CritDim.select(:part_type_id).distinct

  end

  def test_create_classes
    crit_dim_parts = []
    @crit_dim_part_types.each do |type|
      part_type = PartType.find type.part_type_id

        name = part_type.magento_attribute_set
      unless name.downcase  == 'part'
        name = name.gsub(" ", '')
        unless  /[[:upper:]]/.match(name)
          name = name.capitalize
        end
        klazz = Class.new(ActiveRecord::Base)
        klass = Object.const_set name, klazz
        klass.table_name = part_type.value
        klass.primary_key = 'part_id'
        p Object.const_get(name)
      end
    end
  end
end