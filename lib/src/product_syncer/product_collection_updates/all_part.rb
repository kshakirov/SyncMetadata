module CollectionUpdate

  class AllPart
    def update_all
      counter = 0
      Part.find_each(batch_size: 100) do |p|
        begin
          if p.part_type.magento_attribute_set == part_type
            puts 'id  =>' + p.id.to_s
            YAML.dump @prod_attr_reader.run(p.id), @yaml_file
            counter += 1
          end
        rescue Exception => e
          counter -= 1
          puts e.message
        end

      end
      @yaml_file.close
      counter
    end
  end
end