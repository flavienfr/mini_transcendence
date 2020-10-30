class Guild < ApplicationRecord
    has_many :guild_participations, dependent: :nullify
    has_many :war_participations, dependent: :nullify
end
