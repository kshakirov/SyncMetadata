class SalesNotesSyncConfigManager
  def old
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
end
