class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :event_participants
  has_many :events, through: :event_participants #shows events participating in. for events created by user, use longhand method
end
