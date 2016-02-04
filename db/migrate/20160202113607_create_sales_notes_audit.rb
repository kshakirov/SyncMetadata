class CreateSalesNotesAudit < ActiveRecord::Migration
  def change
    create_table :sales_notes_audits do |audit|
      audit.string "action"
      audit.integer "part_id"
      audit.timestamps null: false
    end
  end
end
