configuration = YAML::load(IO.read('../config/database.yml'))
ActiveRecord::Base.establish_connection(configuration['development'])