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


  def test_update_products_by_ids
    record = 44652
    @crit_dim_classes_creator.dynamically_create_classes
    update = @manager.update_products_by_ids [record]
    assert true
    update = JSON.parse update
    where_used = JSON.parse update[0]['where_used']
    assert_equal 100, where_used.size
    where_used = JSON.parse update[0]['where_used']
    assert_equal Hash, where_used.class

  end
end