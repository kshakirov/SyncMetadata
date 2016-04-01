require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestVint <Minitest::Unit::TestCase
  def test_one
    v = Vint.first
    refute_nil v
  end

end