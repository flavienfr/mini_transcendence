class AddCountAllMatchsForWarToWar < ActiveRecord::Migration[6.0]
  def change
    add_column :wars, :count_all_matchs_for_war, :boolean, :default => false
  end
end