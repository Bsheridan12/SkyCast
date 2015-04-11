class User < ActiveRecord::Base
	has_many :user_locations
	has_many :locations, through: :user_locations

	has_many :hourly_forecasts, through: :locations
	has_many :daily_forecasts, through: :locations
end
