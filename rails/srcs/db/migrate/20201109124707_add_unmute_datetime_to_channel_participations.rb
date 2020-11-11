class AddUnmuteDatetimeToChannelParticipations < ActiveRecord::Migration[6.0]
  def change
    add_column :channel_participations, :unmute_datetime, :datetime
  end
end
