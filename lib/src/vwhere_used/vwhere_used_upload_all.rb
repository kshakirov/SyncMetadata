class VWhereUsedUploadAll

  def process_record record
    values = {}
    record.attributes.each do |k,v|
      #puts "#{k} => #{v}"
      values[k.to_sym] = v
    end
    values
  end


  def test_run
    vws = []
    VWhereUsed.limit(10).each do |wv|
     vws.push(process_record wv)
    end

  vws
  end

  def run
    vws = []
    VWhereUsed.all.each do |wv|
      vws.push(process_record wv)
    end

    vws
  end
end