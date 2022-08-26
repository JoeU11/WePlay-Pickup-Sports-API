class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.integer :sport_id
      t.integer :location_id
      t.datetime :time
      t.integer :user_id

      t.timestamps
    end
  end
end
