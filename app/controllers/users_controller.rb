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
      # Create and Save Availability here - Hardcoded below. Replace with params from frontend
      preferred_times = [{day: "monday", time_slots: ["morning", "afternoon"]}, {day: "sunday", time_slots: ["morning", "evening"]}, {day: "wednesday", time_slots: ["morning"]}]


      preferred_times.each do |time|
        time[:time_slots].each { |time_slot| 
          availability = Availability.new(user_id: user.id, day: time[:day], time_slot: time_slot);availability.save }
      end
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end
end
