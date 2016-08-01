require 'minitest/autorun'
require_relative 'test_helper'

class TestVisibility < Minitest::Unit::TestCase

  @@printer = DiffPrinter.new

  def _test_scheleton part_type
    @diff_tool = VisibilityDiffTool.new
    meta, mag = @diff_tool.compare_size part_type
    @@printer.print_size meta, mag, part_type
    metas, mags = @diff_tool.compare_by_part_skus part_type
    @@printer.print_diff_ids metas, mags
    mags
  end

  def test_all
     _test_scheleton 'Bearing Spacer'
    #
    # _test_scheleton 'Clamp'
     _test_scheleton 'Compressor Wheel'
     _test_scheleton 'Fitting'
     _test_scheleton 'Gasket'
    # _test_scheleton 'Heatshield'
    #
     _test_scheleton 'Nozzle Ring'
     _test_scheleton 'Nut'
     _test_scheleton 'Pin'
     _test_scheleton 'Piston Ring'
     _test_scheleton 'Retaining Ring'
     _test_scheleton 'Seal Plate'
     _test_scheleton 'Thrust Bearing'
     _test_scheleton 'Thrust Collar'
     _test_scheleton 'Thrust Washer'
     _test_scheleton 'Washer'

  end

  def test_bearing_housing
    mags =_test_scheleton 'Bearing Housing'
    assert_equal 4, mags.size
  end

  def test_backplate
    mags = _test_scheleton 'Backplate'
    assert_equal 0, mags.size
  end

  def test_bolt_screw
    mags = _test_scheleton 'Bolt Screw'
    assert_equal 0, mags.size
  end

  def test_turbine_wheel
    mags =_test_scheleton 'Turbine Wheel'
    assert_equal 3, mags.size
  end

  def test_carbon_seal
    mags =_test_scheleton 'Carbon Seal'
    assert_equal 0, mags.size
  end

  def test_journal_bearing
    mags =_test_scheleton 'Journal Bearing'
    assert_equal 1, mags.size
  end

  def test_journal_bearing_spacer
    mags =_test_scheleton 'Journal Bearing Spacer'
    assert_equal 0, mags.size
  end

   def test_cartridge
     mags =_test_scheleton 'Cartridge'
     assert_equal 0, mags.size
   end


end
