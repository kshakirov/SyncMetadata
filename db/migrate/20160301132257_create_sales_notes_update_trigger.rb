class CreateSalesNotesUpdateTrigger < ActiveRecord::Migration
  def up

    #добавляем ограничение CHECK
    execute <<-SQL
      CREATE TRIGGER `real_update_sales_notes` AFTER UPDATE ON `sales_note`
      FOR EACH ROW BEGIN
        INSERT INTO sales_notes_audits Set action = 'update', sales_note_id = NEW.id, created_at = NOW(), updated_at= NOW();
      END;
    SQL


  end

  def down

    execute <<-SQL
     DROP TRIGGER `real_update_sales_notes`
    SQL


  end
end
