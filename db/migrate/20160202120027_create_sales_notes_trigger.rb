class CreateSalesNotesTrigger < ActiveRecord::Migration
  def up

    #добавляем ограничение CHECK
    execute <<-SQL
      CREATE TRIGGER `update_sales_notes` AFTER INSERT ON `sales_note`
      FOR EACH ROW BEGIN
        INSERT INTO sales_notes_audits Set action = 'insert', sales_note_id = NEW.id, created_at = NOW(), updated_at= NOW();
      END;
    SQL


  end

  def down

    execute <<-SQL
     DROP TRIGGER `update_sales_notes`
    SQL


  end
end
