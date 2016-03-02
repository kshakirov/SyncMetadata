class ExternalSystemsManagment
  def get_info host_url, entity
    if entity=='images'
      get_last_image_update_id host_url
    elsif entity=='notes'
      get_last_sales_note_update_id host_url
    end
  end

  def get_last_image_update_id host_url
    system = ExternalSystem.find_by url: host_url
    system.images_last
  end

  def get_last_sales_note_update_id host_url
    system = ExternalSystem.find_by url: host_url
    system.sales_notes_last
  end

  def set_last_image_update_id host_url, id
    system = ExternalSystem.find_by url: host_url
    system.images_last = id
    system.save
  end

  def set_last_sales_notes_update_id host_url, id
    system = ExternalSystem.find_by url: host_url
    system.sales_notes_last = id
    system.save
  end


  def set_info host_url, entity
    if entity== 'images'
      image_audit_last_record = ProductsImagesAudit.last
      set_last_image_update_id host_url, image_audit_last_record.id
    elsif entity== 'notes'
      sales_notes_audit_last_record = SalesNotesAudit.last
      set_last_sales_notes_update_id host_url, sales_notes_audit_last_record.id
    end
  end
end