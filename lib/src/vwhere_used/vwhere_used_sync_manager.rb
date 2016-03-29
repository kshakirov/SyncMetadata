class VWhereUsedSyncManager
  def run_all
    uploader = VWhereUsedUploadAll.new
    packer = VWhereUsedPacker.new
    records = uploader.run
    packer.pack(records)
  end
  def run_update

  end
  def get_by_id id, page=1
    useds = VWhereUsed.where("principal_id = ?", id).paginate(:page => 1, :per_page => 10)
    useds.to_json
  end
end