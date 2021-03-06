require 'minitest/autorun'
require_relative "test_helper"
require_relative "../lib/sync"


class TestExternalSystems < MiniTest::Unit::TestCase
  def test_all
    systems = ExternalSystem.all
    assert_instance_of ExternalSystem::ActiveRecord_Relation, systems
    assert_equal systems[0].id, 1

  end

  def test_create
    system = ExternalSystem.new
    system.url = "metadata.turbointernational.com"
    system.description = "production"
    system.save

  end
end