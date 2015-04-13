class WelcomeController < ApplicationController
  def index
  	ForecastIO.api_key = "b5600c8d9df775b6c3bbdd0f449b53b3"

  	@location = Location.new
  end

  def create
  	ForecastIO.api_key = "b5600c8d9df775b6c3bbdd0f449b53b3"

  	@location = Location.where({zip: params[:zip]}).first

  	if @location
  		@forecast = ForecastIO.forecast(@location.latitude, @location.longitude)
  	else
  		@location = Location.create(latitude: params[:latitude], longitude: params[:longitude], formatted_address: params[:formatted_address], city: params[:city], state: params[:state], zip: params[:zip], country: params[:country])
  		@forecast = ForecastIO.forecast(@location.latitude, @location.longitude)
  	end

  	@daily = DailyForecast.where(location: @location).where("time >= ?", 1.day.ago.to_i ).order(:time).limit(4)

  	if @daily.count < 4 
	  	@daily.each do |day|
	  		day.destroy
	  	end

	  	@forecast.daily.data.each do |day|
	  		DailyForecast.create(time: day.time, summary: day.summary, icon: day.icon, sunrise_time: day.sunriseTime, sunset_time: day.sunsetTime, precip_probability: day.precipProbability, temperature_min: day.temperatureMin,temperature_min_time: day.temperatureMinTime, temperature_max: day.temperatureMax,temperature_max_time: day.temperatureMaxTime,humidity: day.humidity, wind_speed: day.windSpeed, visibility: day.visibility, location: @location)
	  	end

	  	@daily = DailyForecast.where(location: @location).where("time >= ?", 1.day.ago.to_i ).order(:time).limit(4)
	  end

	  @currently = @forecast.currently.temperature

  	render partial: "forecast", locals: {forecast: @forecast }, layout: false
  end
end