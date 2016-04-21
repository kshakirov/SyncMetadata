require_relative "../test_helper"
require_relative "../../lib/sync"
class TestProductImageAudit < Minitest::Unit::TestCase
  def test_all
     records = ProductsImagesAudit.all
     p records
  end

end