class ChangeUsersLatLongToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :lat, :decimal, precision: 9, scale: 5
    change_column :users, :long, :decimal, precision: 9, scale: 5
  end
end
