class PartsUpdateDeleteTrigger < ActiveRecord::Migration
  def up

   execute <<-SQL
      CREATE TRIGGER `part_update_trigger` AFTER UPDATE ON `part`
      FOR EACH ROW BEGIN
         INSERT INTO part_audits Set action = 'update', part_id = NEW.id, created_at = NOW(), updated_at= NOW();
      END;
    SQL

    execute <<-SQL
      CREATE TRIGGER `part_delete_trigger` AFTER DELETE ON `part`
      FOR EACH ROW BEGIN
         INSERT INTO part_audits Set action = 'delete', part_id = OLD.id, created_at = NOW(), updated_at= NOW();
      END;
    SQL


  end

  def down

    execute <<-SQL
     DROP TRIGGER `part_update_trigger`
    SQL

    execute <<-SQL
     DROP TRIGGER `part_delete_trigger`
    SQL


  end
end
