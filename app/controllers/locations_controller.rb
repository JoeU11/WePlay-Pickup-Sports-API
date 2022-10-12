class LocationsController < ApplicationController
  def index
    locations = Location.all
    render json: locations.as_json
  end

  def create
    location = Location.new(name: params[:name], address: params[:address])
    if location.save
      if params[:address]
        results = Geocoder.search(params[:address])
        if results.length > 0
          coords = results.first.coordinates
          location.lat = coords[0]
          location.long = coords[1]
          location.save
        end
      end
      render json: location
    else
      render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
