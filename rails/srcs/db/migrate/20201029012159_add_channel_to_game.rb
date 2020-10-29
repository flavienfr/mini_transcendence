class AddChannelToGame < ActiveRecord::Migration[6.0]
  def change
    add_reference :games, :channel, null: true, foreign_key: true
  end
end
