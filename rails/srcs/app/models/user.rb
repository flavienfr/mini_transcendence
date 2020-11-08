class User < ApplicationRecord
    has_many :sessions, dependent: :nullify 
    has_many :channel_participations, dependent: :nullify
    has_many :channels, :through => :channel_participations
    has_many :guild_participations, dependent: :nullify 
    has_many :guilds, :through => :guild_participations
    has_many :game_participations, dependent: :nullify 
    has_many :games, :through => :game_participations
    has_many :tournament_participations, dependent: :nullify 
    has_many :tournaments, :through => :tournament_participations
    has_many :messages, dependent: :nullify 
    has_many :notifications, dependent: :nullify 
    # has_many :friendships, dependent: :nullify 
    has_one_time_password
end
