require_relative "test_helper"
require_relative "../lib/sync"
class TestProductImage < Minitest::Unit::TestCase
  # def test_all
  #   images = ProductImage.all
  #   refute_nil images
  #
  #
  #
  # end


  def setup
    @fd= File.open("images.json", 'w')
  end




  def search_files image,index
    file_path = "/var/www/magento/magento/media/import/"
    dirs = ['1000/','135/','50/']
    image_roles = ['image','small_image','thumbnail']
    paths = []
    dirs.each_with_index  do |dir, i|

      filename =  dir + image.part_id.to_s + "_" + image.id.to_s + ".jpg"
      if File.exist?  (file_path + filename)
        #puts  "Exists #{filename}"
        image_object = {}
        image_object[image_roles[i]] = filename
        paths.push image_object

      end
    end
    paths
  end

  def write_csv_from_image_data data
    @fd.write data.to_json
  end

  def test_part_fk
    products = Part.all
    images_data = []
    products.each do |p|
      if p.product_image.all.size > 0
        images = p.product_image.all
        image_data = {:sku => p.id, :images => []}
        puts "Not empty #{p.id}"
        images.each_with_index  do |image,index|
          image_data[:images].push(search_files image, index)
        end
        images_data.push image_data
      else
        puts "Empty #{p.id}"
      end

    end
    write_csv_from_image_data images_data

  end


  def test_audit_reader
    syncer = ProductsImagesSyncer.new "/var/product_images/", "/tmp/fileserver/"
    syncer.get_updates

  end

  def teardown

    @fd.close

  end

end