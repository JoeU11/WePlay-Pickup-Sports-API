class Event < ApplicationRecord
  #add validation event time must be in the future
  belongs_to :sport
  belongs_to :location
  belongs_to :user # this appears to work with has_many users, through. keeping note in case it breaks in future tests
  has_many :event_participants
  has_many :users, through: :event_participants

  def readable_time
    return   time.strftime("%b %e, %l:%M %p")
  end

  def get_event_participant(current_user)
    if current_user
      return event_participants.find_by(user_id: current_user.id)
    else
      return nil
    end
  end
end
