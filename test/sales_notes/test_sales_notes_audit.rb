require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"

class TestSalesNotes < Minitest::Unit::TestCase

  def test_all
    audits = SalesNotesAudit.all
    assert_instance_of SalesNotesAudit::ActiveRecord::Relation, audits

  end

  def test_insert
    audit = SalesNotesAudit.new
    audit.action = "insert"
    audit.sales_note_id = 200
    audit.save
    @note_id = audit.id
    p @note_id

  end

  def test_delete
    audit = SalesNotesAudit.find @note_id
    audit.delete

  end

  def test_update_lookup
    syncer = SalesNotesSyncer.new
    result = syncer.sync_by_last_note_id 0
    p result
  end

  def test_sync_all
    syncer = SalesNotesSyncer.new
    p syncer.sync_all
  end
end
