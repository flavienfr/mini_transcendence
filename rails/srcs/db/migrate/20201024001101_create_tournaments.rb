class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :rules
      t.string :incentives
      t.string :status
      t.datetime :deadline

      t.timestamps
    end
  end
end
