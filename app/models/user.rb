class User < ActiveRecord::Base
	has_many :user_locations
	has_many :locations
end
