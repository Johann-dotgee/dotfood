class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :budget
      t.integer :quality
      t.integer :quantity
      t.integer :time_to_go
      t.boolean :lundi
      t.boolean :mardi
      t.boolean :mercredi
      t.boolean :jeudi
      t.boolean :vendredi

      t.timestamps
    end
  end
end
