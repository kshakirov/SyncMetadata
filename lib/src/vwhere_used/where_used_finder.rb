class VWhereUsedFinder
  def find_by_id id, page
    per_page = 10
    useds = VWhereUsed.where("principal_id = ?", id).paginate(:page => page, :per_page => per_page)
    response = {:useds => useds, :current_page  => page, :total_pages => useds.total_pages, :per_page => per_page   }
    response.to_json
  end
end