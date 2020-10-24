class CreateGameParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :game_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.integer :score
      t.boolean :is_winner

      t.timestamps
    end
  end
end
