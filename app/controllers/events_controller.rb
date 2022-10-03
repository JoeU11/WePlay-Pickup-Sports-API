require 'json'

class EventsController < ApplicationController
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
          day = event.time.strftime("%A")

          event_coords = Geocoder.search(event.location.address).first.coordinates
          # find all users that have Availability during event time

          #TODO add and filter by preferred sport(s)
          available_users = Availability.all.where(day: day, time_slot: params[:time_slot])
          possible_participants = []
          available_users.each do |user|
            possible_participants << user.user
          end

          # find count of above users within 30 miles of event_coords
          estimated_participants = 0
          possible_participants.each do |participant|
            if participant.location
              participant_coords = Geocoder.search(participant.location).first.coordinates # replace with user.lat and user.long to minimize API calls
              distance = Geocoder::Calculations.distance_between(event_coords, participant_coords)
              if distance < 30
                estimated_participants += 1
              end
            end
          end
          # save count to estimated_participants column of event

          # TODO add participation weight factor - unlikely every available participant will show up
          event.estimated_participants = estimated_participants
          event.save
          
          # end testing
          
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
      event = Event.find_by(id: params[:id])
      if !params[:time]
        render json: {errors: ["you must select a time"]}, status: :bad_request
      elsif current_user.id == event.user.id
        if params[:time] == params[:start]
          date = params[:time]
          date = date.chop
          date = date.tr('-T:.', ',')
          date = date.split(",")
          time = DateTime.new(date[0].to_i, date[1].to_i, date[2].to_i, date[3].to_i, date[4].to_i, date[5].to_i, date[6].to_i)
        end

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
