module CollectionUpdate

  class Base
    def initialize
      @yaml_file = File.open(__dir__ + '/../../../../public/all_products.yml', 'w')
      @prod_attr_reader = ProductAttrsReader.new
      @crit_dim_part_types = CritDim.select(:part_type_id).distinct
      class_creator = CritDimClassesCreator.new
      class_creator.dynamically_create_classes
    end
    def log p
      puts "Updated Part id [#{p.id.to_s}]"
      YAML.dump @prod_attr_reader.run(p.id), @yaml_file
    end

    def log_reject p, e
      puts "Rejected Part id [#{p.id.to_s}], reason: [#{e.message}]"
    end
    def is_active p
      ! p.inactive
    end
  end


  class ByPart < Base

    def _is_needed_part_type p, part_type
      p.part_type.magento_attribute_set == part_type ? true :false
    end

    def _collect_products_by_part_type part_type
      counter_in = 0
      counter_out =0
      Part.find_each(batch_size: 100) do |p|
        begin
          if _is_needed_part_type(p, part_type) and is_active p
            log p
            counter_in += 1
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