class Guild < ApplicationRecord
    has_many :guild_participations, dependent: :nullify
    has_many :users, :through => :guild_participations
    has_many :war_participations, dependent: :nullify
    has_many :wars, :through => :war_participations

    validates :name, presence: true, length: {minimum: 3, maximum: 25}, format: {with: /\A^[A-Za-z0-9 ]*$\z/}
    validates :anagram, presence: true, length: {minimum: 2, maximum: 5}, format: {with: /\A^[A-Za-z0-9]*$\z/}
end
