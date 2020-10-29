class GameParticipation < ApplicationRecord
  belongs_to :user, optional: false
  belongs_to :game, optional: false
end
