class CreateSondages < ActiveRecord::Migration
  def up
    create_table :sondages do |t|
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      t.datetime :reminder_at

      t.references :event, :restaurant
      
      t.timestamps
    end
  end

  def down
    drop_table :sondages
  end
end
