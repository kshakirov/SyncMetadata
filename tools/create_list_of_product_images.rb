require_relative '../app_helper'
require_relative 'tools_helper'
require_relative '../lib/sync'

products = ProductImage.all

images = []
products.each do |product|
  filename =  "#{product.part_id}_#{product.id}.jpg"
  puts filename
  images.push filename
end
File.open('images.json','w'){|f|
  f.write images.to_json
}