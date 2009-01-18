class CreateRanks < ActiveRecord::Migration
  def self.up
    drop_table :rankings
    create_table :ranks do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
    remove_column :idea_rankings, :ranking_id
    add_column    :idea_rankings, :rank_id, :integer
  end

  def self.down
    drop_table :ranks
    create_table :rankings do |t|
      t.integer :user_id

      t.timestamps
    end
    remove_column :idea_rankings, :rank_id
    add_column    :idea_rankings, :ranking_id, :integer
  end
end
