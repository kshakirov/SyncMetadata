class WhereUsedAttrReader

  def initialize
    @keys_limit = 50
  end

  def limit_response_size response
    if response.size > @keys_limit
      limited_response = {}
      i = 0
      response.each_key do |key|
        if i <@keys_limit
          limited_response[key] = response[key]
          i += 1
        else
          return limited_response
        end
      end
    end
    response
  end

  def get_attribute id
    vw = VWhereUsed.where(principal_id: id)
    response = {}
    if vw.size > 0
      vw.each do |v|
        aggregate_turbo_part_numbers response, get_main_fields(v)
      end
      limit_response_size response
    else
      nil
    end
  end

  private
  def get_main_fields item
    main = {
        "sku": item.sku,
        "manufacturer": item.manufacturer,
        "partNumber": item.part_number,
        "tiSku": item.ti_sku,
        "tiPartNumber": item.ti_part_number,
        "partType": item.part_type,
        "turboType": item.turbo_type,
        "turboPartNumbers": item.turbo_part_number,
    }

  end

  def aggregate_turbo_part_numbers response, item_new
    if response.has_key? item_new[:sku]
      response[item_new[:sku]][:turboPartNumbers].push item_new[:turboPartNumbers]
    else
      response[item_new[:sku]] = item_new
      response[item_new[:sku]][:turboPartNumbers] = [item_new[:turboPartNumbers]]

    end
  end
end
