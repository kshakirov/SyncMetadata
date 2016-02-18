class CreateProductImageAudits < ActiveRecord::Migration
  def change
    create_table :products_images_audits do |audit|
      audit.string "action"
      audit.integer "image_id"
      audit.integer "part_id"
      audit.timestamps null: false
    end
  end
end
