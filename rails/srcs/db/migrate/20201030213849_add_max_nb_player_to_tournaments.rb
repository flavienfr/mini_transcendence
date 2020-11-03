class AddMaxNbPlayerToTournaments < ActiveRecord::Migration[6.0]
  def change
    add_column :tournaments, :max_nb_player, :integer
  end
end
