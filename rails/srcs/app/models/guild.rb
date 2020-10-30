class Guild < ApplicationRecord
    has_many :war_participations, dependent: :nullify
end
