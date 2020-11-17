class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :channel, optional: true

  validates :text, presence: true, length: {minimum: 1}
end
