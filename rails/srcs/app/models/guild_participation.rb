class GuildParticipation < ApplicationRecord
  belongs_to :user
  belongs_to :guild
end
