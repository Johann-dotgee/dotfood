class AddUsersGroups < ActiveRecord::Migration
  def up
    create_table :users_groups do |t|
      t.references :restaurants, :groups
    end
  end

  def down
  end
end
