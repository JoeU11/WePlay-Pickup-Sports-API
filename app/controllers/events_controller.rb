class EventsController < ApplicationController
  def index
    @events = Event.all
    render template: "events/index"
  end

  def create # add automatic sign-up for creator
    if current_user && params[:time] == ""
      render json: {errors: ["you must select a time"]}, status: :bad_request
    elsif current_user
      date = params[:time]
      date = date.chop
      date = date.tr('-T:.', ',')
      date = date.split(",")
      time = DateTime.new(date[0].to_i, date[1].to_i, date[2].to_i, date[3].to_i, date[4].to_i, date[5].to_i, date[6].to_i)

      p time
      event = Event.new(sport_id: params[:sport_id], location_id: params[:location_id], time: time, user_id: current_user.id)
      
      if event.save
        event_participant = EventParticipant.new(user_id: current_user.id, event_id: event.id)
        event_participant.save
        render json: event
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
      event.save
      
      
    else
      render json: { errors: ["you must be logged in to create an event"]}, status: :unauthorized 
    end
  end
end
