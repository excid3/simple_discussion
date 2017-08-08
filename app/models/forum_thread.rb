class ForumThread < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :forum_category
  belongs_to :user
  has_many :forum_posts
  has_many :forum_subscriptions
  has_many :optin_subscribers,  ->{ where(forum_subscriptions: { subscription_type: :optin }) },  through: :forum_subscriptions, source: :user
  has_many :optout_subscribers, ->{ where(forum_subscriptions: { subscription_type: :optout }) }, through: :forum_subscriptions, source: :user
  has_many :users, through: :forum_posts

  accepts_nested_attributes_for :forum_posts

  validates :forum_category, presence: true
  validates :user_id, :title, presence: true
  validates_associated :forum_posts

  scope :pinned_first, ->{ order(pinned: :desc) }
  scope :solved,       ->{ where(solved: true) }
  scope :sorted,       ->{ order(updated_at: :desc) }
  scope :unpinned,     ->{ where.not(pinned: true) }
  scope :unsolved,     ->{ where.not(solved: true) }

  def subscribed_users
    (users + optin_subscribers).uniq - optout_subscribers
  end

  def subscription_for(user)
    return nil if user.nil?
    forum_subscriptions.find_by(user_id: user.id)
  end

  def subscribed?(user)
    return false if user.nil?

    subscription = subscription_for(user)

    if subscription.present?
      subscription.subscription_type == "optin"
    else
      forum_posts.where(user_id: user.id).any?
    end
  end

  def toggle_subscription(user)
    subscription = subscription_for(user)

    if subscription.present?
      subscription.toggle!
    elsif forum_posts.where(user_id: user.id).any?
      forum_subscriptions.create(user: user, subscription_type: "optout")
    else
      forum_subscriptions.create(user: user, subscription_type: "optin")
    end
  end

  def subscribed_reason(user)
    return "You’re not receiving notifications from this thread." if user.nil?

    subscription = subscription_for(user)

    if subscription.present?
      if subscription.subscription_type == "optout"
        "You're ignoring this thread."
      elsif subscription.subscription_type == "optin"
        "You're receiving notifications because you've subscribed to this thread."
      end
    elsif forum_posts.where(user_id: user.id).any?
      "You're receiving notifications because you've posted in this thread."
    else
      "You're not receiving notifications from this thread."
    end
  end
end
