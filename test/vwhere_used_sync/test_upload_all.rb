require_relative '../test_helper'
#puts Benchmark.measure {BomDescendant.all.first.bom.parent_part_id}


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


id = 43897
childs = Bom.where('child_part_id=?', id)
p childs
childs.each do |child|
  find_interchanges child.parent_part_id
end