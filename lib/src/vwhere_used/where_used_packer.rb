class VWhereUsedPacker
  def pack records
    File.open('vwhere_used.json', 'w'){|f|
      f.write(records.to_json)
    }
  end
end