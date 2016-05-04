class ProductImageManager
  def get_audit_records
    records = ProductsImagesAudit.all
    records.to_json
  end

  def get_missed_images ids, images_collection_path, file_server_path
    product_syncer = ProductsImagesSyncer.new  images_collection_path, file_server_path
    product_syncer.get_images_by_ids ids["ids"]

  end

  def run params
    get_audit_records
  end



end