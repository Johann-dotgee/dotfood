class AddUsersGroups < ActiveRecord::Migration
  def up
    create_table :users_groups do |t|
      t.references :restaurant, :group
    end
  end

  def down
  end
end
