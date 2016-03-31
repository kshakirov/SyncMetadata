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
    finder = VWhereUsedFinder.new
    finder.find_by_id id, page
  end
  def find_by_group id, page=1
    finder = VWhereUsedFinder.new
    finder.find_by_group id, page.to_i
  end
end