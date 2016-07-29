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
      p.part_type.magento_attribute_set.downcase.include? 'part' ? false : true
    end

    def update_critical_products
      Part.find_each(batch_size: 100) do |p|
        begin
          if _has_crit_dim_attrs? p and _is_part_type_allowed? p
           log p
          end
        rescue Exception => e
          puts e.message
        end

      end
      @yaml_file.close
    end
  end
end