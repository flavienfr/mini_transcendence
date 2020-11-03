class Game < ApplicationRecord
    has_many :game_participations, dependent: :nullify
    has_many :users, :through => :game_participations
    belongs_to :channel, optional: true
    belongs_to :war, optional: true
    belongs_to :war_time, optional: true
    belongs_to :tournament, optional: true
end
