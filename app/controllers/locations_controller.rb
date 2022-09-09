class LocationsController < ApplicationController
  def index
    locations = Location.all
    render json: locations.as_json
  end

  def create
    location = Location.new(name: params[:name], address: params[:address])
    if location.save
      render json: location
    else
      render json: { errors: location.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
