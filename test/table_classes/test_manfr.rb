require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestManfr < Minitest::Unit::TestCase
  def test_all
    pa = Manfr.first
    assert_equal(1,pa.id)
    p pa.turbo_type.where('import_pk = ?', 564 )

  end

end