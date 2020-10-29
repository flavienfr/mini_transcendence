class Channel < ApplicationRecord
    has_many :messages
    has_many :users
    belongs_to :game, optional: true
end
