class HasTiChra
  def get_attribute id
    val = VmagmiTiChra.find id
    if val.has_ti_chra == 'no'
      return false
    elsif val.has_ti_chra == 'yes'
      return true
    end
    false
  end
end