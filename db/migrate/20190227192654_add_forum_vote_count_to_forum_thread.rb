class AddForumVoteCountToForumThread < ActiveRecord::Migration[4.2]
  def self.up
    add_column :forum_threads, :forum_votable_count, :integer, :default => 0

    ForumThread.reset_column_information
    ForumThread.all.each do |ft|
      ft.update_attribute :forum_votable_count, ft.forum_votes.length
    end
  end

  def self.down
    remove_column :forum_threads, :forum_votable_count
  end
end