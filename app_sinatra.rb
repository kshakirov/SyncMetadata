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




get '/config/attributes/' do
  settings.configManager.get_critical_dimension_attributes
end

get '/config/attributes/:code' do
  settings.configManager.get_critical_dimension_attribute params[:code]
end


get '/config/attributeSets/' do
  settings.configManager.get_attribute_sets
end

get '/files/:filename' do |filename|
  send_file "public/#{filename}", :filename => filename, :type => 'Application/octet-stream'
end


get '/product/update/' do
  settings.productSyncManager.update_products request
end

post '/product/update/specific' do
    ids = JSON.parse(request.body.read)
    settings.productSyncManager.update_products_by_ids ids
end



get '/sync/system/:entity' do
  system = ExternalSystemsManagment.new
  system_info= {:host => request.host, :last => system.get_info('localhost',params[:entity])}
  system_info.to_json
end




