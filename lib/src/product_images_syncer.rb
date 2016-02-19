class ProductsImagesSyncer
  require 'date'

  def initialize import_dir= "/var/www/magento/magento/media/import/"
    @fd= File.open("var/images#{DateTime.now.to_time.to_i}.json", 'w')
    @import_dir = import_dir
  end

  def search_files image, index
    file_path = @import_dir
    dirs = ['1000/', '135/', '50/']
    image_roles = ['image', 'small_image', 'thumbnail']
    paths = []
    dirs.each_with_index do |dir, i|

      filename = dir + image.part_id.to_s + "_" + image.id.to_s + ".jpg"
      if File.exist? (file_path + filename)
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

  def sync_all
    products = Part.all
    images_data = []
    products.each do |p|
      if p.product_image.all.size > 0
        images = p.product_image.all
        image_data = {:sku => p.id, :images => []}
        images.each_with_index do |image, index|
          image_data[:images].push(search_files image, index)
        end
        images_data.push image_data
      end

    end
    write_csv_from_image_data images_data
    @fd.close
    images_data
  end


end