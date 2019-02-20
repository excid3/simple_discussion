module ForumVotable
  extend ActiveSupport::Concern

  included do
    has_many :forum_votes, as: :forum_votable
  end

  def voted_by?(user)
    forum_votes.exists?(user: user)
  end

  def vote_count
    forum_votes.count
  end
end