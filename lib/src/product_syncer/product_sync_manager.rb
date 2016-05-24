class ProductSyncManager

  def initialize
    @yaml_file = File.open('data.yml', 'w')
    @prod_attr_reader = ProductAttrsReader.new
    @crit_dim_part_types = CritDim.select(:part_type_id).distinct
  end

  def _has_crit_dim_attrs? id
    @crit_dim_part_types.each do |p|
      if p.part_type_id == id
        return true
      end

    end
    false
  end


  def _add_products_to_collection
    Part.find_each(batch_size: 100) do |p|
      begin
        if _has_crit_dim_attrs? p.part_type_id
          YAML.dump @prod_attr_reader.run(p.id), @yaml_file
        end
      rescue Exception => e
        puts e.message
        @yaml_file.close
      end
    end
    @yaml_file.close
  end

  def update_all_products
    _add_products_to_collection
  end

  def update_products

  end
end