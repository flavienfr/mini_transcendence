class WarTime < ApplicationRecord
  belongs_to :war, optional: false
  belongs_to :game, optional: true
end
