class AddNbWonTournamentsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :nb_won_tournaments, :integer, :default => 0
    add_column :users, :ladder_level, :integer, :default => 0
  end
end
