class WarParticipation < ApplicationRecord
  belongs_to :guild, optional: false
  belongs_to :war, optional: false
end
