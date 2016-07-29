require 'minitest/autorun'
require_relative 'test_helper'

class TestConsistency < Minitest::Unit::TestCase


  def test_mag_class
    sku = 45068
    part_diff = PartDiff.new
    matched, diff, abscent = part_diff.compare_critical sku
    assert_equal(22, matched.size)
    assert_equal(0, diff.size)
    assert_equal(0, abscent.size, abscent.to_s)

  end
end




