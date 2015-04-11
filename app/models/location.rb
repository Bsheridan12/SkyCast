class Location < ActiveRecord::Base
	has_many :hourly_forecasts
	has_many :daily_forecasts

	has_many :users_locations
	has_many :users, through: :user_locations
end
