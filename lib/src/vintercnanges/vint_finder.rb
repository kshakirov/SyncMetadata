class VintFinder
  def find_by_id id, page
    interchanges = Vint.where('part_id=?', id).first(10)
    response = {:records => interchanges, :size => 10}
    response.to_json
  end

  def find_join_by_id id, page
    header = InterchangeItem.find id
    interchanges = InterchangeItem.where("interchange_header_id=?", header.interchange_header_id)
    response = {:records => []}
    interchanges.each do |i|
      unless i.part_id == id
        part = Part.find(i.part_id)
        p part.manfr.name
        p part.manfr_part_num
        response[:records].push({:i_part_number => part.manfr_part_num, :i_manufacturer => part.manfr.name})

      end
    end
    response.to_json
  end

end