class Game < ApplicationRecord
    has_many :game_participations
    has_many :channels, dependent: :nullify
    has_many :wars, dependent: :nullify
    has_many :war_times, dependent: :nullify
    has_many :tournaments, dependent: :nullify
end
