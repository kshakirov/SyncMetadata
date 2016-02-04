require 'active_record'
require 'mysql2'
require 'logger'
require 'yaml'
require 'composite_primary_keys'

configuration = YAML::load(IO.read('../config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])