require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestParts < MiniTest::Unit::TestCase

  def setup
    @part = Part.find('45487')
  end

  def test_manfr_part_type
    assert_equal "Turbo International", @part.manfr.name


  end
  def test_bearing_spacer
    assert_equal "Bearing Spacer", @part.part_type.magento_attribute_set
    assert_equal 0.704,@part.bearing_spacer.outside_dim_max
  end


end