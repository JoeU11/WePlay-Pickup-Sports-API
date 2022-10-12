class AddLatLongToLocations < ActiveRecord::Migration[7.0]
  def change
    add_column :locations, :lat, :decimal, precision: 9, scale: 5
    add_column :locations, :long, :decimal, precision: 9, scale: 5
  end
end
