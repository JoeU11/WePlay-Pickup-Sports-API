class AddEstimatedParticipantsToEvents < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :estimated_participants, :integer
  end
end
