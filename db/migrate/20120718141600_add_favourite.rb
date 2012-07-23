class AddFavourite < ActiveRecord::Migration
  def up
    create_table :favourites do |t|
      t.references :users, :restaurants
    end
  end

  def down
  end
end
