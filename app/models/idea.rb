class Idea < ActiveRecord::Base
  belongs_to :user
  has_many   :comments
  has_many   :idea_rankings
end
