class AddLongitudeAndLatitude < ActiveRecord::Migration

  def change
    add_column :offers, :latitude, :decimal, precision: 15, scale: 10, default: 0.0
    add_column :offers, :longitude, :decimal, precision: 15, scale: 10, default: 0.0
  end

end