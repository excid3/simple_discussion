class CreateForumVotes < ActiveRecord::Migration[4.2]
  def change
    create_table :forum_votes, force: :cascade do |t|
      t.references :user, foreign_key: true
      t.integer :forum_votable_id
      t.string :forum_votable_type

      t.timestamps
    end
  end
end