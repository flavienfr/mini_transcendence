class User < ApplicationRecord
    has_many :sessions, dependent: :nullify
    has_many :channel_participations, dependent: :nullify
    has_many :guild_participations, dependent: :nullify
end
