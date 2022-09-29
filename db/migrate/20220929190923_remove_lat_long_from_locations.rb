class RemoveLatLongFromLocations < ActiveRecord::Migration[7.0]
  def change
    remove_column :locations, :lat
    remove_column :locations, :long
  end
end
