require 'minitest/autorun'
require_relative "../test_helper"

class TestProductSyncInserted < MiniTest::Unit::TestCase
  def setup
    @configurer = AttributeOptionsConfigurer.new
  end

  def test_all
    refute_nil @configurer
    dim = CritDim.find  29
    option_id = dim.enum_id
    opts = CritDimEnumVal.where crit_dim_enum_id: option_id
    options = []
    opts.each {|o| options.push o.val}
    p options


  end
end