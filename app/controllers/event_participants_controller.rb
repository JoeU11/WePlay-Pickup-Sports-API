class EventParticipantsController < ApplicationController
  before_action :authenticate_user

  def create
    event_participant = EventParticipant.new(user_id: current_user.id, event_id: params[:event_id])
    event_participant.save
    render json: {message: "You have successfully joined this event"}
  end
end
