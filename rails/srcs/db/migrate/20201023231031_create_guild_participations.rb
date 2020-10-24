class CreateGuildParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :guild_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :guild, null: false, foreign_key: true
      t.boolean :is_admin
      t.boolean :is_officer

      t.timestamps
    end
  end
end
