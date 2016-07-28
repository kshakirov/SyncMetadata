require_relative 'test_helper'

part_types = [['Backplate', 7832], ['Bearing Housing', 69],
              ['Bearing Spacer', 6613], ['Bolt Screw', 7838],
              ['Carbon Seal', 7851], ['Clamp', 88], ['Compressor Wheel', 68],
['Fitting', 7839], ['Gasket', 6612], ['Heatshield', 7833], ['Journal Bearing', 6614],
['Journal Bearing Spacer', 7840],['Nozzle Ring', 72], ['Nut',7841], ['Pin', 7842],
['Piston Ring', 6615], ['Retaining Ring',7843 ], ['Seal Plate', 7844], ['Spring', 7845], ['Thrust Bearing', 7846],
['Thrust Collar', 7847], ['Thrust Washer', 7849], ['Turbine Wheel', 67], ['Washer', 7850]]

catalog_getter = MagCatalogGetter.new

part_types.each do |pt|
  catalog_getter.get_visibles_by_part_type pt[0], pt[1]
end