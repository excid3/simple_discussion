class AddAncestryToForumPosts < ActiveRecord::Migration[4.2]
  def self.up
    add_column :forum_posts, :ancestry, :string
    add_index :forum_posts, :ancestry
  end

  def self.down
    remove_index :forum_posts, :ancestry
    remove_column :forum_posts, :ancestry
  end
end
