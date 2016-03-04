class ChangeSalesNotesAuditTableState < ActiveRecord::Migration
  def change
    add_column :sales_notes_audits, :state, :string
  end
end
