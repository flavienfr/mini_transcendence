class CreateTournamentParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true
      t.string :status
      t.integer :score
      t.integer :nb_won_game
      t.integer :nb_lose_game

      t.timestamps
    end
  end
end
