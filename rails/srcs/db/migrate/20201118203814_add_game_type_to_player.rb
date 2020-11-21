class AddGameTypeToPlayer < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :game_type, :string
  end
end
