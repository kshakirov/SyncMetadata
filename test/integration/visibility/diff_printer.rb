class DiffPrinter
  def initialize
    @fd = File.open('var/results.dat', "w")
  end
  def print_size meta, mag, part_type
    @fd.puts "################ #{part_type} #################################"
    @fd.puts "METADATA: #{meta.size.to_s}         MAGENTO: #{mag.size.to_s}     DIFF: #{(meta.size - mag.size).to_s}  "
  end
  def print_diff_ids meta, mag
    @fd.puts "Missed in Metadata part numbers"
    meta[0].each do |m|
      @fd.puts m
    end

    @fd.puts "Not found in metadata databaze"
    meta[1].each do |m|
      @fd.puts m
    end

    @fd.puts "Analogue in Magento \n TI            OE"
    mag.each do |m|
      @fd.puts m['ti'].to_s + ',             ' + m['oe'].to_s
    end

  end
end