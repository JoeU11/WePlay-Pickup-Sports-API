class EventsController < ApplicationController
  def index
  end

  def create
    if current_user
      time = DateTime.new(params[:year], params[:month], params[:day], params[:hour], params[:minute])
      p time
      event = Event.new(sport_id: params[:sport_id], location_id: params[:location_id], time: time, user_id: current_user.id)
      event.save
      render json: event
    else
      render json: {message: "you must be logged in to create an event"} #add error code here
    end
  end
end
