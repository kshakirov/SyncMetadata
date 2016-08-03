class PriceAttributeReader

  def get_attribute id
    response = JSON.parse(RestClient.get '52.9.105.129:8080/magmi/prices', {:params => {:id => id}})
    unless response.nil?
     return response[0] if response.size > 0
    end
    nil
  end

end