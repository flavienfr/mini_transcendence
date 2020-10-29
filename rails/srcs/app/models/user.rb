class User < ApplicationRecord
    # @user.sessions => [ session1 ]
    # @user.sessions.first => session1
    has_many :sessions, dependent: :nullify 
    has_many :channel_participations, dependent: :nullify
    has_many :guild_participations, dependent: :nullify
end
