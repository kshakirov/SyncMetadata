require 'sinatra'
require 'json'
require_relative 'app_helper'
require_relative 'lib/sync'
set :bind, '0.0.0.0'
if not  ENV['RAILS_ENV']
  exit(1)
end

set :database_file, "config/" + ENV['RAILS_ENV'] +  "/database.yml"

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


get '/sync/product_images/'  do
  syncer = ProductsImagesSyncer.new   "/var/www/magento/magento/media/import/"
  images = syncer.sync_all
  images.to_json

end
