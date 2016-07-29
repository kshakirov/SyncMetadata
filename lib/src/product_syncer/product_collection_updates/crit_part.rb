module CollectionUpdate
  class CritPart < Base
    def _has_crit_dim_attrs? p
      id = p.part_type_id
      @crit_dim_part_types.each do |p|
        if p.part_type_id == id
          return true
        end
      end
      false
    end

    def _is_part_type_allowed? p
      p.part_type.magento_attribute_set.downcase.include?('part') ? false : true
    end

    def update_critical_products
      counter_in, counter_out = 0
      Part.find_each(batch_size: 100) do |p|
        begin
          if _has_crit_dim_attrs? p and _is_part_type_allowed? p
           log p
            counter_in += 1
          end
        rescue Exception => e
          log_reject p, e
          counter_out += 1
        end

      end
      @yaml_file.close
      return counter_in, counter_out
    end
  end
end