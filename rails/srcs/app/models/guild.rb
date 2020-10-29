class Guild < ApplicationRecord
    has_many :users, dependent: :nullify
    has_many :war_participations, dependent: :nullify
end
