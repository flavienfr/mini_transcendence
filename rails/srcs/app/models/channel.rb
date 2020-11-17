class Channel < ApplicationRecord
    has_many :channel_participations, dependent: :nullify
    has_many :users, :through => :channel_participations
    has_many :messages, dependent: :nullify
    has_many :games, dependent: :nullify

    validates :name, presence: true, length: {minimum: 1}
    validates :scope, presence: true, inclusion: { in: ["protected-group", "private-group", "public-group", "direct"] }
end
