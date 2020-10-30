class WarTime < ApplicationRecord
  belongs_to :war, optional: true
  has_many :games, dependent: :nullify
end
