module CollectionUpdate

  class AllPart < Base
    def update_all
      counter_in, counter_out = 0,0
      Part.find_each(batch_size: 100) do |p|
        begin
          if is_active p
            log p
            counter_in += 1
          else
            counter_out += 1
          end
        rescue Exception => e
          counter_out += 1
          log_reject p, e
        end

      end
      @yaml_file.close
      return counter_in, counter_out
    end
  end
end