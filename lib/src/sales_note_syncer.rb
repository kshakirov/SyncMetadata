class SalesNotesSyncer
  def initialize

  end

  def sync_all_parts
    puts 'Starting process of generating json file with all notes'
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
  end

  def sync_all

    notes = Salesnote.where("state = ?", "published")
    result = []
    notes.each do |note|

      parts = Salesnotepart.where(sales_note_id: note.id)
      if parts.size > 0
        parts.each do |part|
          current_note = {}
          current_note['comment'] = note.comment
          current_note['sku'] = part.part_id.to_s
          current_note['write_date'] = part.write_date.to_s
          current_note['audit_id'] = 0
          current_note['action'] = 'insert'
          result.push current_note


        end
      end

    end
    if result.size > 0
      result
    else
      false
    end
  end

  def sync_by_last_note_id last_id
    notes_ids = SalesNotesAudit.where("id > ?", last_id)
    result = []
    notes_ids.each do |id|
      note = Salesnote.find id.sales_note_id
      salesparts = Salesnotepart.where(sales_note_id: note.id)

      if salesparts.size > 0
        salesparts.each do |part|
          if note.state == 'published' and  id.old_state !="published" and id.state == 'published'
            current_note = {}
            current_note['comment'] = note.comment
            current_note['sku'] = part.part_id.to_s
            current_note['write_date'] = part.write_date.to_s
            current_note['metadata_note_id'] = note.id
            current_note['action'] = 'insert'
            result.push current_note
          elsif id.old_state== "published"  and id.state == 'published'
            current_note = {}
            current_note['comment'] = note.comment
            current_note['sku'] = part.part_id.to_s
            current_note['write_date'] = part.write_date.to_s
            current_note['metadata_note_id'] = note.id
            current_note['action'] = 'update'
            result.push current_note

          elsif id.old_state== "published" and id.state !="published"
            current_note = {}
            current_note['sku'] = part.part_id.to_s
            current_note['metadata_note_id'] = note.id
            current_note['action'] = 'delete'
            result.push current_note
          end

        end
      end

    end
    result if result.size >0
  end

end



