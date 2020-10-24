class CreateChannels < ActiveRecord::Migration[6.0]
  def change
    create_table :channels do |t|
      t.string :name
      t.string :scope
      t.string :password
      t.integer :owner_id

      t.timestamps
    end
  end
end
