class ChangeExternalSystems < ActiveRecord::Migration
  def change
     change_table(:external_systems) do |t|
       t.column :sales_notes_last,  :integer, default: 0
       t.column :images_last, :integer, default: 0
     end
  end
end
