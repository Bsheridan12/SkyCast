class HourlyForecastController < ApplicationController


	def index
  	@hourly = HourlyForecast.where(location: @location).where("time >= ?", Time.now.to_i)

  	if @hourly.count <= 24
  		@hourly.each do |hour|
  			hour.destroy
  		end

	  	@hourly = @forecast.hourly.data.each do |hour|
	  		HourlyForecast.create(time: hour.time, summary: hour.summary, icon: hour.icon, precip_probability: hour.precipProbability, temperature: hour.temperature, humidity: hour.humidity, wind_speed: hour.windSpeed, visibility: hour.visibility, location: @location)
	  	end
  	end
  end

end