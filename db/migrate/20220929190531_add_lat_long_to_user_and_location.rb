class AddLatLongToUserAndLocation < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :lat, :integer
    add_column :users, :long, :integer

    add_column :locations, :lat, :integer
    add_column :locations, :long, :integer
  end
end
