require 'minitest/autorun'
require_relative 'test_helper'

class TestVisibility < Minitest::Unit::TestCase

  def setup
    @printer = DiffPrinter.new
  end




  def _test_scheleton part_type
    @diff_tool = VisibilityDiffTool.new
    meta, mag = @diff_tool.compare_size part_type
    @printer.print_size meta, mag, part_type
    metas, mags = @diff_tool.get_not_matched_skus part_type
    @printer.print_diff_ids metas, mags
  end

  def test_all
    _test_scheleton 'Bearing Housing'
    _test_scheleton 'Backplate'
    _test_scheleton 'Bearing Spacer'
    _test_scheleton 'Bolt Screw'
    _test_scheleton 'Carbon Seal'
    _test_scheleton 'Clamp'
    _test_scheleton 'Compressor Wheel'
    _test_scheleton 'Fitting'
    _test_scheleton 'Gasket'
    _test_scheleton 'Heatshield'
    _test_scheleton 'Journal Bearing'
    _test_scheleton 'Journal Bearing Spacer'
    _test_scheleton 'Nozzle Ring'
    _test_scheleton 'Nut'
    _test_scheleton 'Pin'
    _test_scheleton 'Piston Ring'
    _test_scheleton 'Retaining Ring'
    _test_scheleton 'Seal Plate'
    _test_scheleton 'Thrust Bearing'
    _test_scheleton 'Thrust Collar'
    _test_scheleton 'Thrust Washer'
    _test_scheleton 'Turbine Wheel'
    _test_scheleton 'Washer'

  end

  def test_1
    _test_scheleton 'Bolt Screw'
  end


end