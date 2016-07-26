class InterchangeAttributeReader

  def get_attribute id
    response = false
    ints = Vint.where(part_id: id)
    ints.each do |int|
      if not response
        response = int.i_part_id.to_s
      else
        response = response + ',' + int.i_part_id.to_s
      end
    end
    response
  end
end
