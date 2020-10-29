class AddWarTimeToGame < ActiveRecord::Migration[6.0]
  def change
    add_reference :games, :war_time, null: true, foreign_key: true
  end
end
