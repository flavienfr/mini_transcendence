class War < ApplicationRecord
    has_many :war_participations, dependent: :nullify
    #has_many :guilds, :through => :war_participations
    has_many :games, dependent: :nullify
    has_many :war_times, dependent: :nullify

    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :prize_in_points, presence: true, format: {with: /\A^[0-9]*$\z/}
    validates :max_unanswered_call, presence: true, format: {with: /\A^[0-9]*$\z/}
end
