class Channel < ApplicationRecord
    has_many :channel_participations, dependent: :nullify
    has_many :users, :through => :channel_participations
    has_many :messages, dependent: :nullify
    # belongs_to :game, optional: true
end
