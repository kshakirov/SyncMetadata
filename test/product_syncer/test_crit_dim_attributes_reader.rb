require 'minitest/autorun'
require_relative "../test_helper"

class TestProductsAttrsReader < MiniTest::Unit::TestCase
  def setup
    @reader = ProductCriticalAtttsReader.new
end
  def test_all
    refute_nil @reader
    attrs = @reader.get_crit_dim_attributes('13',  43895)
    assert_equal 35, attrs.size

    p attrs
  end
end