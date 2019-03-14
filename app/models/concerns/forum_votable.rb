require 'active_support/concern'

module ForumVotable
  extend ActiveSupport::Concern

  included do
    has_many :forum_votes, as: :forum_votable

    scope :most_voted_first, -> { order('forum_votable_count DESC') }
  end

  def voted_by?(user)
    forum_votes.exists?(user: user)
  end

  def vote_count
    forum_votes.count
  end
end