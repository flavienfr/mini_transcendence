class Achievement < ApplicationRecord
    belongs_to :users, optional: true
end
