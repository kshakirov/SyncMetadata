class TurboTypeAttributeReader
  def process_turbo part_id
    turbo =  Turbo.find part_id
    turbo.turbo_model.turbo_type.name
  end
  def is_turbo part
    if part.part_type.name =="Turbo"
      true
    else
      false
    end
  end

  def get_attribute part
    if is_turbo part
      process_turbo part.id
    else
      false
    end
  end
end
