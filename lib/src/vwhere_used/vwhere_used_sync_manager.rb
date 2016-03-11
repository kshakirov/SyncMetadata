class VWhereUsedSyncManager
  def run_all
    uploader = VWhereUsedUploadAll.new
    packer = VWhereUsedPacker.new
    records = uploader.run
    packer.pack(records)
  end
  def run_update

  end
end