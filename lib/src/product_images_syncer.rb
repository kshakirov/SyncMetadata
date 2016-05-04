require 'zlib'
require 'archive/tar/minitar'
require 'date'

class ProductsImagesSyncer

  def initialize import_dir, file_server_dir

    @import_dir = import_dir
    @file_server_dir = file_server_dir
    _prepair_folders

  end


  def has_product_older_images part_id, image_id
    images = ProductImage.where("part_id = ? and id < ?", part_id, image_id)
    if images.size > 0
      true
    else
      false
    end

  end



  def _prepair_folders
    if (File.exists? (@file_server_dir + 'images'))
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


  def get_updates id
    all = ProductsImagesAudit.where("id > ?", id)
    image_folders = ['1000', '135', 50]
    done = false
    previous_dir = __FILE__
    images_update_info = []
    items = []
    all.each do |update|
      begin
        if update.action=='insert'
          image = ProductImage.find(update.image_id)
          item = {:sku => image.part_id,
                  :images => [],
                  :action => update.action,
                  :base_image =>  !has_product_older_images(image.part_id, image.id)}

          image_folders.each do |folder|
            file_name = "#{image.part_id}_#{image.id}.jpg"
            import_file_path = "#{@import_dir}resized/#{folder}/"
            if File.exist? (import_file_path + file_name)
              puts file_name
              done = true
              image_item = {}
              image_item[folder] = file_name
              item[:images].push image_item
              FileUtils.copy(import_file_path + file_name, @file_server_dir + 'images/' + folder.to_s + '/' + file_name)
            end
          end
          items.push item
        elsif update.action=='delete'
          item = {:sku => update.part_id, :action => update.action}
          item[:image_name]= "#{update.part_id}_#{update.image_id}"
          items.push item
          done = true

        end
      rescue Exception => e
        puts "No Record with id "
      end
    end
    if done
      fd= File.open("#{@file_server_dir}/images/image_updates.json", 'w')
      fd.write items.to_json
      fd.close
      _create_images_archive

    end
    done
  end


  def create_images_archive items
    fd= File.open("#{@file_server_dir}/images/image_updates.json", 'w')
    fd.write items.to_json
    fd.close
    _create_images_archive
  end

  def create_image_temp_file image, item
    image_folders = ['1000', '135', 50]
    has_result = false
    image_folders.each do |folder|
      file_name = "#{image.part_id}_#{image.id}.jpg"
      import_file_path = "#{@import_dir}resized/#{folder}/"
      if File.exist? (import_file_path + file_name)
        puts file_name
        has_result = true
        image_item = {}
        image_item[folder] = file_name
        item[:images].push image_item
        FileUtils.copy(import_file_path + file_name, @file_server_dir + 'images/' + folder.to_s + '/' + file_name)

      end
    end
    has_result

  end

  def create_image_data_item image
    item = {:sku => image.part_id,
            :images => [],
            :action => 'insert',
            :base_image =>  !has_product_older_images(image.part_id, image.id)}
    item
  end

  def get_images_by_ids ids
    items = []
    is_archive_not_empty = false
    ids.each do |id|
      begin
      image = ProductImage.find(id.to_i)
      item = create_image_data_item image
      if create_image_temp_file(image,item)
        is_archive_not_empty = true
        items.push item
      end
      rescue Exception => e
        puts "No image " + id.to_s
      end
    end
    if is_archive_not_empty
      create_images_archive items
    end
  end


end