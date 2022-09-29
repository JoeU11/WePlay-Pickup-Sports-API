class CreateAvailabilities < ActiveRecord::Migration[7.0]
  def change
    create_table :availabilities do |t|
      t.integer :user_id
      t.string :day
      t.string :time_slot

      t.timestamps
    end
  end
end
