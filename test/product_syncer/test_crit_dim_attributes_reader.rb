require 'minitest/autorun'
require_relative "../test_helper"

class TestProductsAttrsReader < MiniTest::Unit::TestCase
  def setup
    @reader = ProductCriticalAtttsReader.new
    @crit_dim_classes_creator = CritDimClassesCreator.new
  end

  def test_all
    refute_nil @reader
    @crit_dim_classes_creator.dynamically_create_classes
    attrs = @reader.get_crit_dim_attributes('13', 43895)
    assert_equal 35, attrs.size

    p attrs
  end



  def test_where_used
    @reader = WhereUsedAttrReader.new
    attrs = @reader.get_attribute 42492
    assert_equal 3,  attrs[62][:turboPartNumbers].size
    assert_equal "408105-0124",  attrs[62][:partNumber]

  end
end