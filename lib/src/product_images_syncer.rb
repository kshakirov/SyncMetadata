require 'zlib'
require 'archive/tar/minitar'
require 'date'

class ProductsImagesSyncer

  def initialize import_dir, file_server_dir

    @import_dir = import_dir
    @file_server_dir = file_server_dir
    _prepair_folders
    @fd= File.open("#{@file_server_dir}/images/image_updates.json", 'w')

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


  def _prepair_folders
    if(File.exists? (@file_server_dir + 'images'))
      FileUtils.rm_rf @file_server_dir + 'images'

    end
    FileUtils.makedirs @file_server_dir + 'images'
    FileUtils.makedirs @file_server_dir + 'images/1000'
    FileUtils.makedirs @file_server_dir + 'images/135'
    FileUtils.makedirs @file_server_dir + 'images/50'
  end


  def _create_images_archive
    FileUtils.chdir @file_server_dir
    File.open('images.tar', 'wb') { |tar| Archive::Tar::Minitar.pack('images', tar) }
    orig = 'images.tar'
    Zlib::GzipWriter.open('images.tar.gz') do |gz|
      gz.mtime = File.mtime(orig)
      gz.orig_name = orig
      gz.write IO.binread(orig)
    end
    FileUtils.remove orig
    FileUtils.rm_rf "images"

  end


  def get_updates
    all = ProductsImagesAudit.all
    image_folders = ['1000','135',50]
    done = false
    previous_dir = __FILE__
    images_update_info = []
    items = []
    all.each do |update|
      image = ProductImage.find(update.image_id)
      item = {:sku => image.part_id, :images => []}
      image_folders.each do |folder|

        file_name = "#{image.part_id}_#{image.id}.jpg"
        import_file_path = "#{@import_dir}resized/#{folder}/"
        if File.exist? (import_file_path + file_name)
          puts file_name
          done = true
          image_item = {}
          image_item[folder] = file_name
          item[:images].push image_item
          FileUtils.copy(import_file_path + file_name, @file_server_dir +  'images/' + folder.to_s + '/' + file_name)
        end
      end
      items.push item

    end
    if done
      @fd.write items.to_json
      @fd.close
      _create_images_archive

    end

  end


end