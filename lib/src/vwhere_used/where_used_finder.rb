class VWhereUsedFinder
  def initialize
    @per_page = 10
  end

  def find_by_id id, page
    useds = VWhereUsed.where("principal_id = ?", id).paginate(:page => page, :per_page => @per_page)
    response = {:records => useds, :current_page => page, :total_pages => useds.total_pages, :per_page => @per_page}
    response.to_json
  end

  def find_by_group id, page
    useds = VWhereUsed.where("principal_id = ?", id).group(:sku)
    result = useds.count
    items = result.values.sum
    size = result.size
    total_pages = (size.to_f/@per_page).ceil
    keys = result.keys
    paged_keys = keys[(page -1)*@per_page..(page*@per_page -1)]
    response = {:records => {}, :page => page, :total_items => size, :total_pages => total_pages, :total_parts => items,
                :principal_type => false}
    paged_keys.each do |key|
      response[:records][key] = {}
      response[:records][key][:names] = VWhereUsed.where("principal_id = ? AND sku=?", id, key).first(5)
      item = response[:records][key][:names][0]
      if item
        response[:records][key][:part_number] = item.part_number
        response[:records][key][:manufacturer] = item.manufacturer
        response[:records][key][:principal_type] = item.principal_type
        response[:records][key][:part_type] = item.part_type
        response[:records][key][:ti_part_number] = item.ti_part_number
        response[:principal_type] = item.principal_type unless response[:principal_type]

      end
    end
    response.to_json
  end

  def find_interchanges id
    begin
      header = InterchangeItem.find id

      interchanges = InterchangeItem.where("interchange_header_id=?", header.interchange_header_id)
      response = {:records => []}

      ids = []
      interchanges.each do |i|
        unless i.part_id == id
          ids.push i.part_id
        end
      end

      results = Part.where(:id => ids)
      p results
    rescue ActiveRecord::RecordNotFound => e
      nil
    end

  end

  def find_direct id, page

    childs = Bom.where('child_part_id=?', id)
    childs.each do |child|
      find_interchanges child.parent_part_id
    end
    childs.to_json
  end
end