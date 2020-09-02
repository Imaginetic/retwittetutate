class CreateFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :friends do |t|
      t.integer :friend_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
