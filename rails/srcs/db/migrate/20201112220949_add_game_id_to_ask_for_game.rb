class AddGameIdToAskForGame < ActiveRecord::Migration[6.0]
  def change
    add_column :ask_for_games, :game_id, :integer
  end
end
