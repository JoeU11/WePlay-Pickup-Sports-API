class Event < ApplicationRecord
  #add validation event time must be in the future
  belongs_to :sport
  belongs_to :location
  belongs_to :user 
  has_many :event_participants
  has_many :users, through: :event_participants

  def readable_time
    # return   time.strftime("%b %e, %l:%M %p")
    return   time.strftime("%b %e, %Y %l:%M %p %Z")
  end

  def get_event_participant(current_user)
    if current_user
      return event_participants.find_by(user_id: current_user.id)
    else
      return nil
    end
  end

  def end_time
    # returns datetime object one hour after start time
    event_end_time = time + 3600
    return event_end_time
  end
end
