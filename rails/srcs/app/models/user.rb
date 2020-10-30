class User < ApplicationRecord
    has_many :sessions, dependent: :nullify 
    has_many :channel_participations, dependent: :nullify
    # has_many :guild_participations, dependent: :nullify
    belongs_to :guild_participation, optional: true
end
