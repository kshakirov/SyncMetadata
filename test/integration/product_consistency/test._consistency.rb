require 'minitest/autorun'
require_relative 'test_helper'

class TestConsistency < Minitest::Unit::TestCase

  def test_one_backplate
    sku = 45068
    part_diff = PartDiff.new
    matched, diff, abscent = part_diff.compare_critical sku
    assert_equal(22, matched.size)
    assert_equal(0, diff.size)
    assert_equal(0, abscent.size, abscent.to_s)

  end

  def test_one_bearing_housing

    sku = 44652
    part_diff = PartDiff.new 'storestaging.turbointernational.com'
    matched, diff, abscent = part_diff.compare_critical sku
    assert_equal(24, matched.size)
    assert_equal(0, diff.size)
    assert_equal(0, abscent.size, abscent.to_s)

  end

  def test_one_bolt_screw

    sku = 47751
    part_diff = PartDiff.new 'storestaging.turbointernational.com'
    matched, diff, abscent = part_diff.compare_critical sku
    assert_equal(7, matched.size)
    assert_equal(0, diff.size)
    assert_equal(0, abscent.size, abscent.to_s)

  end
  def test_one_carbon_seal
    sku = 47808
    part_diff = PartDiff.new 'storestaging.turbointernational.com'
    matched, diff, abscent = part_diff.compare_critical sku
    assert_equal(12, matched.size)
    assert_equal(0, diff.size)
    assert_equal(0, abscent.size, abscent.to_s)
  end


end




