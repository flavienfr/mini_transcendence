class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.integer :to_channel_id
      t.integer :to_guild_id
      t.string :type
      t.string :message
      t.string :status

      t.timestamps
    end
  end
end
