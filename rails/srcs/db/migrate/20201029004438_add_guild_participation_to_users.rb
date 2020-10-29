class AddGuildParticipationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :guild_participation, null: true, foreign_key: true
  end
end
