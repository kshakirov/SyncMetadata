class CreatePartsAuditTable < ActiveRecord::Migration
  def change
    create_table :part_audits do |t|
      t.integer :part_id
      t.string :action
      t.timestamps null: false
    end
  end
end
