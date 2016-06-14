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
    result = attrs.select {|attr| attr[:sku] == 46622}
    assert_equal 2, result[0][:ti_part_sku].size
    assert_equal 1, result[0][:distance]
    assert_equal 'Interchange', result[0][:type]
    assert_equal false, result[0][:has_bom]

  end
  def test_service_kits
    @reader = ServiceKitAttributeReader.new
    attrs = @reader.get_attribute 6392
    assert_equal 29, attrs.size
    result = attrs.select {|attr| attr[:sku] == 40272}
    assert_equal 1, result.size
    assert_equal "200115-0000", result[0][:partNumber]

  end
  def test_interchanges
    @reader = InterchangeAttributeReader.new
    attrs = @reader.get_attribute 6392
    assert_equal "53,1983", attrs


  end
  def test_apps
    @reader = ApplicationAttrReader.new
    attrs = @reader.get_attribute 6392
    example = "Ford!!Various!!not specified!!6392!!||Ford!!7610!!not specified!!6392!!||Ford Tractor!!7610!!not specified!!6392!!||Ford!!7600!!not specified!!6392!!"
    assert_equal example, attrs
  end

  def test_foreign_interchange
    @reader = ForeignInterchangeReader.new
    response = @reader.get_attribute 36
    assert_equal true, response
    response = @reader.get_attribute 42128
    assert_equal true, response

  end

  def test_is_crit_dim_part_type
    part_type_analyzer = PartTypeAnalyzer.new
    assert_equal false, part_type_analyzer.is_crit_dim_part_type(2)
    assert_equal true, part_type_analyzer.is_crit_dim_part_type(6)
  end




  def test_turbo_model_other
    id = 42128
    @reader = TurboModelAttributeReader.new
    models, types = @reader.get_attribute id
    assert_equal 27, models.size
    assert_equal 1, models.select{|m | m =='RHB52W-52002P15NRBRL3911EZ'}.size
    assert_equal "RHB5",  types[0]

    models, types = @reader.get_attribute 25179
    assert_equal 1, models.select{|m | m =='K27-3262MGB/20.22'}.size
    assert_equal 'K27', types[0]

    id = 42212
    assert_equal 1, models.select{|m | m =='GT1752'}.size

  end



end