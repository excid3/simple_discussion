module SimpleDiscussion
  module ForumUser
    extend ActiveSupport::Concern

    included do
      has_many :forum_threads, dependent: :destroy
      has_many :forum_posts, dependent: :destroy
      has_many :forum_subscriptions, dependent: :destroy
      has_many :pins, dependent: :destroy
    end
  end
end
