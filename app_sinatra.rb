require 'sinatra'
require 'json'
require_relative 'app_helper'
require_relative 'lib/sync'
set :bind, '0.0.0.0'
get '/sync/test' do
  syncer = SalesNotesSyncer.new
  skus = syncer.sync_by_timestamp
  skus.to_json
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

