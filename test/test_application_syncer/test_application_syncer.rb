require 'minitest/autorun'
require_relative "../test_helper"
class TestApplicationSync < MiniTest::Unit::TestCase
  def test_first
    first = CarModelEngineYear.first
    refute_nil first
    p first.car_year
    p first.car_model.name
    p first.car_model.car_make
    p first.car_engine.car_fuel_type

  end
  def test_update_all
    a_manager = ApplicationSyncManager.new
    a_manager.update_all_applications
  end
end