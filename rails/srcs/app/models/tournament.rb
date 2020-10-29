class Tournament < ApplicationRecord
    belongs_to :game, optional: true
end
