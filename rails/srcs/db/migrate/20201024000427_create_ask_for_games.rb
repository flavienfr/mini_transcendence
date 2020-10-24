class CreateAskForGames < ActiveRecord::Migration[6.0]
  def change
    create_table :ask_for_games do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :status

      t.timestamps
    end
  end
end
