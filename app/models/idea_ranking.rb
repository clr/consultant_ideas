class IdeaRanking < ActiveRecord::Base
  belongs_to   :idea
  belongs_to   :rank
  acts_as_list :scope => :rank
end
