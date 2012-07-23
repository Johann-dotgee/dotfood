class AddUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      # t.string :email
      # t.string :login
      t.string :password
      t.boolean :activated
      t.string :validation_token
    end
  end

  def down
  end
end
