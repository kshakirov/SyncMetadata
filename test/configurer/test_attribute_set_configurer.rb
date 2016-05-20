require 'minitest/autorun'
require_relative "../test_helper"

class TestProductSyncInserted < MiniTest::Unit::TestCase
  def setup
    @configManager = ConfigManager.new
  end

  def test_all
    refute_nil @configManager
    p @configManager.get_attribute_sets



  end
end