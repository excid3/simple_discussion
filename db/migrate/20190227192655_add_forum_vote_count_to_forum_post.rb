class AddForumVoteCountToForumPost < ActiveRecord::Migration[4.2]
  def self.up
    add_column :forum_posts, :forum_votable_count, :integer, :default => 0

    ForumPost.reset_column_information
    ForumPost.all.each do |ft|
      ft.update_attribute :forum_votable_count, ft.forum_votes.length
    end
  end

  def self.down
    remove_column :forum_posts, :forum_votable_count
  end
end