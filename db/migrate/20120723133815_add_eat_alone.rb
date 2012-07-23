class AddEatAlone < ActiveRecord::Migration
  def up
    create_table :eat_alones do |t|
      t.boolean :eat_alone, :null => false, :default => true
      t.integer :user_id
      t.date :created_at
      t.date :updated_at
    end
  end

  def down
    drop_table :eat_alones
  end
end
