class User < ApplicationRecord
    has_many :sessions, dependent: :nullify 
    has_many :channel_participations, dependent: :nullify
    has_many :guild_participations, dependent: :nullify 
    has_many :game_participations, dependent: :nullify 
    has_many :tournament_participations, dependent: :nullify 
    has_many :messages, dependent: :nullify 
end
