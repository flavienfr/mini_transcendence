class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :contex
      t.integer :winner_id

      t.timestamps
    end
  end
end
