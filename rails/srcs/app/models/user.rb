class User < ApplicationRecord
    has_one :sessions, dependent: :nullify 
    has_many :channel_participations, dependent: :nullify
    has_many :guild_participation, dependent: :nullify 
end
