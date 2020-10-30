class WarTime < ApplicationRecord
  belongs_to :war, optional: true
  belongs_to :game, optional: true
end
