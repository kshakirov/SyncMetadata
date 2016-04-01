require 'sinatra'
require 'json'
require_relative 'app_helper'
require_relative 'lib/sync'
require 'pry'
require 'pry-nav'
require 'will_paginate'
require 'will_paginate/active_record'


set :bind, '0.0.0.0'
set :port, 4568
set :images_collection, ENV['METADATA_IMAGES_COLLECTION']
set :file_server_dir, ENV['METADATA_FILESERVER_DIR']


p ENV['RAILS_ENV']
p :environment

get '/sync/test' do
  content_type :json
  test = {:message => request.host }
  test.to_json
end

get '/sync/sales_notes/'  do
  syncer = SalesNotesSyncer.new
  notes= syncer.sync_all
  notes.to_json

end


get '/sync/vwhere_used/:id/group' do
  content_type :json
  sync = VWhereUsedSyncManager.new
  sync.find_by_group params[:id], params[:page]
end

get '/sync/vint/:id' do
  content_type :json
  sync = VintSyncManager.new
  sync.find_by_id params[:id], params[:page]
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
