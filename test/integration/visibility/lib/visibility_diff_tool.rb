class VisibilityDiffTool
  def initialize
    @metadata = YAML::load_file('var/metadata_visible.yml')
    @mag_client = MagCatalogGetter.new
  end

  def get_meta_part part_type
    @metadata[part_type]
  end

  def get_mag_skus part_type
    @mag = YAML::load_file("var/catalog_#{part_type.gsub(' ', '')}_visible.yml")
  end


  def compare_size part_type
    return get_meta_part(part_type),get_mag_skus(part_type)

  end

  def _find_missed_visible_skus mag, meta
    missed_meta_skus = []
    mag.each do |mag_sku|
      found = false
      meta.each do |meta_sku|
        if mag_sku[0] == meta_sku.to_s
          found= true
          break
        end
      end
      unless found
        missed_meta_skus.push mag_sku
        found = false
      end

    end
    missed_meta_skus
  end

  def _find_meta_missed_part_numbers skus
    names = []
    not_found = []
    skus.each do |sku|
      begin
      part = Part.find sku[0]
      names.push part.manfr_part_num
      rescue ActiveRecord::RecordNotFound => e
        not_found.push sku[0]
      end

    end
    return names, not_found
  end

  def _find_mag_missed_part_numbers skus
    results = []
    skus.each do |sku|
      results.push(@mag_client.get_by_sku(sku[0]))
    end
    results
  end

  def compare_by_part_skus part_type
    meta = get_meta_part part_type
    mag = get_mag_skus part_type
    missed_meta_skus = _find_missed_visible_skus(mag, meta)
    return  _find_meta_missed_part_numbers(missed_meta_skus),  _find_mag_missed_part_numbers(missed_meta_skus)

  end

end