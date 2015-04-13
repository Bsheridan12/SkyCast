class WelcomeController < ApplicationController
  def index
  	ForecastIO.api_key = "b5600c8d9df775b6c3bbdd0f449b53b3"
  end

  def create
  	ForecastIO.api_key = "b5600c8d9df775b6c3bbdd0f449b53b3"

  	@location = Location.create(latitude: params[:latitude], longitude: params[:longitude], formatted_address: params[:formatted_address])

  	@forecast = ForecastIO.forecast(@location.latitude, @location.longitude)


  	# need to only create these objects if they have not already been created for that location. Also need to only create the location once.
  	@forecast.hourly.data.each do |hour|
  		HourlyForecast.create(time: hour.time, summary: hour.summary, icon: hour.icon, precip_probability: hour.precipProbability, temperature: hour.temperature, humidity: hour.humidity, wind_speed: hour.windSpeed, visibility: hour.visibility, location: @location)
  	end

  	@forecast.daily.data.each do |day|
  		DailyForecast.create(time: day.time, summary: day.summary, icon: day.icon, sunrise_time: day.sunriseTime, sunset_time: day.sunsetTime, precip_probability: day.precipProbability, temperature_min: day.temperatureMin,temperature_min_time: day.temperatureMinTime, temperature_max: day.temperatureMax,temperature_max_time: day.temperatureMaxTime,humidity: day.humidity, wind_speed: day.windSpeed, visibility: day.visibility, location: @location)
  	end

  	@daily = DailyForecast.where(location: @location)
  	@hourly = HourlyForecast.where(location: @location)

  	render partial: "test", locals: {forecast: @forecast }, layout: false
  end
end