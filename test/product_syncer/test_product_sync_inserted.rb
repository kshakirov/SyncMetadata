require 'minitest/autorun'
require_relative "../test_helper"

class TestProductSyncInserted < MiniTest::Unit::TestCase
  def setup
    @inserter = ProductSyncInserted.new
  end
  def test_normalize
    assert_equal "bearing_spacer", @inserter.normalize_set_name("Bearing Spacer")
  end
  def test_link_to_set
    product = @inserter.run '45487'
    assert_equal 0.694, product[:outside_dim_min]

  end

  def test_turbo_type
    product = @inserter.run '45498'
    assert_equal nil, product[:turbo_type]

  end
end