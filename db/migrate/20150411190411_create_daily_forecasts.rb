class CreateDailyForecasts < ActiveRecord::Migration
  def change
    create_table :daily_forecasts do |t|
    	t.integer :time
    	t.text 		:summary
    	t.text 		:icon
    	t.integer :sunrise_time
    	t.integer :sunset_time
    	t.float 	:precip_probability
    	t.float		:temperature_min
    	t.integer	:temperature_min_time
    	t.float		:temperature_max
    	t.integer	:temperature_max_time
    	t.float		:humidity
    	t.float		:wind_speed
    	t.float		:visiblity

    	t.references :location

      t.timestamps null: false
    end
  end
end
