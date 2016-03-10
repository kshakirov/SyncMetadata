require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestVWhereUsed <Minitest::Unit::TestCase
  def test_one
    v = VWherUsed.first
    refute_nil v
  end
  def test_count
    p VWherUsed.count
    assert VWherUsed.count > 1000000
  end
end