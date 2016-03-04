require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestParts < MiniTest::Unit::TestCase


  def test_manfr_part_type
    part = Part.find('45487')
    inserted_product = {}
    assert_equal "Turbo International", part.manfr.name
    assert_equal "Bearing Spacer", part.part_type.magento_attribute_set
    assert_equal 0.704,part.bearing_spacer.outside_dim_max
    inserted_product[:sku] = part.id
    inserted_product[:name] = part.name
    inserted_product[:manufacturer] = part.manfr.name
    inserted_product[:description] = part.description
    inserted_product[:part_number] = part.manfr_part_num
    inserted_product[:part_type] = part.part_type.magento_attribute_set
    inserted_product[:outside_dim_max] = part.bearing_spacer.outside_dim_max

    p inserted_product.to_json


  end


end