require_relative 'test_helper'
puts 'Dumping metadat visible items  once'
getter = VisiblePartGetter.new
getter.dump_metadata_catalog