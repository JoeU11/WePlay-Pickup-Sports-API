class LocationsController < ApplicationController
  def index
    locations = Location.all
    render json: locations.as_json
  end
end
