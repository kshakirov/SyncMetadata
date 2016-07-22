require 'minitest/autorun'
require_relative "../test_helper"

class TestBearingSpacer < Minitest::Unit::TestCase

  def setup
    @sql_template = ERB.new %q{
     def up


      <%types.each do |type|%>
       execute <<-SQL
          DROP TRIGGER  IF EXISTS `<%= type[:trigger_name]%>`
        SQL
        execute <<-SQL
        CREATE TRIGGER `<%= type[:trigger_name]%>` AFTER UPDATE ON `<%= type[:table_name]%>`
        FOR EACH ROW BEGIN
          INSERT INTO part_audits Set action = 'update', part_id = NEW.part_id, created_at = NOW(), updated_at= NOW();
        END;
      SQL
      <%end%>

    end

    def down

        <%types.each do |type|%>
        execute <<-SQL
          DROP TRIGGER `<%= type[:trigger_name]%>`
        SQL
        <%end%>

    end
    }
  end


  def test_all
    analyzer = PartTypeAnalyzer.new
    crit_dims = analyzer._get_crit_dims_part_types
    types = []
    crit_dims.each do |c|
      part_type = PartType.find c.part_type_id
      unless part_type.magento_attribute_set=='Part'
        type = {}
        type[:table_name] = part_type.value
        type[:trigger_name] = part_type.value + '_update_trigger'
        types.push type
      end

    end

    sql = @sql_template.result(binding)
    puts sql

  end

end