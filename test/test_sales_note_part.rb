require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestSalesNotePart < MiniTest::Unit::TestCase
  def test_all
    parts = Salesnotepart.all

  end
  def test_parts_notes
    note = Salesnotepart.first.salesnote.first.state
    refute_nil note
    p note
    assert_equal note, 'draft'
  end
end