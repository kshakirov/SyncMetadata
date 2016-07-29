require_relative '../../../test/test_helper'


sku = 45068
response = RestClient.get('localhost/critical/index/regression',
                          {:params => {:sku => 45068}})

part = Part.find sku



def prepare_crit_dim_hash
  hash = {}
  CritDim.all.each do |c|
    hash[c['json_name']] = c['name']
  end
  hash
end

hash = prepare_crit_dim_hash

def get_crit_dim_class part
  name = part.part_type.magento_attribute_set
  value = part.part_type.value
  klazz= nil
  unless name.downcase == 'part'
    name = name.gsub(" ", '')
    klazz = Class.new(ActiveRecord::Base)
    klass = Object.const_set name, klazz
    klass.table_name = value
    klass.primary_key = 'part_id'
  end
  klazz
end

klazz = get_crit_dim_class part
part = klazz.send 'find', sku
converted_part = {}
part.attributes.each do |a|
  if hash.key? a[0]
    #puts hash[a[0]] + ' = ' + a[1].to_s
    converted_part[hash[a[0]]] = a[1]
  end
end

response = JSON.parse(response.body)


response['critical'].each do |c|
  label = c["label"].gsub(/\s{2,}/, " ")
  if converted_part.key? label
    puts c["label"] + " "  + c['value'].to_s + " : " + converted_part[label].to_f.to_s
  elsif converted_part.key? c["label"]
    puts c["label"] + " "  + c['value'].to_s + " : " + converted_part[c["label"]].to_f.to_s
  else
    puts "------------- NO Label " +  label  + " but "    + c["label"] + " " + c['value'].to_s
  end
end

p ""