class User < ApplicationRecord
    has_many :sessions, dependent: :nullify
    has_many :channel_participations
end
