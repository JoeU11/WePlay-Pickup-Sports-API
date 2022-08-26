class EventsController < ApplicationController
  def index
    @events = Event.all
    render template: "events/index"
  end

  def create # add automatic sign-up for creator
    if current_user
      time = DateTime.new(params[:year], params[:month], params[:day], params[:hour], params[:minute])
      p time
      event = Event.new(sport_id: params[:sport_id], location_id: params[:location_id], time: time, user_id: current_user.id)
      event.save
      event_participant = EventParticipant.new(user_id: current_user.id, event_id: event.id)
      event_participant.save
      render json: event
    else
      render json: {message: "you must be logged in to create an event"} #add error code here
    end
  end
end
