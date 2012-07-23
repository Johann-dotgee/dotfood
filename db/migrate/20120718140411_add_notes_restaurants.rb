class AddNotesRestaurants < ActiveRecord::Migration
  def up
    create_table :ratings do |t|
      t.decimal :quality_food
      t.decimal :quality_service
      t.decimal :ambience
      t.decimal :quantity
      t.decimal :waiting
      t.references :user, :restaurant
    end
  end

  def down
  end
end
