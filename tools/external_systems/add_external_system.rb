require_relative '../../app_helper'
require_relative '../tools_helper'
require_relative '../../lib/sync'

if ARGV.size < 2
  puts "Needed: 1st argument IP  2d : Description "
  exit (1)
else
  sys = ExternalSystem.new
  sys.url = ARGV[0]
  sys.description = ARGV[1]
  sys.save

end




