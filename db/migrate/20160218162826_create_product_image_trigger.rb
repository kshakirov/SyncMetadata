class CreateProductImageTrigger < ActiveRecord::Migration
  def up

    #добавляем ограничение CHECK
    execute <<-SQL
      CREATE TRIGGER `update_product_images` AFTER INSERT ON `product_image`
      FOR EACH ROW BEGIN
        INSERT INTO products_images_audits Set action = 'insert', image_id = NEW.id, part_id = NEW.part_id , created_at = NOW(), updated_at= NOW();
      END;
    SQL


  end

  def down

    execute <<-SQL
     DROP TRIGGER `update_product_images`
    SQL


  end
end
