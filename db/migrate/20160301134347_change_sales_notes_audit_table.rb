class ChangeSalesNotesAuditTable < ActiveRecord::Migration
  def change
    add_column :sales_notes_audits, :old_state, :string
  end
end
