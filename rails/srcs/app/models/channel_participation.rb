class ChannelParticipation < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :channel, optional: false
end
