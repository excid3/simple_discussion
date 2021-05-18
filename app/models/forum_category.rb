class ForumCategory < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  scope :sorted, -> { order(name: :asc) }

  validates :name, :slug, :color, presence: true

  validates :slug, uniqueness: true
  validates :name, uniqueness: true

  def color
    colour = super
    colour.start_with?("#") ? colour : "##{colour}"
  end
end
