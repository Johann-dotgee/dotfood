class ActsAsVotableMigration < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|

      t.references :votable, :polymorphic => true
      t.references :voter, :polymorphic => true

      t.boolean :vote_flag

      t.date :created_at
      t.date :updated_at
    end

  end

  def self.down
    drop_table :votes
  end
end