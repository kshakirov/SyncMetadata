require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestBearingSpacer < Minitest::Unit::TestCase
  def test_all
    crit_dim = CritDim.all
    assert crit_dim.size > 12
  end
  def test_parttype
    crit_dim = CritDim.first
    assert_equal "Bearing Housing", crit_dim.part_type.name
  end
  def test_json
    dims = CritDim.all
    dims.each do |d|

    end

  end
end