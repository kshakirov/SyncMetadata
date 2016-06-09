require 'minitest/autorun'
require_relative "../test_helper"

class TestProductsAttrsReader < MiniTest::Unit::TestCase
  def setup
    @reader = ProductCriticalAtttsReader.new
    @crit_dim_classes_creator = CritDimClassesCreator.new
  end

  def test_all
    refute_nil @reader
    @crit_dim_classes_creator.dynamically_create_classes
    attrs = @reader.get_crit_dim_attributes('13', 43895)
    assert_equal 35, attrs.size

    p attrs
  end



  def test_where_used
    @reader = WhereUsedAttrReader.new
    attrs = @reader.get_attribute 42492
    assert_equal 3,  attrs[62][:turboPartNumbers].size
    assert_equal "408105-0124",  attrs[62][:partNumber]

  end


  def test_ti_interchange
      @reader = HasTiInterchange.new
      attr = @reader.get_attribute 6392
      assert_equal false, attr
      attr = @reader.get_attribute 31
      assert_equal true, attr
  end


  def test_ti_chra
    @reader = HasTiChra.new
    attr = @reader.get_attribute 6392
    assert_equal false, attr
    attr = @reader.get_attribute 307
    assert_equal true, attr
  end

  def test_bom
    @reader = BomAttributeReader.new
    attrs = @reader.get_attribute 6392
    p attrs

  end
  def test_service_kits
    @reader = ServiceKitAttributeReader.new
    attrs = @reader.get_attribute 6392
    p attrs

  end
  def test_interchanges
    @reader = InterchangeAttributeReader.new
    attrs = @reader.get_attribute 6392
    p attrs

  end
  def test_apps
    @reader = ApplicationAttrReader.new
    attrs = @reader.get_attribute 6392
    p attrs

  end

  def test_foreign_interchange
    @reader = ForeignInterchangeReader.new
    response = @reader.get_attribute 36
    assert_equal true, response
    response = @reader.get_attribute 42128
    assert_equal true, response
=begin
    sql_template = ERB.new %q{
             SELECT
                p.id AS sku,
                max(case when p1.manfr_id = 11 then 1 else 0 end) AS has_ti_interchange,
                max(case when p1.manfr_id <> p.manfr_id then 1 else 0 end) AS has_foreign_interchange
            FROM
                part AS p

                LEFT JOIN (interchange_item AS ii1
                INNER JOIN interchange_item AS ii2 ON ii1.interchange_header_id = ii2.interchange_header_id
                AND ii1.part_id <> ii2.part_id
                INNER JOIN part AS p1 ON ii2.part_id = p1.id AND p1.inactive = False) ON p.id = ii1.part_id
            WHERE p.id=<%= id %>
            GROUP BY p.id
        }.gsub(/\s+/, " ").strip
      id = 36
      sql =  sql_template.result(binding)
    p sql
    records_array = ActiveRecord::Base.connection.execute(sql)
     records_array.each do |r|
      p r
    end
=end
  end
end