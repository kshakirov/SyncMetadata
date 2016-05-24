require 'minitest/autorun'
require_relative "../test_helper"

class TestProductsManager < MiniTest::Unit::TestCase
  def setup
    @manager = ProductSyncManager.new
  end
  def test_all
      @manager.update_all_products
  end

  def test_part_type_with_crit_dim
      crit_dim = CritDim.select(:part_type_id).distinct
      p crit_dim
      p crit_dim.size

  end
end