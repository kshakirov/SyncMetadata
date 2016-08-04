class ApplicationReader
  def get_application_attributes car_model_eng_year
    app = car_model_eng_year
    attrs = {}


    attrs['make'] = app.car_model.car_make.name if app.car_model and app.car_model.car_make
    attrs['model'] = app.car_model.name if app.car_model
    attrs['year'] = app.car_year ? app.car_year.name : 'not specified'
    attrs['engineSize'] = app.car_engine.engine_size if app.car_engine
    attrs['fuelType'] = app.car_engine.car_fuel_type.name if app.car_engine and app.car_engine.car_fuel_type
    attrs['string'] = attrs['make'].to_s + '!!' + attrs['model'].to_s + '!!' + attrs['year'].to_s + '!!' +
    attrs['engineSize'].to_s + '!!' + attrs['fuelType'].to_s
    attrs
  end
end

class ApplicationSyncManager

  def initialize
    @app_reader = ApplicationReader.new
    @yaml_file = File.open(__dir__ + '/../../../public/all_applications.yml', 'w')
  end

  def update_all_applications
    CarModelEngineYear.find_each(batch_size: 100) do |c|
      attrs = @app_reader.get_application_attributes c
      YAML.dump attrs, @yaml_file
    end
    @yaml_file.close
  end
end