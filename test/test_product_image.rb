require_relative "test_helper"
require_relative "../lib/sync"
class TestProductImage < Minitest::Unit::TestCase
  def test_all
    images = ProductImage.all
    refute_nil images



  end



  def test_audit_reader
    syncer = ProductsImagesSyncer.new "/var/product_images/", "/tmp/fileserver/"
    syncer.sync_all

  end

  def teardown

    @fd.close

  end

end