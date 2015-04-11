class User < ActiveRecord::Base
	has_many :user_locations
	has_many :locations, through: :user_locations

	has_many :hourly_forecasts, through: :locations
	has_many :daily_forecasts, through: :locations

	validates :password, :length => { :minimum => 5 }
	validates :email, :uniqueness => true, :format => /.+@.+\..+/

	def password
	    @password ||= BCrypt::Password.new(password_hash)
	end

	def password=(new_password)
	    @password = BCrypt::Password.create(new_password)
	    self.password_hash = @password
	end

	def self.authenticate(email, password)
	 user = User.find_by_email(email)
	  return user if user && (user.password == password)
	end
end
