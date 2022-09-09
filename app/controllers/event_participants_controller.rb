class EventParticipantsController < ApplicationController
  before_action :authenticate_user

  def create
    event_participant = EventParticipant.new(user_id: current_user.id, event_id: params[:event_id])
    event_participant.save
    render json: event_participant
  end

  def index
    event_participants = EventParticipant.where(user_id: current_user.id)
    render json: event_participants.as_json
  end

  def destroy
    event_participant = EventParticipant.find_by(id: params[:id])
    event_participant.destroy
  end
end
