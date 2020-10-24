class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.integer :user1_id
      t.integer :user2_id
      t.string :status

      t.timestamps
    end
  end
end
