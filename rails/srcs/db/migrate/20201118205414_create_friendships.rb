class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.references :sender
      t.references :recipient
      t.string :status

      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :sender_id, primary_key: :id
    add_foreign_key :friendships, :users, column: :recipient_id, primary_key: :id
  end
end
