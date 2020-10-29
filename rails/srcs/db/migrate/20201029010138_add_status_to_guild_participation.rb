class AddStatusToGuildParticipation < ActiveRecord::Migration[6.0]
  def change
    add_column :guild_participations, :status, :string
  end
end
