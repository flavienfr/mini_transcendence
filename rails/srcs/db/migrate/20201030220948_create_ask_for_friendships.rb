class CreateAskForFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :ask_for_friendships do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.references :friendship, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
