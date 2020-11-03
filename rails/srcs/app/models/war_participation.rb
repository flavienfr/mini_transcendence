class WarParticipation < ApplicationRecord
  belongs_to :guild, optional: true
  belongs_to :war, optional: true
end
