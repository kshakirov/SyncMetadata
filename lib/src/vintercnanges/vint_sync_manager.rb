class VintSyncManager
  def initialize
    @finder = VintFinder.new
  end
  def find_by_id id, page=1
    @finder.find_join_by_id id, page
  end
end
