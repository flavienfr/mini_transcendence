class AddRanksToGuildParticipations < ActiveRecord::Migration[6.0]
  def change
    change_column :guild_participations, :is_admin, :boolean, :default => false
    change_column :guild_participations, :is_officer, :boolean, :default => false
    add_column :guild_participations, :is_veteran, :boolean, :default => false
    add_column :guild_participations, :is_initiate, :boolean, :default => true
  end
end
