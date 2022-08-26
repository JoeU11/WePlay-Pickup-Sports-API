class EventParticipant < ApplicationRecord
  validates :user, uniqueness: {scope: :event_id} # prevents user from signing up to same event twice

  belongs_to :user
  belongs_to :event
end
