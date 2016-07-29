class PartDiff

  def initialize magento_host='localhost'
    @meta_part = MetaPart.new
    @magento_host = magento_host
  end

  def _get_meta_part sku
    @meta_part.init_meta_part sku
  end

  def _get_mag_part sku
    mag_part = RestClient.get("#{@magento_host}/critical/index/regression",
                              {:params => {:sku => sku}})
    JSON.parse(mag_part.body)
  end

  def _compare_critical mag, meta
    matched = []
    diff =[]
    abscent = []
    mag['critical'].each do |c|
      label = c["label"]
      if meta.key? label
         c['value'].to_f == meta[label] ? matched.push(label): diff.push(label)
      else
          abscent.push label
      end
    end
  return matched, diff, abscent
  end

  def compare_critical sku
    _compare_critical _get_mag_part(sku), _get_meta_part(sku)
  end

end