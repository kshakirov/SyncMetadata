class DiffPrinter
  def initialize
    @fd = File.open('var/results.dat', "w")
  end

  def print_size meta, mag, part_type
    @fd.puts "################ #{part_type} #################################"
    @fd.puts "METADATA: #{meta.size.to_s} visible parts  -   MAGENTO: #{mag.size.to_s} visible parts  = DIFF: #{(meta.size - mag.size).to_s}"
  end

  def print_diff_ids meta, mag
    if mag.size > 0
      @fd.puts "These are part numbers  which are visible  in Magento  but not visible in Metadata"
      @fd.puts "TI                  OE"
      mag.each do |m|
        @fd.puts m['ti'].to_s + ',             ' + m['oe'].to_s
      end
    elsif mag.size==0 and meta[0].size ==0 and meta[1].size ==0
      @fd.puts "Congratulations: All visible parts either in Magento, or in Metadata Database are equal by number and by skus!!!"
    end

  end
end