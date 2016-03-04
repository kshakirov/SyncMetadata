class CreatePartsTrigger < ActiveRecord::Migration
  def up

    #добавляем ограничение CHECK

    execute <<-SQL
     DROP TRIGGER `part_AFTER_INSERT`
    SQL

    execute <<-SQL
      CREATE TRIGGER `part_AFTER_INSERT` AFTER INSERT ON `part`
      FOR EACH ROW BEGIN
        insert into interchange_header (new_part_id) value (new.id);
        set @i_header_id_new = (select id from interchange_header where new_part_id = new.id);
        insert into interchange_item (part_id, interchange_header_id) values (new.id, @i_header_id_new);
        INSERT INTO part_audits Set action = 'insert', part_id = NEW.id, created_at = NOW(), updated_at= NOW();
      END
    SQL
  end

  def down
    execute <<-SQL
     DROP TRIGGER `part_AFTER_INSERT`
    SQL

    execute <<-SQL
      CREATE TRIGGER `part_AFTER_INSERT` AFTER INSERT ON `part`
      FOR EACH ROW BEGIN
        insert into interchange_header (new_part_id) value (new.id);
        set @i_header_id_new = (select id from interchange_header where new_part_id = new.id);
        insert into interchange_item (part_id, interchange_header_id) values (new.id, @i_header_id_new);
      END
    SQL


  end
end
