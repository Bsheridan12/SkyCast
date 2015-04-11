class CreateHourlyForecasts < ActiveRecord::Migration
  def change
    create_table :hourly_forecasts do |t|
    	t.integer :time
    	t.text 		:summary
    	t.text 		:icon
    	t.float 	:precip_probability
    	t.float		:temperature
    	t.float		:humidity
    	t.float		:wind_speed
    	t.float		:visiblity

    	t.references :location

      t.timestamps null: false
    end
  end
end
