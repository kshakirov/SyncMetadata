require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestParts < MiniTest::Unit::TestCase
  def test_all
    part = Part.find('50038')
    p part
    assert_equal(part.manfr_part_num, '8-D-0913')
  end

  def test_part_sales_note
    part = Part.find('48509')
    sales_parts= part.salesnotepart.all
    refute_nil sales_parts
    p sales_parts
    sales_parts.each do |sales_part|
      notes = sales_part.salesnote.all
      refute_nil notes
      notes.each do |note|
        p note
      end
    end
  end
end