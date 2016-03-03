require_relative '../app_helper'
require_relative 'tools_helper'
require_relative '../lib/sync'

if ARGV.size < 2
  puts "Needed: 1st argument Entity (i.e. image, note) 2d : Number "
  exit (1)
end



entity = ARGV[0]

system = ExternalSystem.first

if entity=='image'
  system.images_last  = ARGV[1]
elsif entity=='note'
  system.sales_notes_last = ARGV[1]

end

system.save

