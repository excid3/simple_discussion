class ForumPost < ApplicationRecord
  include ForumVotable
  belongs_to :forum_thread, counter_cache: true, touch: true
  belongs_to :user
  has_many :reactions, as: :reactable

  validates :user_id, :body, presence: true

  scope :sorted, ->{ order(:created_at) }
  scope :most_voted_first, -> { joins(:forum_votes).group('forum_posts.id').order('count(forum_votes.id) DESC') }

  after_update :solve_forum_thread, if: :solved?

  def solve_forum_thread
    forum_thread.update(solved: true)
  end
end
