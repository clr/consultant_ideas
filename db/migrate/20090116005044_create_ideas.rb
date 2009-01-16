class CreateIdeas < ActiveRecord::Migration
  def self.up
    create_table :ideas do |t|
      t.string :name
      t.integer :user_id
      t.text :elevator
      t.text :full
      t.text :marketing

      t.timestamps
    end
  end

  def self.down
    drop_table :ideas
  end
end
