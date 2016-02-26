class CreateProductImageDeleteTrigger < ActiveRecord::Migration
  def up

    #добавляем ограничение CHECK
    execute <<-SQL
      CREATE TRIGGER `delete_product_images` AFTER DELETE ON `product_image`
      FOR EACH ROW BEGIN
        INSERT INTO products_images_audits Set action = 'delete', image_id = OLD.id, part_id = OLD.part_id , created_at = NOW(), updated_at= NOW();
      END;
    SQL


  end

  def down

    execute <<-SQL
     DROP TRIGGER `delete_product_images`
    SQL


  end
end
