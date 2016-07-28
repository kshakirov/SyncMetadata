require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestTurboType < Minitest::Unit::TestCase
  def test_all
    pa = TurboType.first
    assert_equal(1,pa.id)
    p pa.manfr.id

  end

end