require 'sinatra'
require 'json'
require_relative 'app_helper'
require_relative 'lib/sync'
require 'pry'
require 'pry-nav'


set :bind, '0.0.0.0'
set :port, 4568
set :images_collection, ENV['METADATA_IMAGES_COLLECTION']
set :file_server_dir, ENV['METADATA_FILESERVER_DIR']
configure do
  set :configManager,  ConfigManager.new
  set :productSyncManager,  ProductSyncManager.new
end



p ENV['RAILS_ENV']
p :environment

get '/sync/test' do

  test = {:message => request.host }
  test.to_json
end

get '/sync/sales_notes/'  do
  syncer = SalesNotesSyncer.new
  notes= syncer.sync_all
  notes.to_json

end

get '/config/attributes/' do
  settings.configManager.get_critical_dimension_attributes
end

get '/config/attributeSets/' do
  settings.configManager.get_attribute_sets
end

get '/files/:filename' do |filename|
  send_file "public/#{filename}", :filename => filename, :type => 'Application/octet-stream'
end

post '/product/update/specific' do
    ids = JSON.parse(request.body.read)
    settings.productSyncManager.update_products_by_ids ids
end


get '/sync/sales_notes/updates'  do
    system = ExternalSystemsManagment.new
    last_id = system.get_info request.host,'notes'
    syncer = SalesNotesSyncer.new
    notes= syncer.sync_by_last_note_id last_id
    if notes
      response = {:result => true, data: notes  }
      system.set_info request.host, 'notes'
    else
      response = {:result => false}
    end
    response.to_json
end

get '/sync/system/:entity' do
  system = ExternalSystemsManagment.new
  system_info= {:host => request.host, :last => system.get_info('localhost',params[:entity])}
  system_info.to_json
end




get '/sync/product_images/updates'  do
  system = ExternalSystemsManagment.new
  last_id = system.get_info request.host,'images'
  syncer = ProductsImagesSyncer.new settings.images_collection, settings.file_server_dir
  result = syncer.get_updates last_id
  if result
    response = {:result => true, :path => 'images.tar.gz' }
    system.set_info request.host, 'images'
  else
    response = {:result => false, :reason => 'empty' }
  end
  response.to_json

end

get '/sync/product_images/all'  do
  syncer = ProductsImagesSyncer.new settings.images_collection, settings.file_server_dir
  syncer.sync_all
  response = {:result => true, :path => 'all_images.json'}
  response.to_json
end
