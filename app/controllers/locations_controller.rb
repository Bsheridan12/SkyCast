class LocationsController < ApplicationController
	def create
		@location = Location.new(formatted_address: location_params)
		render :show
	end

	def location_params
		params.require(:location).permit(:formatted_address)
	end
end