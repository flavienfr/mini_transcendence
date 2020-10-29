class GuildParticipation < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :guild, optional: false
end
