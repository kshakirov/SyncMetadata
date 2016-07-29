require 'elasticsearch'
class MagCatalogGetter
  def initialize
    @client = Elasticsearch::Client.new host: 'storestaging.turbointernational.com', port: 29418,  log: true
  end

  def get_visible_skus results
    skus = []
    results['hits']['hits'].each do |hit|
      skus.push hit['fields']['sku']
    end
    skus
  end

  def save_skus skus, part_type
    File.open("var/catalog_#{part_type.gsub(' ','')}_visible.yml", 'w') {|f| f.write skus.to_yaml }
  end

  def get_visibles_by_part_type part_type, part_type_id
   @client.cluster.health
   results = @client.search index: 'magento_product', body: { query:{ bool: {must: [ {  match:  { part_type: part_type_id.to_s }}, {  match:  { visible_in_catalog: true }}]   }}}, fields: ['sku'], size: 10000
   skus = get_visible_skus  results
   save_skus skus, part_type
  end

  def get_by_sku sku
    result = {}
    item = @client.search index: 'magento_product', body: { query: {  match:  { sku: sku }}  }, fields: ['ti_part.ti_part_number', 'oe_ref_urls.part_number'], size: 10000
    response =  item['hits']['hits'][0]['fields']
    if response.key? 'ti_part.ti_part_number'
      result['ti'] = response['ti_part.ti_part_number'][0]
    else
      result['ti'] = nil

    end
    if response.key? 'oe_ref_urls.part_number'
      result['oe'] = response['oe_ref_urls.part_number'][0]
    else
      result['oe'] = nil

    end

    result

  end

end