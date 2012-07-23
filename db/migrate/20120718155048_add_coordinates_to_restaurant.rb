class AddCoordinatesToRestaurant < ActiveRecord::Migration
  def change
    add_column :restaurants, :address, :string
    add_column :restaurants, :longitude, :float
    add_column :restaurants, :latitude, :float
  end
end
