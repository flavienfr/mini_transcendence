class War < ApplicationRecord
    has_many :war_participation
    belongs_to :game, optional: true
end
