class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.int :id
      t.int :votable_id
      t.string :votable_type
      t.int :voter_id
      t.string :voter_type
      t.string :vote_flag
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
