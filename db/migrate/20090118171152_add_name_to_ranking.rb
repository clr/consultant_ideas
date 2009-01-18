class AddNameToRanking < ActiveRecord::Migration
  def self.up
    add_column :rankings, :name, :string
  end

  def self.down
    remove_column :rankings, :name
  end
end
