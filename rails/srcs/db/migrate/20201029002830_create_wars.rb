class CreateWars < ActiveRecord::Migration[6.0]
  def change
    create_table :wars do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :prize_in_points
      t.integer :max_unanswered_call
      t.integer :winner_id
      t.string :status

      t.timestamps
    end
  end
end
