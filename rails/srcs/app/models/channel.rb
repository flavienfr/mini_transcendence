class Channel < ApplicationRecord
    has_many :messages
    has_many :users
    has_many :channel_participations
    belongs_to :game, optional: true
end
