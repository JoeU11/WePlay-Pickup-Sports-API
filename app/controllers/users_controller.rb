class UsersController < ApplicationController
  def create
    user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      location: params[:location]
    )
    if user.save
      if params[:location]
        results = Geocoder.search(params[:location])
        if results.length > 0
          coords = results.first.coordinates
          user.lat = coords[0]
          user.long = coords[1]
          user.save
        end
      end
      preferred_times = params[:preferredTimes]
      preferred_times.each do |time| 
        availability = Availability.new(user_id: user.id, day: time[:day], time_slot: time[:time_slot]);availability.save 
      end
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
end
