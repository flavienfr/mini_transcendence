class CreateWarTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :war_times do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.boolean :ongoing_match
      t.integer :a
      t.integer :b
      t.integer :nb_unanswered_call_a
      t.integer :nb_unanswered_call_b
      t.references :war, null: true, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
