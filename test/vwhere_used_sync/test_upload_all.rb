require_relative '../test_helper'
class TestUploadAll < Minitest::Unit::TestCase
  def test_all
    # vwhere_used = VWhereUsedUploadAll.new
    # vws = vwhere_used.run
    # assert_equal 42173,vws[0][:principal_id]
  end

  def test_manager
    manager = VWhereUsedSyncManager.new
    manager.run_all
  end


end