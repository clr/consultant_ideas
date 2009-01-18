class CreateIdeaRankings < ActiveRecord::Migration
  def self.up
    create_table :idea_rankings do |t|
      t.integer :ranking_id
      t.integer :idea_id
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :idea_rankings
  end
end
