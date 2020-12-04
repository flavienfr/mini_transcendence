class Tournament < ApplicationRecord
    has_many :tournament_participations, dependent: :nullify
    has_many :users, :through => :tournament_participations
    has_many :games, dependent: :nullify

    validates :rules, presence: true, length: {minimum: 1, maximum: 25}, format: {with: /\A[A-Za-z0-9 ]+\z/}
    validates :deadline, presence: true
    validates :status, presence: true
    validates :max_nb_player, presence: true, numericality: {greater_than: 0, less_than_or_equal_to: 16, only_integer: true}
    validates :incentives, length: {minimum: 1, maximum: 25}, format: {with: /\A[A-Za-z0-9 ]+\z/}, uniqueness: {case_insensitive: false}, allow_blank: true
end
