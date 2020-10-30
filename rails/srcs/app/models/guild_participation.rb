class GuildParticipation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :guild, optional: true
end
