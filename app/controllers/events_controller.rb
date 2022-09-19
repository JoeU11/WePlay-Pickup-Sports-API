class EventsController < ApplicationController
  # adding comment so that I can push to github
  def index
    if params[:myEvents]
      @events = current_user.events.where('time > ?', DateTime.now).order(:time)
      @current_user = current_user
    else
      @events = Event.all.where('time > ?', DateTime.now).order(:time)
      @current_user = current_user
    end
    render template: "events/index"
  end

  def show
    @event = Event.find_by(id: params[:id])
    @current_user = current_user
    render template: "events/show"
  end

  def create # add automatic sign-up for creator
    if current_user
      if !params[:time]
        render json: {errors: ["you must select a time"]}, status: :bad_request
      
      else
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
      end

    else
      render json: { errors: ["you must be logged in to create an event"]}, status: :unauthorized 
    end
  end

  def update
    if current_user 
      if !params[:time]
        render json: {errors: ["you must select a time"]}, status: :bad_request
      elsif current_user.id == event.user.id
        event = Event.find_by(id: params[:id])
        date = params[:time]
        date = date.chop
        date = date.tr('-T:.', ',')
        date = date.split(",")
        time = DateTime.new(date[0].to_i, date[1].to_i, date[2].to_i, date[3].to_i, date[4].to_i, date[5].to_i, date[6].to_i)

        event.sport_id = params[:sport_id] || event.sport_id  
        event.location_id = params[:location_id] || event.location_id  
        event.time = time || event.time  

        render json: event.as_json
      else
        render json: { errors: ["you may only modify your own events"]}, status: :unauthorized   
      end
    else # may not be needed depending on frontend
      render json: { errors: ["you must be logged in to update an event"]}, status: :unauthorized 
    end
  end

  def destroy
    event = Event.find_by(id: params[:id])
    if current_user && current_user.id == event.user.id
      event.destroy
      render json: {message: "Event has been removed"}
    else
      render json: { errors: ["you may only remove your own events"]}, status: :unauthorized   
    end
  end
end
