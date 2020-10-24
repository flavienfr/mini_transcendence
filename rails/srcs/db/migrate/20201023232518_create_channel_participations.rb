class CreateChannelParticipations < ActiveRecord::Migration[6.0]
  def change
    create_table :channel_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :channel, null: false, foreign_key: true
      t.boolean :is_owner
      t.boolean :is_admin
      t.string :status

      t.timestamps
    end
  end
end
