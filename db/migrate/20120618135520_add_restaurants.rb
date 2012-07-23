class AddRestaurants < ActiveRecord::Migration
  def up
    create_table :restaurants do |t|
      t.string :name
      t.string :restaurant_type
      t.string :speciality
      t.string :picture
      t.text :description
      t.decimal :budget_min
      t.decimal :budget_max
      # t.string :address
      t.integer :time_to_go
      # t.decimal :latitude
      # t.decimal :longitude
    end
  end

  def down
  end
end
