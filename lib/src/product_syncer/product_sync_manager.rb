class ProductSyncManager

  def initialize
    @yaml_file = File.open(__dir__ + '/../../../public/all_products.yml', 'w')
    @prod_attr_reader = ProductAttrsReader.new
    @crit_dim_part_types = CritDim.select(:part_type_id).distinct
    class_creator = CritDimClassesCreator.new
    class_creator.dynamically_create_classes
    @external_systems = ExternalSystemsManagment.new
  end

  def _get_part_audit_records last_id
    PartAudit.where("id > ?", last_id)
  end


  def update_products request
    updated_products = []
    remote_host_addr = request.env['REMOTE_ADDR']
    last_id = @external_systems.get_info  remote_host_addr, 'parts'
    audit_records = _get_part_audit_records last_id
    last_audit_id = 0
    audit_records.each do |record|
      update = @prod_attr_reader.run(record.part_id)
      updated_products.push(update)
      last_audit_id = record.id
    end
    @external_systems.set_info remote_host_addr, 'parts', last_audit_id
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