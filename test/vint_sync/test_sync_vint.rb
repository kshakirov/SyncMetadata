require 'minitest/autorun'
require_relative "../test_helper"

class TestVintSync <Minitest::Unit::TestCase
  def test_one
    manager = VintSyncManager.new
    response = manager.find_by_id 42809
    refute_nil response
    p response

  end

end