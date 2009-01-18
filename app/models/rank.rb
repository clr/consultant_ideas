class Rank < ActiveRecord::Base
  has_many :idea_rankings, :order => 'position ASC'
  has_many :ideas, :through => :idea_rankings
  belongs_to :user
end
