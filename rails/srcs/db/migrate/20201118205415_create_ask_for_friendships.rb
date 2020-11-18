class CreateAskForFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :ask_for_friendships do |t|
      t.references :friendship, null: true, foreign_key: true
      t.references :sender
      t.references :recipient
      t.string :status

      t.timestamps
    end
    add_foreign_key :ask_for_friendships, :users, column: :sender_id, primary_key: :id
    add_foreign_key :ask_for_friendships, :users, column: :recipient_id, primary_key: :id
  end
end
