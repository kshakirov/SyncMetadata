class CreateCriticalDimsTriggers < ActiveRecord::Migration

  def up


    execute <<-SQL
        CREATE TRIGGER `piston_ring_update_trigger` AFTER UPDATE ON `piston_ring`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `journal_bearing_update_trigger` AFTER UPDATE ON `journal_bearing`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `gasket_update_trigger` AFTER UPDATE ON `gasket`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `compressor_wheel_update_trigger` AFTER UPDATE ON `compressor_wheel`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `turbine_wheel_update_trigger` AFTER UPDATE ON `turbine_wheel`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `bearing_housing_update_trigger` AFTER UPDATE ON `bearing_housing`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `heatshield_shroud_update_trigger` AFTER UPDATE ON `heatshield_shroud`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `nozzle_ring_update_trigger` AFTER UPDATE ON `nozzle_ring`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `backplate_update_trigger` AFTER UPDATE ON `backplate`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `bolt_screw_update_trigger` AFTER UPDATE ON `bolt_screw`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `fitting_update_trigger` AFTER UPDATE ON `fitting`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `journal_bearing_spacer_update_trigger` AFTER UPDATE ON `journal_bearing_spacer`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `nut_update_trigger` AFTER UPDATE ON `nut`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `pin_update_trigger` AFTER UPDATE ON `pin`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `retaining_ring_update_trigger` AFTER UPDATE ON `retaining_ring`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `seal_plate_update_trigger` AFTER UPDATE ON `seal_plate`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `spring_update_trigger` AFTER UPDATE ON `spring`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `thrust_bearing_update_trigger` AFTER UPDATE ON `thrust_bearing`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `thrust_collar_update_trigger` AFTER UPDATE ON `thrust_collar`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `thrust_spacer_update_trigger` AFTER UPDATE ON `thrust_spacer`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `thrust_washer_update_trigger` AFTER UPDATE ON `thrust_washer`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `washer_update_trigger` AFTER UPDATE ON `washer`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL

    execute <<-SQL
        CREATE TRIGGER `carbon_seal_update_trigger` AFTER UPDATE ON `carbon_seal`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
    SQL


  end

  def down


    execute <<-SQL
          DROP TRIGGER `piston_ring_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `journal_bearing_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `gasket_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `compressor_wheel_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `turbine_wheel_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `bearing_housing_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `heatshield_shroud_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `nozzle_ring_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `backplate_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `bolt_screw_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `fitting_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `journal_bearing_spacer_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `nut_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `pin_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `retaining_ring_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `seal_plate_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `spring_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `thrust_bearing_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `thrust_collar_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `thrust_spacer_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `thrust_washer_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `washer_update_trigger`
    SQL

    execute <<-SQL
          DROP TRIGGER `carbon_seal_update_trigger`
    SQL


  end
end