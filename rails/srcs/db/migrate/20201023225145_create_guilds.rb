class CreateGuilds < ActiveRecord::Migration[6.0]
  def change
    create_table :guilds do |t|
      t.string :name
      t.string :anagram
      t.integer :points
      t.boolean :is_making_war
      t.integer :owner_id

      t.timestamps
    end
  end
end
