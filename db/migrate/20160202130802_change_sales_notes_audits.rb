class ChangeSalesNotesAudits < ActiveRecord::Migration
  def change
    rename_column :sales_notes_audits, :part_id, :sales_note_id
  end
end
