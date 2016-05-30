require 'minitest/autorun'
require_relative "../test_helper"

class TestProductsManager < MiniTest::Unit::TestCase
  def setup
    @manager = ProductSyncManager.new
    @crit_dim_classes_creator = CritDimClassesCreator.new
  end
  def test_all
      @crit_dim_classes_creator.dynamically_create_classes
      @manager.update_all_products
  end

  def test_part_type_with_crit_dim
      crit_dim = CritDim.select(:part_type_id).distinct
      p crit_dim
      p crit_dim.size

  end

  def test_update_records_audit
    record = {'id' => '42128'}
    @crit_dim_classes_creator.dynamically_create_classes
    p @manager.update_products [record]
  end
end