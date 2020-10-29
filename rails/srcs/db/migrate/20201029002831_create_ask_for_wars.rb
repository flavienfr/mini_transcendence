class CreateAskForWars < ActiveRecord::Migration[6.0]
  def change
    create_table :ask_for_wars do |t|
      t.integer :from_guild_id
      t.integer :to_guild_id
      t.text :terms
      t.boolean :includes_ladder
      t.references :war, null: true, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
