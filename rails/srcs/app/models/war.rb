class War < ApplicationRecord
    has_many :war_participation, dependent: :nullify
    has_many :guilds, :through => :war_participations
    has_many :games, dependent: :nullify
end
