class War < ApplicationRecord
    has_many :war_participations, dependent: :nullify
    #has_many :guilds, :through => :war_participations
    has_many :games, dependent: :nullify
    has_many :war_times, dependent: :nullify
end
