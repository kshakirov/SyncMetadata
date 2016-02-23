require 'active_record'
require 'mysql2'
require 'logger'
require 'yaml'
require 'composite_primary_keys'
require 'minitest'
require 'minitest/autorun'

configuration = YAML::load(IO.read('../config/development/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])