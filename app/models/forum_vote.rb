class ForumVote < ApplicationRecord
  belongs_to :user
  belongs_to :forum_votable, polymorphic: true, counter_cache: :forum_votable_count
  validates :user_id, uniqueness: { scope: [:forum_votable_type, :forum_votable_id], message: "only one vote per user is allowed for each votable" }
end
