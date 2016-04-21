class ProductImageManager
  def get_audit_records
    records = ProductsImagesAudit.all
    records.to_json
  end

  def run params
    get_audit_records
  end
end