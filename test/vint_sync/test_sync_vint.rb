require 'minitest/autorun'
require_relative "../test_helper"

class TestVintSync <Minitest::Unit::TestCase
  def test_one
    manager = VintSyncManager.new
    response = manager.find_by_id 42809
    refute_nil response
    p response

  end

  def test_table
    id = 45077
    header = InterchangeItem.find 45077
    interchanges = InterchangeItem.where("interchange_header_id=?", header.interchange_header_id);
    response = {:records => []}
    interchanges.each do |i|
      unless i.part_id == id
        part = Part.find(i.part_id)
        p part.manfr.name
        p part.manfr_part_num
        response[:records].push({:i_part_number => part.manfr_part_num,:i_manufacturer => part.manfr.name})

      end
    end
    response.to_json
  end

  def test_all_together
    id = 45077
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

  end

end