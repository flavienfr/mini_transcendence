class CreateWarParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :war_participations do |t|
      t.references :guild, null: true, foreign_key: true
      t.references :war, null: true, foreign_key: true
      t.integer :war_points
      t.boolean :has_declared_war
      t.integer :nb_unanswered_call
      t.boolean :is_winner
      t.string :status

      t.timestamps
    end
  end
end
