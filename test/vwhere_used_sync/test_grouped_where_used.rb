require_relative '../test_helper'
class TestUploadAll < Minitest::Unit::TestCase
  def test_grouped
    finder  = VWhereUsedFinder.new
    response = finder.find_by_group 45077,1

    response = finder.find_by_group 45077,7
    p response
  end


end