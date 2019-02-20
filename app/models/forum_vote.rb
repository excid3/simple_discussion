class ForumVote < ApplicationRecord
  belongs_to :user
  belongs_to :forum_votable, polymorphic: true
end
