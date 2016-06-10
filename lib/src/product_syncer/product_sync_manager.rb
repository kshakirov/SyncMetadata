class ProductSyncManager

  def initialize
    @yaml_file = File.open(__dir__ + '/../../../public/all_products.yml', 'w')
    @prod_attr_reader = ProductAttrsReader.new
    @crit_dim_part_types = CritDim.select(:part_type_id).distinct
    class_creator = CritDimClassesCreator.new
    class_creator.dynamically_create_classes
  end

  def _has_crit_dim_attrs? id
    @crit_dim_part_types.each do |p|
      if p.part_type_id == id
        return true
      end

    end
    false
  end

  def _is_part_type_allowed? part_type_name
    if part_type_name.downcase.include? 'part'
      false
    end
    true
  end


  def _add_products_to_collection
    Part.find_each(batch_size: 100) do |p|
      begin
        if _has_crit_dim_attrs? p.part_type_id and _is_part_type_allowed? p.part_type.magento_attribute_set
          puts 'id  =>' + p.id.to_s
          YAML.dump @prod_attr_reader.run(p.id), @yaml_file
        end
      rescue Exception => e
        puts e.message
        #@yaml_file.close
      end

    end
    @yaml_file.close
  end

  def update_all_products
    _add_products_to_collection
  end

  def update_products audit_records
    updated_products = []
      audit_records.each do |record|
        updated_products.push(@prod_attr_reader.run(record['id']))
      end
    updated_products.to_json
  end


  def update_products_by_ids ids
    updated_products = []
    ids.each do |id|
      updated_products.push @prod_attr_reader.run(id)
    end
    updated_products.to_json
  end
end