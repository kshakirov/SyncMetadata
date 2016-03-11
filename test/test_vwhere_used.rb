require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestVWhereUsed <Minitest::Unit::TestCase
  def test_one
    v = VWhereUsed.first
    refute_nil v
  end
  def test_count
    p VWhereUsed.count
    assert VWhereUsed.count > 1000000
  end

  def test_find
    v = VWhereUsed.where(principal_id: [1,10])
    p v
  end
  def test_all
    VWhereUsed.all.each do |w|
      puts w.principal_id
    end
  end
end