require_relative "app_helper"
require_relative "app_lib"

puts  'Starting process of generating json file with all notes'
parts = Part.all
json_notes = []
parts.each do |part|
  if part.salesnotepart.all and part.salesnotepart.all.size > 0
    json_note = {}
    json_note[:sku] = part.id
    json_note[:sales_notes] = []
    sales_parts= part.salesnotepart.all
    sales_parts.each do |sales_part|
      notes = sales_part.salesnote.all
      notes.each do |note|
        if note.state == 'published'
          p note
          sales_note = {:write_date => note.write_date, :comment => note.comment}
          p sales_note
          json_note[:sales_notes].push sales_note
        end
      end
    end
  json_notes.push json_note
  end
end

p json_notes

json_file = File.new("sales_notes.json","w")
json_file.write json_notes.to_json


