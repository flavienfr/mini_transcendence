class Tournament < ApplicationRecord
    has_many :tournament_participations, dependent: :nullify
    has_many :users, :through => :tournament_participations
    has_many :games, dependent: :nullify

    validates :rules, presence: true, length: {minimum: 1}
    validates :incentives, length: {minimum: 1}, uniqueness: {case_insensitive: false}, allow_blank: true
end
