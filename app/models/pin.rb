class Pin < ApplicationRecord
  belongs_to :user
  belongs_to :forum_thread
end
