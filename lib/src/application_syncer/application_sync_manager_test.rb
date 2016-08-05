class ApplicationSyncManager
  def test_by_make_year_model make, model,year
    results = []
    CarModelEngineYear.find_each(batch_size: 1000) do |c|
      if c.car_model and c.car_model.car_make and c.car_model.car_make.name == make
        if c.car_model.name == model
          if year == 'not specified' and c.car_year.nil?
            results.push(@app_reader.get_application_attributes c)
          elsif not year== 'not specified' and c.car_year and c.car_year.name == year
            results.push (@app_reader.get_application_attributes c)
            end
        end
      end
    end
    results
  end
end