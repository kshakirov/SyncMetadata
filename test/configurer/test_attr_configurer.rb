require 'minitest/autorun'
require_relative "../test_helper"

class TestAttrConfigurer < MiniTest::Unit::TestCase
  def setup
    @configurer = AttributeConfigurer.new
  end

  def test_all
    attrs = @configurer.run
    attrs = JSON.parse attrs
    p attrs
    assert_equal 1, attrs[2]['options']['tolerance']
    assert_equal 3, attrs[2]['options']['scale']
    assert_equal 6, attrs[2]['options']['length']

    assert_equal 0, attrs[0]['options']['tolerance']
  end
end