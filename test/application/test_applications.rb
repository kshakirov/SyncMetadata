require 'minitest/autorun'
require_relative "../test_helper"

class TestProductsAttrsReader < MiniTest::Unit::TestCase

  def split_strings strings
    strings =  strings.split('||')
    strings.each do |string|
      
    end
  end


  def _test_apps
    @reader = ApplicationAttrReader.new
    attrs = @reader.get_attribute 6392
    example = "Ford!!Various!!not specified!!!!||Ford!!7610!!not specified!!4400!!||Ford!!Various!!not specified!!4.0L Altitude Compensation!!||Ford Tractor!!7610!!not specified!!268!!||Ford!!7600!!not specified!!!!||Navistar!!Tractor!!not specified!!DT239!!||Ford!!Tractor 7600,7700 Force II!!not specified!!256!!||Ford!!7600!!not specified!!4400!!"
    assert_equal example, attrs
  end

  def test_application_test
    syncer = ApplicationSyncManager.new
    res = syncer.test_by_make_year_model('Ford', 'Various', 'not specified')
    p res
  end


  def test_application_bvw
    syncer = ApplicationSyncManager.new
    res = syncer.test_by_make_year_model('BMW', "325 TDs", '1993')
    p res
  end

end

