class AddWarParticipationToGuilds < ActiveRecord::Migration[6.0]
  def change
    add_reference :guilds, :war_participation, null: true, foreign_key: true
  end
end
