class TournamentParticipation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :tournament, optional: true

  def state_of_tournament(id_tournament, winner_part_id)
    update_tournament(winner_part_id)
  end
end
