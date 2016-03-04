require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestPartAudit < Minitest::Unit::TestCase
  def test_all
    pa = PartAudit.all
    refute_nil(pa)

  end
  def test_find
    pa = PartAudit.where("id > ?", 0)
    assert_equal 2, pa.size
  end
end