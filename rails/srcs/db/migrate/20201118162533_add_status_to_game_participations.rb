class AddStatusToGameParticipations < ActiveRecord::Migration[6.0]
  def change
    add_column :game_participations, :status, :string
  end
end
