class VWhereUsedUploadAll


  def initialize
    @fd = File.open("vwhere_used.yml","w")
  end

  def process_record record
    values = {}
    puts record.id
    record.attributes.each do |k, v|
      #puts "#{k} => #{v}"
      values[k.to_sym] = v
    end
    @fd.write values.to_yaml
  end


  def run
    VWhereUsed.find_in_batches.with_index do |th,batch|
      puts "Batch => #{batch}"
      th.each do |wv|
        process_record wv
      end
    end
    @fd.close
  end
end