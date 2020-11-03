class Tournament < ApplicationRecord
    has_many :tournament_participations, dependent: :nullify
    has_many :users, :through => :tournament_participations
    has_many :games, dependent: :nullify
end
