class AttributeConfigurer

  def initialize
    @options_configurer = AttributeOptionsConfigurer.new
  end

  def get_magento_type inner_type
    if inner_type=='DECIMAL'
      inner_type.downcase
    elsif inner_type == 'ENUMERATION'
      'int'
    else
      'text'
    end
  end

  def add_prefix_to_attribute_name part_type_name
    ps = part_type_name.split(' ')
    name = ''
    ps.each { |p|
      name += p[0]
    }
    name
  end

  def add_part_type_prefix name, part_type_name
    add_prefix_to_attribute_name(part_type_name) + '_' + name.underscore

  end
  def add_option_array_if_enum_type options, dimension
    if dimension.data_type == 'ENUMERATION'
      options[:options][:option] = @options_configurer.config_options_array dimension
    end
    options
  end

  def get_parent_name_by_parent_id parent_id
    if not parent_id.nil?
      parent = CritDim.where(id: parent_id)
      parent[0].idx_name if parent and parent.size > 0
    else
      nil
    end
  end


  def process_row dimension
    part_type_name = dimension.part_type.magento_attribute_set
    options = {
        :attribute_set => part_type_name,
        #:code => add_part_type_prefix(dimension.json_name, part_type_name),
        :code => dimension.idx_name,
        :options => {
            :label => dimension.name,
            :type => get_magento_type(dimension.data_type),
            :tolerance => dimension.tolerance || 0,
            :is_visible_in_list => dimension.is_visible_in_list || 0,
            :is_critical_dimension => dimension.is_critical_dimension || 1,
            :searchable => dimension.is_visible_in_list || 0,
            :filterable => dimension.is_visible_in_list || 0,
            :comparable => dimension.is_visible_in_list || 0,
            :is_filterable_in_search => dimension.is_visible_in_list || 0,
            :scale => dimension.scale,
            :length => dimension.length,
            :parent_id => get_parent_name_by_parent_id(dimension.parent_id),
            :unit => dimension.unit
        }

    }
    add_option_array_if_enum_type options, dimension
  end

  def run
    dimensions = CritDim.all
    magento_attributes = []
    dimensions.each do |dimension|
      magento_attributes.push(process_row dimension)
    end
    magento_attributes.to_json
  end

  def run_single code
    dimension = CritDim.where(idx_name: code).first
    response = process_row dimension
    response.to_json


  end
end