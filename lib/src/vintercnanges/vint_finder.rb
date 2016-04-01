class VintFinder
  def find_by_id id,page
    interchanges = Vint.where('part_id=?',id).first(10)
    response = {:records => interchanges, :size => 10}
    response.to_json
  end
end