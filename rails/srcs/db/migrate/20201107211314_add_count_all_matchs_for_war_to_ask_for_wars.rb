class AddCountAllMatchsForWarToAskForWars < ActiveRecord::Migration[6.0]
  def change
    add_column :ask_for_wars, :count_all_matchs_for_war, :boolean, :default => false
  end
end

class AddCountAllMatchsForWarToWars < ActiveRecord::Migration[6.0]
  def change
    add_column :wars, :count_all_matchs_for_war, :boolean, :default => false
  end
end
