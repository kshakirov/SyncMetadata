require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestM_Views < Minitest::Unit::TestCase
  def test_ti
    has_ti_chra = VmagmiTiChra.first
    p has_ti_chra

  end

end