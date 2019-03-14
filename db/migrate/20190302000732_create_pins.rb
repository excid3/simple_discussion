class CreatePins < ActiveRecord::Migration[5.0]
  def change
    create_table :pins do |t|
      t.references :user, foreign_key: true
      t.references :forum_thread, foreign_key: true

      t.timestamps
    end
  end
end
