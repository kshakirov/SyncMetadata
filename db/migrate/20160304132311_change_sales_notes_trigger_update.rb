class ChangeSalesNotesTriggerUpdate < ActiveRecord::Migration
  def up

    #добавляем ограничение CHECK
    execute <<-SQL
     DROP TRIGGER `real_update_sales_notes`
    SQL
    execute <<-SQL
      CREATE TRIGGER `real_update_sales_notes` AFTER UPDATE ON `sales_note`
      FOR EACH ROW BEGIN
        INSERT INTO sales_notes_audits Set action = 'update', sales_note_id = NEW.id, state = NEW.state,  created_at = NOW(), updated_at= NOW(), old_state=OLD.state;
      END;
    SQL


  end

  def down

    execute <<-SQL
     DROP TRIGGER `real_update_sales_notes`
    SQL


  end
end
