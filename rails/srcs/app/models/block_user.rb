class BlockUser < ApplicationRecord
  belongs_to :user, optional: true
end
