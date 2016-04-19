require 'minitest/autorun'
require_relative "../test_helper"

class TestProductSyncInserted < MiniTest::Unit::TestCase
  def setup
    @configManager = ConfigManager.new
  end

  def test_all
    refute_nil @configManager
    params = {:attribute_metadata => true}
    File.open("attributes.json","w"){|file|
      file.write @configManager.run(params)
    }

  end
end