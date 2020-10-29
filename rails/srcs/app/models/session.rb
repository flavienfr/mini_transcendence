class Session < ApplicationRecord
  belongs_to :user, optional: false
end
