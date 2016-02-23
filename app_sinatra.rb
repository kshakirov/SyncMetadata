require 'sinatra'
require 'json'
require_relative 'app_helper'
require_relative 'lib/sync'
set :bind, '0.0.0.0'
set :images_collection, ENV['METADATA_IMAGES_COLLECTION']
set :file_server_dir, ENV['METADATA_FILESERVER_DIR']


p ENV['RAILS_ENV']
p :environment

get '/sync/test' do
  test_hello = {:message => 'Hello, world!'}
  test_hello.to_json
end

get '/sync/sales_notes/'  do
  syncer = SalesNotesSyncer.new
  notes= syncer.sync_all
  notes.to_json

end


get '/sync/sales_notes/:id'  do
  if params[:id]
    syncer = SalesNotesSyncer.new
    notes= syncer.sync_by_last_note_id params[:id].to_i
    notes.to_json
    end
end


get '/sync/product_images/updates'  do
  syncer = ProductsImagesSyncer.new settings.images_collection, settings.file_server_dir
  syncer.get_updates
  response = {:result => 'success', :name => 'images.tar.gz' }
  response.to_json

end
