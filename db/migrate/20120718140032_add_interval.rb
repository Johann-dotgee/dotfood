class AddInterval < ActiveRecord::Migration
  def up
    create_table :intervals do |t|
      t.string :day
      t.string :interval_type
      t.boolean :closed
      t.time :from
      t.time :to
      t.integer :restaurant_id
    end
  end

  def down
  end
end
