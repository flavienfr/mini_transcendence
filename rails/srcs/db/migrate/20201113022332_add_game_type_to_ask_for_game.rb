class AddGameTypeToAskForGame < ActiveRecord::Migration[6.0]
  def change
    add_column :ask_for_games, :game_type, :string
  end
end
