require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestBearingSpacer < Minitest::Unit::TestCase
  def test_all
    bearings = BearingSpacer.all
    assert_equal 12, bearings.size
  end
  def test_find_by_id
    bearing = BearingSpacer.find('45487')
    assert_equal 0.694000, bearing.outside_dim_min
  end

  def test_find_all_info
    bearing = BearingSpacer.find('45487')
    assert_equal 0.694000, bearing.outside_dim_min
  

    p bearing.part.manfr_part_num
    assert_equal '8-A-2055', bearing.part.manfr_part_num
  end
end